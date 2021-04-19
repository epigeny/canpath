<!-- Macros -->
<#include "libs/header.ftl">
<#include "models/study.ftl">
<#include "models/member.ftl">
<#include "models/population.ftl">
<#include "models/dce.ftl">
<#include "models/files.ftl">

<#if !type??>
    <#assign title = "studies">
    <#assign showTypeColumn = true>
    <#assign forLogoLink = "study">
<#elseif type == "Harmonization">
    <#assign title = "harmonization-studies">
    <#assign showTypeColumn = false>
    <#assign forLogoLink = "harmonization-study">
<#else>
    <#assign title = "individual-studies">
    <#assign showTypeColumn = false>
    <#assign forLogoLink = "individual-study">
</#if>

<#assign draftImageUrlFragment = "/">

<#if draft>
  <#assign draftImageUrlFragment = "/draft/">
</#if>

<!DOCTYPE html>
<html lang="${.lang}">
<head>
  <#include "libs/head.ftl">
  <title>${config.name!""} | ${localize(study.acronym)}</title>
  <link rel="stylesheet" href="${contextPath}/bower_components/mica-study-timeline/dist/mica-study-timeline.css" />
</head>
<body id="${type?lower_case}-study-page" class="hold-transition layout-top-nav layout-navbar-fixed">
<div class="wrapper">

  <!-- Navbar -->
  <#include "libs/top-navbar.ftl">
  <!-- /.navbar -->

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <@header titlePrefix=(type?lower_case + "-study") title=localize(study.acronym) subtitle=localize(study.name) breadcrumb=[["..", "home"], ["${contextPath}/studies", "studies"], [localize(study.acronym)]]/>
    <!-- /.content-header -->

    <!-- Main content -->
    <div class="content">
      <div class="container">

        <#if draft>
          <div class="alert alert-warning" role="alert">
            <i class="icon fas fa-exclamation-triangle"></i> <@messageArgs code="viewing-draft-version" args=["/study/${study.id}"]/>
          </div>
        </#if>

        <div class="row">
          <div class="col-lg-12">
            <div class="card card-info card-outline">
              <div class="card-body">
                <div class="row">
                  <div class="col-lg-12">
                    <h3 class="mb-4">${localize(study.name)}</h3>
                  </div>
                </div>
                <div class="row">
                  <#if study.logo??>
                    <div class="col-2">                    
                      <img id="document-logo" class="img-fluid" style="width: 12em" alt="${localize(study.acronym)} logo" src="${contextPath}/ws${draftImageUrlFragment}${forLogoLink}/${study.id}/file/${study.logo.id}/_download"/>
                    </div>
                  </#if>  

                  <div class="col card-text">
                    <div class="marked">
                      <template>${localize(study.objectives)}</template>
                    </div>
                  </div>

                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="row d-flex align-items-stretch">
          <div class="col-sm-12 col-md d-flex align-items-stretch">
            <@studyOverview study=study type=type/>
          </div>
          <#if study.model.methods??>
            <div class="col-sm-12 col-md d-flex align-items-stretch">
                <@generalDesing study/>
            </div>
          <#else>
            <!-- Harmonization study -->
            <#if study.model.harmonizationDesign??>
              <div class="col-sm-12 col-md d-flex align-items-stretch">
                <div class="card card-info card-outline w-100">
                  <div class="card-header">
                    <h3 class="card-title">
                        <@message "study_taxonomy.vocabulary.harmonizationDesign.title"/>
                    </h3>
                  </div>
                  <!-- /.card-header -->
                  <div class="card-body">
                      ${localize(study.model.harmonizationDesign)}
                  </div>
                </div>
              </div>
            </#if>
          </#if>
        </div>

        <!-- Study model -->
        <@studyModel study=study type=type/>

        <!-- Files -->
        <#if showStudyFiles>
            <@studyFilesBrowser study=study/>
        </#if>

        <#if study.populations?? && study.populations?size != 0>
          <!-- Timeline -->
            <#if type == "Individual">
              <div class="row ${canShowTimeline(study)?then('', 'd-none')}">
                <div class="col-lg-12">
                  <div class="card overflow-auto card-info card-outline">
                    <div class="card-header">
                      <h3 class="card-title"><@message "timeline"/></h3>
                    </div>
                    <div class="card-body">
                      <div id="timeline"></div>
                    </div>
                  </div>
                </div>
              </div>
            </#if>

          <!-- Populations -->
          <div id="populations" class="row">
            <div class="col-lg-12">
              <div class="card card-info card-outline">
                <div class="card-header">
                  <h3 class="card-title">
                      <#if study.populations?size == 1>
                          <@message "population"/>
                      <#else>
                          <@message "populations"/>
                      </#if>
                  </h3>
                </div>
                <div class="card-body">
                  <#if study.populations?size == 1>
                  <#else>
                    <ul class="nav nav-pills mb-3 h6">
                        <#list study.populationsSorted as pop>
                          <li class="nav-item my-1"><a class="nav-link <#if pop?index == 0>active</#if>" href="#population-${pop.id}" data-toggle="tab">
                                  ${localize(pop.name)}</a>
                          </li>
                        </#list>
                    </ul>
                  </#if>
                  <div>
                    <#list study.populationsSorted as pop>
                        <@dceModals population=pop/>
                    </#list>
                  </div>
                  <div class="col tab-content">
                    <#list study.populationsSorted as pop>
                      <div class="tab-pane <#if pop?index == 0>active</#if>" id="population-${pop.id}">
                        <span class="lead">${localize(pop.name)}</span>
                        <div class="my-3 marked">
                          <template>${localize(pop.description)}</template>
                        </div>
                          <@populationModel population=pop/>
                          <@dceList population=pop/>
                      </div>
                    </#list>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </#if>

        <@individualStudyList study.id/>

        <@harmonizationStudyList study.id/>

        <@datasetList study.id type/>

        <!-- Variables classifications -->
        <#if studyVariablesClassificationsTaxonomies?? && studyVariablesClassificationsTaxonomies?size gt 0>
            <@variablesClassifications study=study/>
        </#if>

        <div class="text-black-50 row col pb-3 pb-3">
          <span><@message "last-update"/>: <span class="text-muted moment-datetime">${study.lastModifiedDate.toString(datetimeFormat)}</span></span>
        </div>

      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

    <#include "libs/footer.ftl">
</div>
<!-- ./wrapper -->

<#include "libs/scripts.ftl">
<#include "libs/study-scripts.ftl">
<script src="${assetsPath}/js/mlstr-scripts.js"></script>
<script src="${assetsPath}/js/mlstr-files.js"></script>
<script src="${assetsPath}/js/study.js"></script>

<script>
  dataTablesDefaultOpts = mlstrDataTablesDefaultOpts;

  Mica.tr = {
    "collected-dataset": "<@message "collected-dataset"/>",
    "harmonized-dataset": "<@message "harmonized-dataset"/>",
    "dataschema-dataset": "<@message "harmonized-dataset"/>"
  }

  const mlstrStudyService = MlstrStudyService.newInstance();

  mlstrStudyService.createDatasetsTable("${study.id}", "${.lang}");
  <#if type != "Harmonization">
    mlstrStudyService.createNetworksTable("${study.id}", "${.lang}");
    mlstrStudyService.ensurePopulationDceSelection();
  </#if>

  <#if draft>
    let params = window.location.search;
    let img = document.querySelector('#document-logo');

    img.src = img.src + params.replace('draft', 'key');
  </#if>
</script>

</body>
</html>
