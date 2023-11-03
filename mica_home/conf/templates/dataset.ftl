<!-- Macros -->
<#include "libs/header.ftl">
<#include "models/population.ftl">
<#include "models/dce.ftl">
<#include "models/dataset.ftl">
<#include "models/files.ftl">


<#if !type??>
    <#assign title = "datasets">
    <#assign showTypeColumn = true>
    <#assign studyClassName = "Study,HarmonizationStudy">
    <#assign searchPageUrl = "search">
<#elseif type == "Harmonized">
    <#assign title = "harmonized-datasets">
    <#assign showTypeColumn = false>
    <#assign studyClassName = "HarmonizationStudy">
    <#assign searchPageUrl = "harmonization-search">
<#else>
    <#assign title = "collected-datasets">
    <#assign showTypeColumn = false>
    <#assign studyClassName = "Study">
    <#assign searchPageUrl = "individual-search">
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
    <div class="d-none">
    <@header titlePrefix=(type?lower_case + "-dataset") title=localize(dataset.acronym) subtitle=localize(dataset.name) breadcrumb=[["..", "home"], ["${contextPath}/datasets", "datasets"], [localize(dataset.acronym)]]/>
    <!-- /.content-header -->
    </div>

    <!-- Main content -->
    <div class="content pt-4">
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
                      <#if type == "Harmonized">
                        <#if study??>
                          <dt class="col-sm-4">
                                <@message "harmonization-study"/>
                          </dt>
                          <dd class="col-sm-8">
                            <a href="${contextPath}/study/${study.id}">${localize(study.acronym)}</a>
                          </dd>
                        </#if>

                        <dt class="col-sm-4">
                              <@message "harmonized-dataset"/>
                        </dt>
                        <dd class="col-sm-8">
                          ${localize(dataset.acronym)}
                        </dd>

                        <#if dataset.model.version??>
                          <dt class="col-sm-4">
                              <@message "harmonization-protocol.version"/>
                          </dt>
                          <dd class="col-sm-8">
                            <span>${dataset.model.version}</span>
                          </dd>
                        </#if>
                      </#if>

                      <dt class="col-sm-4">
                        <@message "client.label.dataset.number-of-variables"/>
                      </dt>
                      <dd class="col-sm-8">
                        <#if !(dataset.model.hide_var)?? || !dataset.model.hide_var>
                          <span id="dataset-${dataset.id}-variables-count"></span>
                        <#else>
                          -
                        </#if>

                      </dd>

                    </dl>
                  </div>
                </div>
              </div>
            </div>
              <#if type == "Harmonized">
                <#if (dataset.model.qualitativeQuantitative)?? ||
                    (dataset.model.prospectiveRetrospective)?? ||
                    localizedStringNotEmpty(dataset.model.procedures) ||
                    localizedStringNotEmpty(dataset.model.infrastructure) ||
                    localizedStringNotEmpty(dataset.model.participantsInclusion) ||
                    (dataset.model.participants)??>
                  <div class="col-sm-12 col-md d-flex align-items-stretch">
                    <div class="card card-info card-outline w-100">
                      <div class="card-header">
                        <h3 class="card-title"><@message "design"/></h3>
                      </div>
                      <div class="card-body">
                        <div class="tab-content">
                          <dl class="row striped mt-0 mb-1">
                            <#if (dataset.model.qualitativeQuantitative)??>
                              <dt class="col-sm-4">
                                  <@message "harmonization-protocol.qualitative-quantitative.title"/> <i class="fas fa-info-circle text-muted-60" title="<@message "harmonization-protocol.qualitative-quantitative.alt-help"/>"></i>
                              </dt>
                              <dd class="col-sm-8">
                                <span><@message "harmonization-protocol.qualitative-quantitative.enum.${dataset.model.qualitativeQuantitative}"/> </span>
                              </dd>
                            </#if>
                            <#if (dataset.model.prospectiveRetrospective)??>
                              <dt class="col-sm-4">
                                  <@message "harmonization-protocol.prospective-retrospective.title"/> <i class="fas fa-info-circle text-muted-60" title="<@message "harmonization-protocol.prospective-retrospective.alt-help"/>"></i>
                              </dt>
                              <dd class="col-sm-8">
                                <span><@message "harmonization-protocol.prospective-retrospective.enum.${dataset.model.prospectiveRetrospective}"/> </span>
                              </dd>
                            </#if>
                            <#if localizedStringNotEmpty(dataset.model.procedures)>
                              <dt class="col-sm-4">
                                  <@message "harmonization-protocol.procedures"/> <i class="fas fa-info-circle text-muted-60" title="<@message "harmonization-protocol.procedures-help"/>"></i>
                              </dt>
                              <dd class="col-sm-8">
                                <span>${localize(dataset.model.procedures)}</span>
                              </dd>
                            </#if>
                            <#if localizedStringNotEmpty(dataset.model.infrastructure)>
                              <dt class="col-sm-4">
                                  <@message "harmonization-protocol.infrastructure"/> <i class="fas fa-info-circle text-muted-60" title="<@message "harmonization-protocol.infrastructure-help"/>"></i>
                              </dt>
                              <dd class="col-sm-8">
                                <span>${localize(dataset.model.infrastructure)}</span>
                              </dd>
                            </#if>
                            <#if localizedStringNotEmpty(dataset.model.participantsInclusion)>
                              <dt class="col-sm-4">
                                  <@message "harmonization-protocol.participants-inclusion"/>
                              </dt>
                              <dd class="col-sm-8">
                                <span>${localize(dataset.model.participantsInclusion)}</span>
                              </dd>
                            </#if>
                            <#if (dataset.model.participants)??>
                              <dt class="col-sm-4">
                                  <@message "harmonization-protocol.participants"/>
                              </dt>
                              <dd class="col-sm-8">
                                <span>${dataset.model.participants}</span>
                              </dd>
                            </#if>
                          </dl>
                        </div>
                      </div>
                    </div>
                  </div>
                </#if>
              </#if>
          </div>
        </#if>

        <!-- Dataset model -->
        <@datasetModel dataset=dataset type=type/>

        <!-- Harmonization content -->
        <#if type == "Harmonized">
          <#if localizedStringNotEmpty(dataset.model.informationContent) || localizedStringNotEmpty(dataset.model.additionalInformation)>
            <div class="row d-flex align-items-stretch">
              <#if localizedStringNotEmpty(dataset.model.informationContent)>
                <div class="col-sm-12 col-md d-flex align-items-stretch">
                  <div class="card card-info card-outline w-100">
                    <div class="card-header">
                      <h3 class="card-title">
                        <@message "harmonization-protocol.information-content"/>
                      </h3>
                    </div>
                    <!-- /.card-header -->
                    <div class="card-body">
                      <div class="marked">
                        <template>${localize(dataset.model.informationContent)}</template>
                      </div>
                    </div>
                  </div>
                </div>
              </#if>
              <#if localizedStringNotEmpty(dataset.model.additionalInformation)>
                <div class="col-sm-12 col-md d-flex align-items-stretch">
                  <div class="card card-info card-outline w-100">
                    <div class="card-header">
                      <h3 class="card-title">
                        <@message "global.additional-information"/>
                      </h3>
                    </div>
                    <!-- /.card-header -->
                    <div class="card-body">
                      <div class="marked">
                        <template>${localize(dataset.model.additionalInformation)}</template>
                      </div>
                    </div>
                  </div>
                </div>
              </#if>
            </div>
          </#if>

          <@individualStudyList dataset.id/>

          <@harmonizationStudyList dataset.id/>

          <#if !(dataset.model.hide_var)?? || !dataset.model.hide_var>
          <div class="card card-info card-outline">
            <div class="card-header">
              <h3 class="card-title"><@message "harmonization"/></h3>
              <div class="float-right">
                <a href="${contextPath}/ws/harmonized-dataset/${dataset.id}/variables/harmonizations/_export" class="btn btn-sm btn-info">
                    <i class="fas fa-download"></i> <@message "download"/>
                </a>
                <a class="btn btn-sm btn-info" href="${contextPath}/${searchPageUrl}#lists?type=variables&query=dataset(in(Mica_dataset.id,${dataset.id}))"><@message "search-variables"/></a>
              </div>
            </div>
            <div class="card-body">
              <div class="row">
                <div class="col">
                  <@harmonizationTableLegend/>
                </div>
              </div>
              <div class="table-responsive mt-3">
                <div id="loadingSummary" class="spinner-border spinner-border-sm" role="status"></div>
                <table id="harmonizedTable" class="table table-striped">
                </table>
              </div>
            </div>
            <!-- to control the width without affecting other popovers -->
            <div id="harmo-status-popover"></div>
          </div>
          </#if>

          <!-- Variables classifications -->
          <#if datasetVariablesClassificationsTaxonomies?? && datasetVariablesClassificationsTaxonomies?size gt 0 && (!(dataset.model.hide_var)?? || !dataset.model.hide_var)>
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
          <span><@message "last-update"/>: <span class="text-muted moment-datetime">${dataset.lastModifiedDate.get().toString()}</span></span>
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
