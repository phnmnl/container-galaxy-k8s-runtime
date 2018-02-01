<!DOCTYPE HTML>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>${hda.name | h} | ${visualization_name}</title>
    <%
        # Use root for resource loading.
        root = h.url_for( '/' )
    %>

## ----------------------------------------------------------------------------
${h.css( 'base', 'jquery-ui/smoothness/jquery-ui')}
${h.stylesheet_link( root + 'plugins/visualizations/isa/static/css/ISATabViewer.css' )}

## ----------------------------------------------------------------------------
<script type="text/javascript">
// TODO: blah
window.Galaxy = { root: '${ root }' };
</script>
${h.js( 'libs/jquery/jquery',
        'libs/jquery/jquery.migrate',
        'libs/jquery/jquery-ui',
        'libs/bootstrap',
        'libs/underscore',
        'libs/backbone',
        'libs/d3',
        'ui/peek-column-selector',
        'ui/pagination',
        'mvc/visualization/visualization-model' )}

${h.javascript_link( root + 'plugins/visualizations/isa/static/js/ISATabViewer.js' )}

<script type="text/javascript">
function getModel(){
    return new ScatterplotModel({
        id      : ${h.dumps( visualization_id )} || undefined,
        title   : "${title or default_title}",
        config  : ${h.dumps( config, indent=2 )}
    });
}
function getHDAJSON(){
    return ${h.dumps( trans.security.encode_dict_ids( hda.to_dict() ), indent=2 )};
}
</script>



</head>
<body>

<div id="investigation_file" class="isa-view">

    <!-- Load from gist -->
    <div class="toolbar">
        Load ISA-Tab file to view <input type="text" name="gist" id="gist_id"><span class="btn btn-green"
                                                                                    onclick="load_file()">Load File</span>

        <div style="float: right; margin-right: 25px; margin-top: 3px" id="download-button">
        </div>
    </div>
    <!-- end of load from gist -->

    <div class="isa-study-list">
        <h3>ISA-Tab files</h3>
        <ul id="study-list">
        </ul>
    </div>

    <div class="isa-main-view">
        <div class="isa-breadcrumbs">
            <ul id="isa-breadcrumb-items">
            </ul>
        </div>
        <div class="cf"></div>
        <div id="study-info"></div>
    </div>
</div>

<link href="static/css/ISATabViewer.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="static/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="static/js/handlebars-v1.3.0.js"></script>
<script type="text/javascript" src="static/js/ISATabViewer.js"></script>


<!-- <link href="isaviewer_assets/css/ISATabViewer.css" rel="stylesheet" type="text/css"/>-->
<!-- <script type="text/javascript" src="isaviewer_assets/js/jquery-1.11.1.min.js"></script>-->
<!-- <script type="text/javascript" src="isaviewer_assets/js/handlebars-v1.3.0.js"></script>-->
<!-- <script type="text/javascript" src="isaviewer_assets/js/ISATabViewer.js"></script>-->


<script type="text/javascript">
     ISATabViewer.rendering.render_isatab_from_gist('c3c4306af5916856c607', '#investigation_file', {});

//    ISATabViewer.rendering.render_isatab_from_file('test_data_sets/BII-S-3/i_gilbert.txt', '#investigation_file', {});
//    ISATabViewer.rendering.render_isatab_from_file('test_data_sets/BII-I-1/i_investigation.txt', '#investigation_file', {});
//    ISATabViewer.rendering.render_isatab_from_file('test_data_sets/E.carvenicolus-GiGaDB-ISA-tab/i_investigation_100063.txt', '#investigation_file', {});
//    ISATabViewer.rendering.render_isatab_from_file('test_data_sets/sdata201513-isa1/i_Investigation.txt', '#investigation_file', {});
//    ISATabViewer.rendering.render_isatab_from_file('test_data_sets/sdata201411-isa1/i_investigation.txt', '#investigation_file', {});
</script>

