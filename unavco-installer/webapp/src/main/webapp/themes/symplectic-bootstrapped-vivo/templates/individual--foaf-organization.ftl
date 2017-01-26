<#-- $This file is distributed under the terms of the license in /doc/license.txt$ -->

<#-- Individual profile page template for foaf:Organization individuals (extends individual.ftl in vivo)-->

<#-- Do not show the link for temporal visualization unless it's enabled -->
<#-- classSpecificExtension is now put in the right hand box -->
<#if temporalVisualizationEnabled>
    <#assign sideClassSpecificExtension>
          <h5>Visualizations</h5>
            <#include "individual-visualizationTemporalGraph.ftl">
            <#include "individual-visualizationMapOfScience.ftl">
    </#assign>
</#if>

<#assign affiliatedResearchAreas>
    <#include "individual-affiliated-research-areas.ftl">
</#assign>

<#if individual.mostSpecificTypes?seq_contains("Academic Department") && getGrantResults?has_content>
    <#assign departmentalGrantsExtension>
        <div id="activeGrantsLink">
        <img src="${urls.base}/images/individual/arrow-green.gif">
            <a href="${urls.base}/deptGrants?individualURI=${individual.uri}" title="${i18n().view_all_active_grants}">
                ${i18n().view_all_active_grants}
            </a>
        </div>
    </#assign>
</#if>

<#assign classSpecificIcon>
    <span class="class-icon glyphicon glyphicon-book"></span>
</#assign>

<#include "individual.ftl">
