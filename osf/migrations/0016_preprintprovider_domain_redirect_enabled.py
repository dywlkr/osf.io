# -*- coding: utf-8 -*-
# Generated by Django 1.9 on 2017-04-19 18:12
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('osf', '0015_preprintprovider_domain'),
    ]

    operations = [
        migrations.AddField(
            model_name='preprintprovider',
            name='domain_redirect_enabled',
            field=models.BooleanField(default=False),
        ),
    ]