<script id="study-list-template" type="text/x-handlebars-template">

    <dl>
       <!-- <dt>
            <h4 onclick="ISATabViewer.rendering.render_investigation()">Investigation {{this.investigation_id}}</h4>
        </dt>
        <dd>
        -->
        {{#each studies}}
        <li id="list-{{this.hash}}" onclick="ISATabViewer.rendering.render_study('{{this.id}}', '{{this.hash}}')">
        {{this.id}}
        </li>
        {{/each}}
        </dd>
    </dl>

</script>

<script id="table-template" type="text/x-handlebars-template">

    <table id="assay-table" class="table table-hover">
        <thead>
        <tr>
            {{#each headers}}
            <th>{{this}}</th>
            {{/each}}
        </thead>
        </tr>
        <tbody>
        {{#each rows}}
        <tr>
            {{#each columns}}
            <td>{{this}}</td>
            {{/each}}
        </tr>
        {{/each}}
        </tbody>
    </table>

</script>

<script id="sample-distribution-template" type="text/x-handlebars-template">
    <ul id="sample_stats">
        {{#each sample_stats}}
        <li>
            <p class="characteristic_type">{{name}}</p>
            {{#each distribution}}
            <div class="distribution-group">
                <div class="distribution">{{name}}</div>
                <div class="distribution-value"><span>{{value}}</span></div>
            </div>
            <div class="cf"></div>
            {{/each}}
        </li>

        {{/each}}
    </ul>
</script>

<script id="investigation-template" type="text/x-handlebars-template">

    <div id="investigation-title">{{investigation_title}}</div>
    <div id="investigation-description">{{investigation_description}}</div>

    <div class="cf"></div>
    <br/>

    <div id="investigation-contacts">

        <span class="section-header">Contacts</span>
        <ul>
            {{#each contacts}}
            <li>
                <p class="investigation-contact">{{[Investigation Person First Name]}} {{[Investigation Person Last Name]}}</p>

                <p class="investigation-contact-address">{{[Investigation Person Address]}}</p>

                <p class="investigation-contact-affiliation">{{[Investigation Person Affiliation]}}</span></p>
            </li>
            {{/each}}
        </ul>
    </div>

    <div id="investigation-publications">

        <span class="section-header">Publications</span>
        <ul>
            {{#each publications}}
            <li>
                <p class="publication-title">{{[Investigation Publication Title]}}</p>

                <p class="publication-authors">{{[Investigation Publication Author List]}}</p>

                <p class="publication-pubmedid">Pubmed ID <span style="color:#26B99A">{{[Investigation PubMed ID]}}</span></p>

                <p class="publication-doi">DOI <span style="color:#26B99A">{{[Investigation Publication DOI]}}</span></p>
            </li>
            {{/each}}
        </ul>
    </div>

</script>

<script id="study-template" type="text/x-handlebars-template">

    <div id="study-title">{{study_title}}</div>
    <div id="study-description">{{study_description}}</div>

    <div class="cf"></div>
    <br/>

    <div id="samples">
        <span class="section-header">Samples</span>

        <div class="cf"></div>

        <br/><br/>

        <span class="btn btn-green" style="width:auto;"
              onclick="ISATabViewer.rendering.render_assay('{{study_id}}','{{study_id_hash}}','{{study_file}}')">
            View Samples</span>

        <br/>

        <div id="sample-distribution">
            <ul id="sample_stats">
                {{#each sample_stats}}
                <li>
                    <p class="characteristic_type">{{name}}</p>
                    {{#each distribution}}
                    <div class="distribution-group">
                        <div class="distribution">{{name}}</div>
                        <div class="distribution-value"><span>{{value}}</span></div>
                    </div>
                    <div class="cf"></div>
                    {{/each}}
                </li>
                {{/each}}
            </ul>
        </div>

    </div>

    <div id="assays">
        <span class="section-header">Assays</span>
        <ul>
            {{#each assays}}
            <li>
                <div class="assay-icon {{icon}}"></div>
                <p class="measurement-type">{{[Study Assay Measurement Type]}}</p>

                <p class="technology-type">{{[Study Assay Technology Type]}}</p>

                <p class="technology-platform">{{[Study Assay Technology Platform]}}</p>

                <p class="assay-file-name">{{[Study Assay File Name]}}</p>

                <p class="btn btn-green"
                   onclick="ISATabViewer.rendering.render_assay('{{../study_id}}','{{../study_id_hash}}','{{[Study Assay File Name]}}')">
                    View</p>
            </li>
            {{/each}}
        </ul>
    </div>

    <div class="cf"></div>

    <div id="publications">

        <span class="section-header">Publications</span>
        <ul>
            {{#each publications}}
            <li>
                <p class="publication-title">{{[Study Publication Title]}}</p>

                <p class="publication-authors">{{[Study Publication Author List]}}</p>

                <p class="publication-pubmedid">Pubmed ID <span style="color:#26B99A">{{[Study PubMed ID]}}</span></p>

                <p class="publication-doi">DOI <span style="color:#26B99A">{{[Study Publication DOI]}}</span></p>
            </li>
            {{/each}}
        </ul>
    </div>

    <div class="cf"></div>
    <br/><br/>

    <div id="contacts">

        <span class="section-header">Contacts</span>
        <ul>
            {{#each contacts}}
            <li>
                <p class="publication-title">{{[Study Person First Name]}} {{[Study Person Last Name]}}</p>

                <p class="publication-authors">{{[Study Person Address]}}</p>

                <p class="publication-pubmedid">{{[Study Person Affiliation]}}</span></p>
            </li>
            {{/each}}
        </ul>
    </div>

    <div id="factors">

        <span class="section-header">Factors</span>
        <ul>
            {{#each factors}}
            <li>
                <p class="protocol-name">{{[Study Factor Name]}} ({{[Study Factor Type]}})</p>
            </li>
            {{/each}}
        </ul>
    </div>

    <div id="protocols">
        <span class="section-header">Protocols</span>
        <ul>
            {{#each protocols}}
            <li>
                <p class="protocol-name">{{[Study Protocol Name]}} ({{[Study Protocol Type]}})</p>
            </li>
            {{/each}}
        </ul>
    </div>

</script>

<script>
    function load_file() {
        var value = $("#gist_id").val();
        ISATabViewer.rendering.render_isatab_from_gist(value, '#investigation_file', {})
    }
</script>

</body>
</html>