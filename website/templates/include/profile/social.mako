<script id="profileSocial" type="text/html">

    <div data-bind="if: mode() === 'edit'">
        <% from website import settings %>
        <form role="form" data-bind="submit: submit">
        <div   class = "panel panel-default" >
            <div class="panel-heading">
                <label class="panel-title">Websites</label>
                <a class="pull-right" data-bind="click: editWebsiteButton">
                    Edit
                </a>
            </div>
            <div data-bind="sortable: {
                        data: profileWebsites,
                        options: {
                            handle: '.sort-handle',
                            containment: '#containDrag'
                        }
                    }">
                <div class="sort-handle">
                    <i class="btn text-danger pull-right  fa fa-times fa-lg"  data-bind="click: $parent.canRemove(),
                        visible: $parent.canEditWebsite()"></i>
                   
                    <div class="input-group" >

                        <span class="input-group-addon" data-bind="visible: $parent.canEditWebsite()"> 
                            <i class="fa fa-bars"></i>
                        </span>
                        <span class="input-group-addon"><i class="glyphicon glyphicon-globe"></i></span>
                        <input class="form-control" data-bind="value: $parent.profileWebsites()[$index()]" placeholder="http://yourwebsite.com"/>
                    </div>

                </div>

                <div class="form-group" data-bind="visible: $index() != ($parent.profileWebsites().length - 1)"></div>  

            </div>
            <div class="padded" data-bind="visible: !profileWebsiteEmpty()">
                <a class="btn btn-default" data-bind="click: addWebsite">
                    Add another
                </a>
            </div>
        </div>

     
            <div class="padded">
                
                <div class="form-group">
                    <label>ORCID</label>
                    <div class="input-group">
                    <span class="input-group-addon">http://orcid.org/</span>
                    <input class="form-control" data-bind="value: orcid" placeholder="xxxx-xxxx-xxxx-xxxx"/>
                    </div>
                </div>

                <div class="form-group">
                    <label>ResearcherID</label>
                    <div class="input-group">
                    <span class="input-group-addon">http://researcherid.com/rid/</span>
                    <input class="form-control" data-bind="value: researcherId" placeholder="x-xxxx-xxxx" />
                    </div>
                </div>

                <div class="form-group">
                    <label>Twitter</label>
                    <div class="input-group">
                    <span class="input-group-addon">@</span>
                    <input class="form-control" data-bind="value: twitter" placeholder="twitterhandle"/>
                    </div>
                </div>

                <div class="form-group">
                    <label>GitHub</label>
                    <div class="input-group">
                    <span class="input-group-addon">https://github.com/</span>
                    <div data-bind="css: {'input-group': github.hasAddon()}">
                        <input class="form-control" data-bind="value: github" placeholder="username"/>
                        <span
                                class="input-group-btn"
                                data-bind="if: github.hasAddon()"
                            >
                            <button
                                    class="btn btn-default"
                                    data-bind="click: github.importAddon"
                                >Import</button>
                        </span>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label>LinkedIn</label>
                    <div class="input-group">
                    <span class="input-group-addon">https://www.linkedin.com/profile/view?id=</span>
                    <input class="form-control" data-bind="value: linkedIn" placeholder="profileID"/>
                    </div>
                </div>

                <div class="form-group">
                    <label>ImpactStory</label>
                    <div class="input-group">
                    <span class="input-group-addon">https://impactstory.org/</span>
                    <input class="form-control" data-bind="value: impactStory" placeholder="profileID"/>
                    </div>
                </div>

                <div class="form-group">
                    <label>Google Scholar</label>
                    <div class="input-group">
                    <span class="input-group-addon">http://scholar.google.com/citations?user=</span>
                    <input class="form-control" data-bind="value: scholar" placeholder="profileID"/>
                    </div>
                </div>
                </div>

            <div class="padded">

                <button
                        type="button"
                        class="btn btn-default"
                        data-bind="click: cancel"
                    >Cancel</button>

                <button
                        type="submit"
                        class="btn btn-primary"
                    >Submit</button>

            </div>


            <!-- Flashed Messages -->
            <div class="help-block">
                <p data-bind="html: message, attr.class: messageClass"></p>
            </div>

        </form>

    </div>

    <div data-bind="if: mode() === 'view'">


         <table class="table" data-bind="if: hasValues()">
            <tbody>
                <tr data-bind="if: hasProfileWebsites()">
                    <td>Profile Websites</td>
                    <td data-bind="foreach: profileWebsites"><a target="_blank" data-bind="attr.href: $data">{{ $data }}</a></br></td>
                </tr>
            </tbody>

            <tbody data-bind="foreach: values">
                <tr data-bind="if: value">
                    <td>{{ label }}</td>
                    <td><a target="_blank" data-bind="attr.href: value">{{ text }}</a></td>
                </tr>
            </tbody>
         </table>

        <div data-bind="ifnot: hasValues()">
            <div class="well well-sm">Not provided</div>
        </div>

        <div data-bind="if: editAllowed">
            <a class="btn btn-default" data-bind="click: edit">Edit</a>
        </div>

    </div>

</script>