/**
 * Created by eamonnmaguire on 19/06/2014.
 */

var ISATabViewer = {};

ISATabViewer.investigation = {
    "ONTOLOGY SOURCE REFERENCE": {},
    "INVESTIGATION": {},
    "INVESTIGATION CONTACTS": {},
    "INVESTIGATION PUBLICATIONS": {},
    "STUDY": []
};

ISATabViewer.options = {
    splitter: "\t"  // for TSV or "," for CSV
};

ISATabViewer.spreadsheets = {
    "files": {}
};

hashCode = function (s) {
    return s.split("").reduce(function (a, b) {
        a = ((a << 5) - a) + b.charCodeAt(0);
        return a & a
    }, 0);
}

ISATabViewer.rendering = {

    /*
     * Renders ISATab given an investigation url which is retrieved and processed and options to configure the display
     *
     */

    /**
     * Process an investigation file
     *
     * @param file_name
     * @param file_contents
     * @param placement
     */
    process_file: function (file_name, file_contents, placement) {
        var lines = file_contents.split(/\r\n|\r|\n/g);
        var current_section = "";
        var current_study;

        for (var line in lines) {
            //console.log(line +":"+ lines[line]);
            var __ret = ISATabViewer.rendering.process_investigation_file_line(lines[line], current_study, current_section);
            if (__ret != undefined) {
                current_study = __ret.current_study;
                current_section = __ret.current_section;
            }
        }

        if (current_study != undefined)
            ISATabViewer.investigation["STUDY"].push(current_study);

        //if (! ISATabViewer.rendering.is_empty_investigation() ) {
        //    console.log("rendering investigation");
        //    ISATabViewer.rendering.render_investigation(placement);
        //}

        ISATabViewer.rendering.render_study_list(placement);

        for (var study_index in ISATabViewer.investigation.STUDY) {

            var study_information = ISATabViewer.investigation.STUDY[study_index];
            var study_file = ISATabViewer.rendering.replace_str("\"", "", study_information.STUDY["Study File Name"][0]);
            var base_directory = file_name.substr(0, file_name.lastIndexOf("/") + 1);

            $.ajax({
                url: base_directory + study_file,
                async: false,
                success: function (study_file_contents) {
                    var processed_characteristics = ISATabViewer.rendering.process_assay_file(study_file, study_file_contents);

                    ISATabViewer.spreadsheets.files[study_file]["stats"] = processed_characteristics;

                    if ($('#sample-distribution').length) {
                        var sample_stats = ISATabViewer.rendering.process_study_sample_statistics(processed_characteristics);

                        var source = $("#sample-distribution-template").html();
                        var template = Handlebars.compile(source);
                        var html = template({"sample_stats": sample_stats});
                        $("#sample-distribution").html(html);
                    }
                }
            });

            var assays = ISATabViewer.rendering.generate_records(study_information, "STUDY ASSAYS");

            for (var assay in assays) {
                $.ajax({
                    url: base_directory + assays[assay]["Study Assay File Name"],
                    success: function(file_contents) {
                        var original_file_name = ISATabViewer.rendering.replace_str(base_directory, "", this.url);
                        ISATabViewer.rendering.process_assay_file(original_file_name, file_contents);
                    }
                });
            }
        }
        return ISATabViewer.investigation;
    },


    /**
     * Processes each line of the investigation file.
     *
     * @param line_contents
     * @param current_study
     * @param current_section
     * @returns {{current_study: *, current_section: *, parts: Array}}
     */
    process_investigation_file_line: function (line_contents, current_study, current_section) {
        //ignore lines starting with #
        if (line_contents.lastIndexOf("#", 0) === 0) {
            return;
        }

        //TODO: check line_contents in ISATabViewer.investigation in Chrome
        if (line_contents in ISATabViewer.investigation || (current_study != undefined && line_contents in current_study)) {

            current_section = line_contents;

            if (current_section == 'STUDY') {
                if (current_study != undefined)
                    ISATabViewer.investigation["STUDY"].push(current_study);
                current_study = ISATabViewer.rendering.create_study_template();
            }


        } else {
            var parts = line_contents.split(ISATabViewer.options.splitter);

            if (parts.length > 0) {

                if (current_study != undefined) {
                    current_study[current_section][parts[0]] = $.grep(parts, function (v, i) {
                        return v != "" && i != 0;
                    });
                } else {

                    ISATabViewer.investigation[current_section][parts[0]] = $.grep(parts, function (v, i) {
                        return v != "" && i != 0;
                    });

                }
            }
        }

        return {current_study: current_study, current_section: current_section, parts: parts};
    },

    /**
     *
     * @param file_name
     * @param file_contents
     * @returns {{}}
     */
    process_assay_file: function(file_name, file_contents) {

        ISATabViewer.spreadsheets.files[file_name] = {"headers": [], "rows": []};

        var lines = file_contents.split("\n");
        var count = 0;

        var position_to_characteristic = {};
        var characteristics = {};

        for (var line in lines) {

            var line_contents = lines[line].trim();
            var parts = line_contents.split(ISATabViewer.options.splitter);
            var processed_parts = [];

            parts.forEach(function (part, index) {
                var column_value = ISATabViewer.rendering.replace_str("\"", "", part);
                processed_parts.push(column_value);

                // we store information about the characteristics of the samples (sample files begin with 's_')
                // to give an overview in the study info page

                if (count == 0 && column_value.indexOf("Characteristics") >= 0) {

                    characteristics[column_value] = {};
                    position_to_characteristic[index] = column_value;
                } else {
                    if (index in position_to_characteristic) {
                        var characteristic_name = position_to_characteristic[index];

                        if (!(column_value in characteristics[characteristic_name])) {
                            characteristics[characteristic_name][column_value] = 0;
                        }
                        characteristics[characteristic_name][column_value]++;
                    }
                }

            });
            if (count == 0) {
                // we have the headers
                ISATabViewer.spreadsheets.files[file_name]["headers"] = processed_parts;
            } else {
                ISATabViewer.spreadsheets.files[file_name]["rows"].push({"columns": processed_parts});
            }
            count++;
        }

        return characteristics;
    },



    /***
     * Process ISA-Tab information coming from a gist file
     *
     * @param gist
     * @param gist_id
     * @param placement
     */
    process_gist: function (gist, gist_id, placement) {

        for (var file in gist.files) {
            $.ajax({
                url: 'https://gist.github.com/' + gist_id + '.json?file=' + gist.files[file],
                dataType: 'jsonp',
                success: function (file_data) {


                    console.log(file_data.div);
                    // we will be breaking things down in to investigation, study and assays. Then rendering everything at the end.
                    var xmlDoc = $.parseXML(file_data.div);

                    var filename = file_data.files[0];


                    if (filename.indexOf('i_') != -1) {
                        // process investigation file


                        var divs = $(xmlDoc).find('tr');


                        var current_section = "";
                        var current_study;

                        for (var div in divs) {
                            if (divs[div].textContent) {
                                var line_contents = divs[div].textContent.trim();
                                var __ret = ISATabViewer.rendering.process_investigation_file_line(line_contents, current_study, current_section);
                                current_study = __ret.current_study;
                                current_section = __ret.current_section;
                            }
                        }



                        if (current_study != undefined) ISATabViewer.investigation["STUDY"].push(current_study);

                        ISATabViewer.rendering.render_study_list(placement);
                    } else {

                        var divs = $(xmlDoc).find('tr');

                        ISATabViewer.spreadsheets.files[filename] = {"headers": [], "rows": []};

                        var count = 0;

                        var position_to_characteristic = {};
                        var characteristics = {};

                        for (var div in divs) {
                            if (divs[div].textContent) {
                                var line_contents = divs[div].textContent.trim();
                                parts = line_contents.split(ISATabViewer.options.splitter);
                                var processed_parts = [];

                                parts.forEach(function (part, index) {
                                    var column_value = ISATabViewer.rendering.replace_str("\"", "", part);
                                    processed_parts.push(column_value);

                                    // we store information about the characteristics of the samples (sample files begin with 's_')
                                    // to give an overview in the study info page
                                    if (filename.indexOf("s_") != -1) {
                                        if (count == 0 && column_value.indexOf("Characteristics") >= 0) {

                                            characteristics[column_value] = {};
                                            position_to_characteristic[index] = column_value;
                                        } else {
                                            if (index in position_to_characteristic) {
                                                var characteristic_name = position_to_characteristic[index];

                                                if (!(column_value in characteristics[characteristic_name])) {
                                                    characteristics[characteristic_name][column_value] = 0;
                                                }
                                                characteristics[characteristic_name][column_value]++;
                                            }
                                        }
                                    }
                                });
                                if (count == 0) {
                                    // we have the headers
                                    ISATabViewer.spreadsheets.files[filename]["headers"] = processed_parts;
                                } else {
                                    ISATabViewer.spreadsheets.files[filename]["rows"].push({"columns": processed_parts});
                                }
                                count++;
                            }
                        }

                        if (filename.indexOf("s_") != -1) {
                            ISATabViewer.spreadsheets.files[filename]["stats"] = characteristics;

                            if ($('#sample-distribution').length) {
                                var sample_stats = ISATabViewer.rendering.process_study_sample_statistics(characteristics);

                                var source = $("#sample-distribution-template").html();
                                var template = Handlebars.compile(source);
                                var html = template({"sample_stats": sample_stats});
                                $("#sample-distribution").html(html);
                            }
                        }
                    }

                }
            });
        }
    },

    render_study_list: function () {
        // Render study list
        var studies = [];

        for (var study_index in ISATabViewer.investigation.STUDY) {
            var study_id = ISATabViewer.rendering.replace_str("\"", "", ISATabViewer.investigation.STUDY[study_index].STUDY["Study Identifier"][0]);
            var study_title = ISATabViewer.rendering.replace_str("\"", "", ISATabViewer.investigation.STUDY[study_index].STUDY["Study Title"][0]);
            studies.push({"hash":hashCode(study_id), "id":study_id, "title":study_title})
        }

        $("#isa-breadcrumb-items").html('<li class="active">' + studies[0].id + '</li>');

        var source = $("#study-list-template").html();
        var template = Handlebars.compile(source);
        var html = template({"studies": studies});
        $("#study-list").html(html);

        //if (ISATabViewer.rendering.is_empty_investigation())
            ISATabViewer.rendering.render_study(studies[0].id, studies[0].hash);
    },

    set_active_list_item: function (study_id_hash) {

        $("#study-list").find("li").each(function () {
            $(this).removeClass("active");
        });

        $("#list-" + study_id_hash).addClass("active");
    },


    process_study_sample_statistics: function (stats) {
        var study_sample_stats = [];
        for (var characteristic_name in stats) {
            var record = {"name": characteristic_name, "distribution": []};

            for (var distribution_item in stats[characteristic_name]) {
                record["distribution"].push({
                    "name": distribution_item,
                    "value": stats[characteristic_name][distribution_item]
                })
            }
            study_sample_stats.push(record);
        }
        return study_sample_stats
    },


    is_empty_string : function(str) {
        return (!str || 0 === str.length);
    },



    is_empty_investigation : function () {
        //var investigation_title = ISATabViewer.rendering.replace_str("\"", "", ISATabViewer.investigation.INVESTIGATION["Investigation Title"]);
        //
        //if (ISATabViewer.rendering.is_empty_string(investigation_title))
        //    return true;
        //else
        //    return false;
        return true;
    },

    /**
     *
     */
    render_investigation : function () {

        if (!ISATabViewer.rendering.is_empty_investigation()) {

            ISATabViewer.investigation.investigation_id = ISATabViewer.investigation.INVESTIGATION["Investigation Identifier"];
            ISATabViewer.investigation.investigation_title = ISATabViewer.investigation.INVESTIGATION["Investigation Title"];
            ISATabViewer.investigation.investigation_description = ISATabViewer.investigation.INVESTIGATION["Investigation Description"];
            ISATabViewer.investigation.contacts = ISATabViewer.rendering.generate_records(ISATabViewer.investigation, "INVESTIGATION CONTACTS");
            ISATabViewer.investigation.publications = ISATabViewer.rendering.generate_records(ISATabViewer.investigation, "INVESTIGATION PUBLICATIONS");

            $("#isa-breadcrumb-items").html('<li class="active">' + ISATabViewer.investigation.investigation_id + '</li>');
            var source = $("#investigation-template").html();
            var template = Handlebars.compile(source);
            var html = template(ISATabViewer.investigation);
            $("#study-info").html(html);
        }
    },

    /**
     * Renders study
     *
     * @param study_id
     * @param study_id_hash
     */
    render_study: function (study_id, study_id_hash) {

        if (ISATabViewer.rendering.is_empty_investigation())
            this.set_active_list_item(study_id_hash);

        $("#isa-breadcrumb-items").html('<li class="active">' + study_id+ '</li>');
        var study = {};
        for (var study_index in ISATabViewer.investigation.STUDY) {

            var study_information = ISATabViewer.investigation.STUDY[study_index];

            if (study_information.STUDY["Study Identifier"][0].indexOf(study_id) != -1) {
                study.investigation_id = ISATabViewer.investigation.investigation_id;
                study.study_id_hash = study_id_hash;
                study.study_id = ISATabViewer.rendering.replace_str("\"", "", study_information.STUDY["Study Identifier"][0]);
                study.study_title = ISATabViewer.rendering.replace_str("\"", "", study_information.STUDY["Study Title"][0]);
                study.study_description = ISATabViewer.rendering.replace_str("\"", "", study_information.STUDY["Study Description"][0]);
                study.study_file = ISATabViewer.rendering.replace_str("\"", "", study_information.STUDY["Study File Name"][0]);

                var data_files = [];

                if (typeof study_information.STUDY["Comment[Data Repository]"] !== 'undefined' && study_information.STUDY["Comment[Data Repository]"].length >0) {
                    study.data_repositories = study_information.STUDY["Comment[Data Repository]"][0].split(";");
                    study.data_record_accessions = study_information.STUDY["Comment[Data Record Accession]"][0].split(";");
                    study.data_record_uris = study_information.STUDY["Comment[Data Record URI]"][0].split(";");

                    for (var i = 0; i < study.data_repositories.length; i++) {
                        if (data_files[i] == undefined) {
                            data_files[i] = {}
                        }
                        data_files[i].data_repository = study.data_repositories[i];
                        data_files[i].data_record_accession = study.data_record_accessions[i];
                        data_files[i].data_record_uri = study.data_record_uris[i];
                    }

                    study.data_files = data_files;
                }

                if (typeof study_information.STUDY["Comment[Subject Keywords]"] != 'undefined' && study_information.STUDY["Comment[Subject Keywords]"].length > 0) {
                    study.keywords = study_information.STUDY["Comment[Subject Keywords]"][0].split(";");
                }

                study.publications = ISATabViewer.rendering.generate_records(study_information, "STUDY PUBLICATIONS");
                study.protocols = ISATabViewer.rendering.generate_records(study_information, "STUDY PROTOCOLS");
                study.contacts = ISATabViewer.rendering.generate_records(study_information, "STUDY CONTACTS");
                study.factors = ISATabViewer.rendering.generate_records(study_information, "STUDY FACTORS");
                study.assays = ISATabViewer.rendering.generate_records(study_information, "STUDY ASSAYS");

                ISATabViewer.rendering.postprocess_assay_records(study.assays);

                if (study.study_file in ISATabViewer.spreadsheets.files) {
                    // we have already loaded the study sample file, so can load the distributions
                    study.sample_stats = ISATabViewer.spreadsheets.files[study.study_file]["stats"];

                    study.sample_stats = this.process_study_sample_statistics(study.sample_stats);

                }
            }
        }

        var source = $("#study-template").html();
        var template = Handlebars.compile(source);
        var html = template(study);

        $("#study-info").html(html);
    },

    /**
     *
     * Renders an assay table
     *
     * @param study_id
     * @param file_name
     */
    render_assay: function (study_id, study_id_hash, file_name) {

        $("#isa-breadcrumb-items").html('<li onclick="ISATabViewer.rendering.render_study(\'' + study_id + '\',\'' + study_id_hash + '\')">' + study_id + '</li><li class="active">' + file_name + '</li>');

        var spreadsheet = ISATabViewer.spreadsheets.files[file_name];
        var source = $("#table-template").html();
        var template = Handlebars.compile(source);
        var html = template(spreadsheet);

        $("#study-info").html(html);
    },

    /*
     This function adds in information about which images to use for example to show a particular type of assay.
     */
    postprocess_assay_records: function (records) {
        for (var assay_index in records) {
            var assay = records[assay_index];

            var measurement_type = assay["Study Assay Measurement Type"];

            assay.icon = measurement_type.indexOf("metabolite") >= 0 ? "assay-icon-metabolomics"
                : measurement_type.indexOf("prote") >= 0 ? "assay-icon-proteomics"
                : measurement_type.indexOf("transcript") >= 0 ? "assay-icon-transcriptomics"
                : measurement_type.indexOf("chemistry") >= 0 ? "assay-icon-chemistry"
                : measurement_type.indexOf("genom") >= 0 ? "assay-icon-genomics"
                : "";

        }
    },

    generate_records: function (study_information, field_name) {

        var result = [];
        for (var field in study_information[field_name]) {

            var records = study_information[field_name][field];
            for (var i = 0; i < records.length; i++) {
                if (result[i] == undefined) {
                    result[i] = {}
                }
                result[i][field] = ISATabViewer.rendering.replace_str("\"", "", records[i]);
            }
        }
        return result;
    },

    replace_str: function (find, replace, str) {
        return str.replace(new RegExp(find, 'g'), replace);
    },


    render_isatab_from_gist: function (gist_id, placement, options) {

        $.ajax({
            url: 'https://gist.github.com/' + gist_id + '.json',
            dataType: 'jsonp',
            success: function (gist) {
                ISATabViewer.investigation.STUDY = [];
                ISATabViewer.rendering.process_gist(gist, gist_id, placement)
                $("#download-button").html('<a href="https://gist.github.com/' + gist_id + '/download" class="btn btn-green" style="width: 120px">Download this study.</span>');
            }
        });
    },

    render_isatab_from_file: function (investigation_file, placement, options, invCallBack) {

        $.ajax({
            url: investigation_file,
            //async: false,
            success: function (file) {
                var investigation;
                ISATabViewer.investigation.STUDY = [];
                investigation = ISATabViewer.rendering.process_file(investigation_file, file, placement);
                //invCallBack(investigation);
            }
        });
    },

    create_study_template: function () {
        return {
            "STUDY": {},
            "STUDY CONTACTS": {},
            "STUDY PUBLICATIONS": {},
            "STUDY FACTORS": {},
            "STUDY DESIGN DESCRIPTORS": {},
            "STUDY ASSAYS": {},
            "STUDY PROTOCOLS": {}
        };
    }
};