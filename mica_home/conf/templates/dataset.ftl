<!-- Macros -->
<#include "libs/header.ftl">
<#include "models/population.ftl">
<#include "models/dce.ftl">
<#include "models/dataset.ftl">
<#include "models/files.ftl">

<#if !type??>
    <#assign title = "datasets">
    <#assign showTypeColumn = true>
<#elseif type == "Harmonized">
    <#assign title = "harmonized-datasets">
    <#assign showTypeColumn = false>
<#else>
    <#assign title = "collected-datasets">
    <#assign showTypeColumn = false>
</#if>

<!DOCTYPE html>
<html lang="${.lang}">
<head>
  <#include "libs/head.ftl">
  <title>${config.name!""} | ${localize(dataset.acronym)}</title>
</head>
<body id="${type?lower_case}-dataset-page" class="hold-transition layout-top-nav layout-navbar-fixed">
<div class="wrapper">

  <!-- Navbar -->
  <#include "libs/top-navbar.ftl">
  <!-- /.navbar -->

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <@header titlePrefix=(type?lower_case + "-dataset") title=localize(dataset.acronym) subtitle=localize(dataset.name) breadcrumb=[["..", "home"], ["${contextPath}/datasets", "datasets"], [localize(dataset.acronym)]]/>
    <!-- /.content-header -->

    <!-- Main content -->
    <div class="content">
      <div class="container">

        <#if draft>
          <div class="alert alert-warning" role="alert">
            <i class="icon fas fa-exclamation-triangle"></i> <@messageArgs code="viewing-draft-version" args=["/dataset/${dataset.id}"]/>
          </div>
        </#if>

        <!-- General Information content -->
        <div class="row">
          <div class="col-lg-12">
            <div class="card card-info card-outline">
              <div class="card-body">
                <div class="row">
                  <div class="col-lg-12">
                    <h3>${localize(dataset.name)}</h3>
                  </div>
                </div>

                <div class="card-text">
                  <#if localizedStringNotEmpty(dataset.description)>
                    <div class="marked mb-2">
                      <template>${localize(dataset.description)}</template>
                    </div>
                  </#if>

                  <div class="float-right">
                    <a class="btn btn-sm btn-info" href="${contextPath}/search#lists?type=variables&query=dataset(in(Mica_dataset.id,${dataset.id}))"><@message "search-variables"/></a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <#if study??>
          <div class="row d-flex align-items-stretch">
            <div class="col-sm-12 col-md d-flex align-items-stretch">
              <div class="card card-info card-outline w-100">
                <div class="card-header">
                  <h3 class="card-title"><@message "overview"/></h3>
                </div>
                <div class="card-body">
                  <div class="tab-content">
                    <dl class="row striped mt-0 mb-1">
                      <dt class="col-sm-4">
                          <@message "client.label.dataset.dataset-type"/>
                      </dt>
                      <dd class="col-sm-8">
                          <@message title/>
                      </dd>
                      <dt class="col-sm-4">
                          <@message "client.label.dataset.number-of-variables"/>
                      </dt>
                      <dd class="col-sm-8">
                        <span id="dataset-${dataset.id}-variables-count"></span>
                      </dd>
                    </dl>
                  </div>
                </div>
              </div>
            </div>
              <#if type == "Collected">
                  <@individualStudy study population dce/>
              <#else>
                  <@harmonizationStudy study/>
              </#if>
          </div>
        </#if>

        <!-- Dataset model -->
        <@datasetModel dataset=dataset type=type/>

        <!-- Harmonization content -->
        <#if type == "Harmonized">
          <@individualStudyList dataset.id/>

          <@harmonizationStudyList dataset.id/>

          <#if !(dataset.model.hide_var)?? || !dataset.model.hide_var>
            <div class="card card-info card-outline">
            <div class="card-header">
              <h3 class="card-title"><@message "harmonization"/></h3>
            </div>
            <div class="card-body">
              <div class="row">
                <div class="col-lg-9 col-sm-6">
                  <@harmonizationTableLegend/>
                </div>
                <div class="col-lg-3 col-sm-6">
                  <a href="${contextPath}/ws/harmonized-dataset/${dataset.id}/variables/harmonizations/_export" class="btn btn-info float-right mb-3">
                    <i class="fas fa-download"></i> <@message "download"/>
                  </a>
                </div>
              </div>
              <div class="table-responsive mt-3">
                <div id="loadingSummary" class="spinner-border spinner-border-sm" role="status"></div>
                <table id="harmonizedTable" class="table table-striped">
                </table>
              </div>
            </div>
          </div>
          </#if>

          <!-- Variables classifications -->
          <#if datasetVariablesClassificationsTaxonomies?? && datasetVariablesClassificationsTaxonomies?size gt 0>
              <@variablesClassifications dataset=dataset/>
          </#if>
        </#if>

        <!-- Files -->
        <#if showDatasetFiles>
            <@datasetFilesBrowser dataset=dataset/>
        </#if>

        <#if type == "Collected">
          <!-- Variables classifications -->
          <#if datasetVariablesClassificationsTaxonomies?? && datasetVariablesClassificationsTaxonomies?size gt 0>
              <@variablesClassifications dataset=dataset/>
          </#if>
        </#if>

        <div class="text-black-50 row col pb-3 pb-3">
          <span><@message "last-update"/>: <span class="text-muted moment-datetime">${dataset.lastModifiedDate.toString(datetimeFormat)}</span></span>
        </div>

      </div>
    </div>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  <#include "libs/footer.ftl">
</div>
<!-- ./wrapper -->

<#include "libs/scripts.ftl">
<#include "libs/dataset-scripts.ftl">
<script src="${assetsPath}/js/mlstr-scripts.js"></script>
<script src="${assetsPath}/js/mlstr-files.js"></script>
<script src="${assetsPath}/js/dataset.js"></script>

<script>
  const mlstrDatasetService = MlstrDatasetService.newInstance();
  mlstrDatasetService.updateVariablesCount("${dataset.id}", "${.lang}", "dataset-${dataset.id}-variables-count");

  <#if type == "Harmonized">
    mlstrDatasetService.createStudiesTables("${dataset.id}", "${.lang}", "${harmonizationDatasetStudyTableShowVariables?c}");
  </#if>
</script>

</body>
</html>
