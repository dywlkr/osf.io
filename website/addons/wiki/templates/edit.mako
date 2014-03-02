<%inherit file="base.mako"/>
<%def name="title()">Edit Wiki</%def>
<%def name="content()">
<div mod-meta='{"tpl": "project/project_header.mako", "replace": true}'></div>

<div class="wiki">
    <div class="row">
        <div class="col-md-9">
            <form action="${node['url']}wiki/${pageName}/edit/" method="POST">
                <div class="form-group wmd-panel">
                    <div id="wmd-button-bar"></div>
                    <textarea class="form-control wmd-input" rows="25" id="wmd-input" name="content">${wiki_content}</textarea>
                </div>
                <input type="submit" class="btn btn-primary pull-right" value="Save">
                <p class="help-block">Preview</p>
                <div id="wmd-preview" class="wmd-panel wmd-preview"></div>
            </form>
        </div>
        <div class="col-md-3">
            <div>
                <%include file="wiki/templates/nav.mako" />
                <%include file="wiki/templates/history.mako" />
            </div>
        </div>
    </div><!-- end row -->
</div><!-- end wiki -->
</%def>

<%def name="javascript_bottom()">
    <script>
        $script(['/static/vendor/pagedown/Markdown.Converter.js',
            '/static/vendor/pagedown/Markdown.Sanitizer.js',
            '/static/vendor/pagedown/Markdown.Editor.js'
        ], 'markdown');

        $script(['markdown'], function () {
            var converter1 = Markdown.getSanitizingConverter();
            var editor1 = new Markdown.Editor(converter1);
            editor1.run();
        });
    </script>
</%def>
