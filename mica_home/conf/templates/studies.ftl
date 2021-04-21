<!-- Macros -->
<#include "libs/header.ftl">
<#include "models/studies.ftl">

<!-- Template variables -->
<#if !type??>
  <#assign title = "studies">
  <#assign countLabel = "studies">
  <#assign showTypeColumn = true>
<#elseif type == "Harmonization">
  <#assign title = "harmonization-studies">
  <#assign countLabel = "projects">
  <#assign showTypeColumn = false>
<#else>
  <#assign title = "individual-studies">
  <#assign countLabel = "studies">
  <#assign showTypeColumn = false>
</#if>

<!DOCTYPE html>
<html lang="${.lang}">
<head>
  <#include "libs/head.ftl">
  <title>${config.name!""} | <@message title/></title>
</head>
<body id="${title}-page" class="hold-transition layout-top-nav layout-navbar-fixed">
<div id="studies-app"  class="wrapper">

  <!-- Studies order -->
  <#if !type??>
    <#assign orderedStudies = orderStudies(studies, individualStudyOrder + harmonizationStudyOrder)/>
  <#elseif type == "Harmonization">
    <#assign orderedStudies = orderStudies(studies, harmonizationStudyOrder)/>
  <#else>
    <#assign orderedStudies = orderStudies(studies, individualStudyOrder)/>
 </#if>

    <!-- Navbar -->
  <#include "libs/top-navbar.ftl">
  <!-- /.navbar -->

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <@header title=title breadcrumb=[["${contextPath}/", "home"], [title]]/>
    <!-- /.content-header -->

    <!-- Main content -->
    <div class="content">
      <div class="container">
        <div id="${title}-callout" class="callout callout-info">
          <p><@message (title + "-callout")/></p>
        </div>

        <div v-show="loading" class="spinner-border spinner-border-sm" role="status"></div>
        <div v-show="!loading && entities && entities.length > 0" v-cloak>
          <#if studies?? && studies?size != 0>
          <div id="${title}-card" class="card card-info card-outline">

            <div class="card-header d-flex p-0">
              <h3 class="card-title p-3"><@message "studies"/></h3>
              <#if studyListDisplays?size gt 1>
                <ul class="nav nav-pills ml-auto p-2">
                  <#list studyListDisplays as display>
                    <#if display == "table">
                      <li class="nav-item"><a class="nav-link <#if studyListDefaultDisplay == "table">active</#if>" href="#table" data-toggle="tab">
                          <i class="fas fa-table"></i></a>
                      </li>
                    </#if>
                    <#if display == "lines">
                      <li class="nav-item"><a class="nav-link <#if studyListDefaultDisplay == "lines">active</#if>" href="#lines" data-toggle="tab">
                          <i class="fas fa-grip-lines"></i></a>
                      </li>
                    </#if>
                    <#if display == "cards">
                      <li class="nav-item"><a class="nav-link <#if studyListDefaultDisplay == "cards">active</#if>" href="#cards" data-toggle="tab">
                          <i class="fas fa-grip-horizontal"></i></a>
                      </li>
                    </#if>
                  </#list>
                </ul>
              </#if>
            </div><!-- /.card-header -->

            <div>
              <#if config.studyDatasetEnabled && config.harmonizationDatasetEnabled>
              <div class="pb-2 d-none">
                <div class="row">
                  <div class="col">
                    <div class="d-inline-flex float-right">
                      <sorting @sort-update="onSortUpdate" :initial-choice="initialSort" :options-translations="sortOptionsTranslations"></sorting>
                      <#if showPaginationInListingPages>
                      <nav id="obiba-pagination-top" aria-label="Top pagination" class="mt-0">
                        <ul class="pagination mb-0"></ul>
                      </nav>
                      </#if>
                    </div>
                  </div>

                </div>
              </div>
              </#if>

              <div class="tab-content">
                
                <div class="row d-flex align-items-stretch">
                  <div class="col-md-12 col-lg-6 d-flex align-items-stretch" v-for="study in entities" v-bind:key="study.id">
                    <div v-if="study.id !== ''" class="card w-100">
                      <div class="card-body">
                        <div class="row h-100">
                          <div class="col-xs-12 col">
                            <h4 class="lead">
                              <a v-bind:href="'${contextPath}/study/' + study.id" class="text-info mt-2">
                                <b>{{study.name | localize-string}}</b>
                              </a>
                            </h4>
                            <span class="marked"><span :inner-html.prop="study.objectives | localize-string | ellipsis(300, ('${contextPath}/study/' + study.id)) | markdown"></span></span>
                          </div>
                          <div class="col-3 mx-auto my-auto" v-if="study.logo">
                            <a v-bind:href="'${contextPath}/study/' + study.id" class="text-decoration-none text-info text-center">
                              <img class="img-fluid" style="max-height: 10em;" v-bind:alt="study.acronym | localize-string | concat(' logo')" v-bind:src="'${contextPath}/ws/study/' + study.id + '/file/' + study.logo.id + '/_download'"/>
                            </a>
                          </div>
                        </div>
                      </div>
                      <div class="card-footer py-1">
                        <div class="row pt-1 row-cols-4">
                          <template v-if="hasStats(study)">
                            <a v-if="study.model && study.model.methods" href="javascript:void(0)" style="cursor: initial;" class="btn btn-sm col text-left">
                              <span class="h6 pb-0 mb-0 d-block text-muted">{{study.model.methods.design | translate}}</span>
                              <span class="text-muted"><small>Study Design</small></span>
                            </a>
                            <a v-if="study.model && study.model.numberOfParticipants" href="javascript:void(0)" style="cursor: initial;" class="btn btn-sm col text-left">
                              <span class="h6 pb-0 mb-0 d-block text-muted">{{study.model.numberOfParticipants.participant.number | localize-number}}</span>
                              <span class="text-muted"><small>Number of Participants</small></span>
                            </a>
                            <dataset-stat-item
                                    v-bind:type="study.studyResourcePath"
                                    v-bind:stats="study['obiba.mica.CountStatsDto.studyCountStats']">
                            </dataset-stat-item>
                            <variable-stat-item
                                    v-bind:url="variablesUrl(study)"
                                    v-bind:type="study.studyResourcePath"
                                    v-bind:stats="study['obiba.mica.CountStatsDto.studyCountStats']">
                            </variable-stat-item>
                          </template>
                          <template v-else>
                            <!-- HACK used 'studiesWithVariables' with opacity ZERO to have the same height as the longest stat item -->
                            <a href="url" class="btn btn-sm btn-link text-info col text-left" style="opacity: 0">
                              <span class="h6 pb-0 mb-0 d-block">0</span>
                              <span class="text-muted"><small>Empty</small></span>
                            </a>
                          </template>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>

              </div>

              <#if showPaginationInListingPages>
                <div class="d-inline-flex pt-0 ml-auto float-right">
                  <nav id="obiba-pagination-bottom" aria-label="Bottom pagination" class="mt-0">
                    <ul class="pagination"></ul>
                  </nav>
                </div>
              </#if>

            </div>
          </div>
        <#else>
          <div id="${title}-card" class="card card-info card-outline">
            <div class="card-header d-flex p-0">
              <h3 class="card-title p-3"><@message "studies"/></h3>
            </div><!-- /.card-header -->
            <div class="card-body">
              <#if config.openAccess || user??>
                <p class="text-muted"><@message "no-studies"/></p>
              <#else>
                <p class="text-muted"><@message "sign-in-studies"/></p>
                <button type="button" onclick="location.href='${contextPath}/signin?redirect=${contextPath}/<#if type??>${type?lower_case}-</#if>studies';" class="btn btn-info btn-lg">
                  <i class="fas fa-sign-in-alt"></i> <@message "sign-in"/>
                </button>
              </#if>
            </div>
          </div>
        </#if>
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
<script src="${assetsPath}/libs/node_modules/vue/dist/vue.js"></script>
<script src="${assetsPath}/libs/node_modules/rql/dist/rql.js"></script>
<script src="${assetsPath}/js/mlstr-scripts.js"></script>
<script src="${assetsPath}/js/pagination.js"></script>
<script src="${assetsPath}/js/entities.js"></script>

<script>
  const Mica = {
    tr: MlstrTranslations
  };

  const sortOptionsTranslations = {
    'weight': '<@message "global.sort-weight"/>'
  };

  MlstrStudiesApp.build("#studies-app", "${title}", "${.lang}", sortOptionsTranslations);
</script>
</body>
</html>
