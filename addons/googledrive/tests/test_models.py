# -*- coding: utf-8 -*-
import mock
from nose.tools import *  # noqa (PEP8 asserts)
import pytest
import unittest

from framework.auth import Auth
from addons.base.tests.models import (OAuthAddonNodeSettingsTestSuiteMixin,
                                      OAuthAddonUserSettingTestSuiteMixin)

from addons.googledrive.models import NodeSettings, GoogleDriveProvider
from addons.googledrive.client import GoogleAuthClient
from addons.googledrive.tests.factories import (
    GoogleDriveAccountFactory,
    GoogleDriveNodeSettingsFactory,
    GoogleDriveUserSettingsFactory
)

pytestmark = pytest.mark.django_db

class TestGoogleDriveProvider(unittest.TestCase):
    def setUp(self):
        super(TestGoogleDriveProvider, self).setUp()
        self.provider = GoogleDriveProvider()

    @mock.patch.object(GoogleAuthClient, 'userinfo')
    def test_handle_callback(self, mock_client):
        fake_response = {'access_token': 'abc123'}
        fake_info = {'sub': '12345', 'name': 'fakename', 'profile': 'fakeUrl'}
        mock_client.return_value = fake_info
        res = self.provider.handle_callback(fake_response)
        assert_equal(res['provider_id'], '12345')
        assert_equal(res['display_name'], 'fakename')
        assert_equal(res['profile_url'], 'fakeUrl')

class TestUserSettings(OAuthAddonUserSettingTestSuiteMixin, unittest.TestCase):

    short_name = 'googledrive'
    full_name = 'Google Drive'
    ExternalAccountFactory = GoogleDriveAccountFactory


class TestNodeSettings(OAuthAddonNodeSettingsTestSuiteMixin, unittest.TestCase):

    short_name = 'googledrive'
    full_name = 'Google Drive'
    ExternalAccountFactory = GoogleDriveAccountFactory

    NodeSettingsFactory = GoogleDriveNodeSettingsFactory
    NodeSettingsClass = NodeSettings
    UserSettingsFactory = GoogleDriveUserSettingsFactory

    def setUp(self):
        self.mock_refresh = mock.patch.object(
            GoogleDriveProvider,
            'refresh_oauth_key'
        )
        self.mock_refresh.return_value = True
        self.mock_refresh.start()
        super(TestNodeSettings, self).setUp()

    def tearDown(self):
        self.mock_refresh.stop()
        super(TestNodeSettings, self).tearDown()

    @mock.patch('addons.googledrive.models.GoogleDriveProvider')
    def test_api_not_cached(self, mock_gdp):
        # The first call to .api returns a new object
        api = self.node_settings.api
        mock_gdp.assert_called_once()
        assert_equal(api, mock_gdp())

    @mock.patch('addons.googledrive.models.GoogleDriveProvider')
    def test_api_cached(self, mock_gdp):
        # Repeated calls to .api returns the same object
        self.node_settings._api = 'testapi'
        api = self.node_settings.api
        assert_false(mock_gdp.called)
        assert_equal(api, 'testapi')

    def test_selected_folder_name_root(self):
        self.node_settings.folder_id = 'root'

        assert_equal(
            self.node_settings.selected_folder_name,
            "Full Google Drive"
        )

    def test_selected_folder_name_empty(self):
        self.node_settings.folder_id = None

        assert_equal(
            self.node_settings.selected_folder_name,
            ''
        )

    ## Overrides ##

    def test_set_folder(self):
        folder = {
            'id': 'fake-folder-id',
            'name': 'fake-folder-name',
            'path': 'fake_path'
        }
        self.node_settings.set_folder(folder, auth=Auth(self.user))
        self.node_settings.save()
        # Folder was set
        assert_equal(self.node_settings.folder_id, folder['id'])
        # Log was saved
        last_log = self.node.logs.latest()
        assert_equal(last_log.action, '{0}_folder_selected'.format(self.short_name))

    def test_serialize_settings(self):
        settings = self.node_settings.serialize_waterbutler_settings()
        expected = {
            'folder':
            {
                'id': self.node_settings.folder_id,
                'name': self.node_settings.folder_name,
                'path': self.node_settings.folder_path,
            }
        }
        assert_equal(settings, expected)
