${headScripts.add('<script type="text/javascript" src="${urls.base}/js/facetview2/vendor/jquery/1.12.3/jquery-1.12.3.min.js"></script>',
              '<script type="text/javascript" src="${urls.base}/js/facetview2/vendor/bootstrap/js/bootstrap.min.js"></script>',
              '<script type="text/javascript" src="${urls.base}/js/facetview2/es.js"></script>',
              '<script type="text/javascript" src="${urls.base}/js/facetview2/bootstrap3.facetview.theme.js"></script>',
              '<script type="text/javascript" src="${urls.base}/js/facetview2/jquery.facetview2.js"></script>',
              '<script type="text/javascript" src="${urls.base}/js/js.cookie.js"></script>',
              '<script type="text/javascript">jQuery(function( $ ){$(".close").click(function( e ){e.preventDefault();
               Cookies.set("alert-box-research", "closed", { path: "/" });});});
               jQuery(function( $ ){if( Cookies.get("alert-box-research") === "closed" ){$(".alert").hide();}});
               </script>',
              '<script type="text/javascript">
        jQuery(document).ready(function($) {
            $(\'.facet-view-simple\').facetview({
                search_url: \'http://localhost:9200/unavco/dataset/_search\',
                page_size: 10,
                page_size_dropdown: true,
                sort: [{"_score" : {"order" : "desc"}},{"publicationYear" : {"order" : "desc"}}],
                sharesave_link: false,
                search_button: true,
                default_freetext_fuzzify: "*",
                default_facet_operator: "AND",
                default_facet_order: "count",
                default_facet_size: 10,
                search_fields_multi: ["*folded","_all"],
				        pushstate: false,
                facets: [
                  {"field": "dataTypes.name.exact", "display": "Dataset Type", "open" : true, "controls": false},
                  {"field": "publicationYear", "display": "Publication Year", "type" : "date_histogram", "open" : false,"sort":"desc", "size" : 50, "controls": false},
                  {"field": "authors.name.exact", "size": 20, "display": "Author", "controls": false}
                ],
                search_sortby: [
                    {\'display\':\'Title\',\'field\':\'title.exact\'},
                    {\'display\':\'Date\',\'field\':\'publicationYear\'}
                ],
                render_result_record: function(options, record)
                {

                    var doiUrl = "https://dx.doi.org/"+record["doi"];
					var vivoUrlRoot = \'http://localhost:8080/vivo/individual?uri=\'

                    var html = "<tr><td>";
				
					// title and link to vivo page
                    html += "<strong><a href=\\""+ vivoUrlRoot + record["uri"] + "\\" >" + record["title"] + 							"</a></strong>";

                    // display publicationYear
                    if (record["publicationYear"]) {
						pubYear = new Date(record["publicationYear"]).getUTCFullYear();
                        html += "&emsp;<small>(" + pubYear + ")</small>";
                    }

                    if (record["mostSpecificType"]) {
                        html += "<br />Type: " + record["mostSpecificType"];
                    }

                  /*  if (record["community"]) {
                        html += "<br /><span>Community: <a href=\\"" + record["community"]["uri"] + "\\" target=\\"_blank\\">" + record["community"]["name"] + "</a></span>";
                    }

                    if (record["team"]) {
                        html += "<br /><span>Team: <a href=\\"" + record["team"]["uri"] + "\\" target=\\"_blank\\">" + record["team"]["name"] + "</a></span>";
                    } */

                    // display authors
                    if (record["authors"]) {
                        if (record["authors"].length != 0) {
                            html += "<br /><span><small>Authors: ";
                            for (var i = 0; i < record["authors"].length; i++) {
								if(record["authors"][i]["uri"]){ 
                                html += "<a href=\\"" + vivoUrlRoot + record["authors"][i]["uri"] + "\\" >" + 										record["authors"][i]["name"] + "</a>"; }
								else {
									html += record["authors"][i]["name"]
								}
                                if (i < record["authors"].length - 1) {
                                    html += "; ";
                                }
                            }
                            html += "</small></span>";
                        }
                    }
                    
                    // display dataTypes
                    if (record["dataTypes"]) {
                        html += "<br /><span>Dataset Type: ";
                        if (record["dataTypes"].length == 0) {
                            html += \'N/A\'
                        } else {
                            for (var i = 0; i < record["dataTypes"].length; i++) {
                                html += "<a href=\'" + vivoUrlRoot + record["dataTypes"][i]["uri"] + "\' >" + record["dataTypes"][i]["name"] + "</a>";
                                if (i < record["dataTypes"].length - 1) {
                                    html += "; ";
                                }
                            }
                        }
                        html += "</span>";
                    }                    
					
                    // display related stations
                if (record["stations"]) {
                  html += "<br /><span>Related stations: ";
                  if (record["stations"].length == 0) {
                      html += "N/A"
                  } else {
                    for (var i = 0; i < record["stations"].length; i++) {
                        html += "<a href=\'" + vivoUrlRoot + record["stations"][i]["uri"] + "\' >" + record["stations"][i]["name"] + "</a>";
                        if (i < record["stations"].length - 1) {
                            html += "; ";
                        }
                    }
                  }
                  html += "</span>";
                }
                
                // display citations
               if (record["citations"]) {
                   html += "<br /><span>Related documents: ";
                   if (record["citations"].length == 0) {
                       html += \'N/A\'
                   } else {
                       for (var i = 0; i < record["citations"].length; i++) {
                           html += "<a href=\'" + vivoUrlRoot + record["citations"][i]["uri"] + "\' >" + record["citations"][i]["name"] + "</a>";
                           if (i < record["citations"].length - 1) {
                               html += "; ";
                           }
                       }
                   }
                   html += "</span>";
               }                

                    // Badges

                    html += "<br />";

                    if (record["doi"]) {
                        var escapedDOI = encodeURIComponent(record["doi"]);
                        html += "<div style=\'display: inline-block; margin-top:.5em;\'><div style=\'display: inline;\'><a href=\\"" + doiUrl + "\\" target=\\"_blank\\"><img src=\'https://img.shields.io/badge/DOI-" + escapedDOI.replace(/-/g, "--") + "-blue.svg\'></div>"
                    }

                  

                    html += "</td></tr>";
                    return html;
                },
                selected_filters_in_facet: true,
                show_filter_field : true,
                show_filter_logic: true,

            });
        });

    </script>')}

    ${stylesheets.add('<link rel="stylesheet" href="${urls.base}/js/facetview2/vendor/bootstrap/css/bootstrap.min.css" />',
                      '<link rel="stylesheet" href="${urls.base}/js/facetview2/css/facetview.css" />',
                      '<link rel="stylesheet" href="${urls.base}/js/facetview2/css/browsers.css" />',
                      '<link rel="stylesheet" href="${urls.base}/js/facetview2/css/style.css" />',
                      ' <style type="text/css">

                      .facet-view-simple{
                          width:100%;
                          height:100%;
                          margin:0 auto 0 auto;
                      }
                      
                      .facet-view-simple a {
                          text-decoration: none     
                      }

                      .facetview_freetext.span4 {
                         width: 290px;
                         height: 10px;
                      }

                      legend {
                          display: none;
                      }

                      #wrapper-content {
                        // padding: 0px !important;
                        width: 970px !important;
                        
                      }

                      input {
                          -webkit-box-shadow: none;
                          box-shadow: none;
                      }

                      .person-info {
                          display: inline-block;
                          vertical-align: top;
                          // clear: left;
                          margin-left: 0 !important;
                      }

                      .thumbnail {
                          display: inline-block;
                          width: 150px;
                          box-shadow: none;
                          border: none;
                      }
                      
                      .row {
                          background-color: #fff !important;
                          margin: 0 !important;
                      }
                      
                      h3 a:link, h3 a:visited{
                        text-decoration: none !important;
                      }
                      
                      .pagination {
                        margin-top: 16px !important;
                      }
                      
                      .facet-panel {
                        border: 2px solid;
                        border-color: #f3f3f0;
                      }
                      
                      ul#main-nav {
                      width: 970px !important;
                      height: 48px !important;  
                      }
                      
                      #unavco-branding {
                        height: 57px !important;
                      }


                  </style>')}

<section id="menupage-intro" role="region">
<h2>${page.title}</h2>
<div style="clear:both"></div>

<div class="alert alert-info fade in">
   <a href="#" class="close" data-dismiss="alert" aria-label="close">&#10006;</a>
<small>${i18n().class_group_description_publications}</small>
</div>

</section>
<div class="facet-view-simple"></div>