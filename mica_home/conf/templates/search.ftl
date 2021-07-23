<!-- Macros -->
<#include "models/search.ftl">

<!DOCTYPE html>
<html lang="${.lang}" xmlns:v-bind="http://www.w3.org/1999/xhtml">
<head>
  <#include "libs/head.ftl">
  <title>Search - ${config.name!""}</title>
  <link rel="stylesheet" href="${assetsPath}/libs/node_modules/vue-mica-search/dist/VueMicaSearch.css" />
</head>
<body id="search-page" class="hold-transition layout-top-nav layout-navbar-fixed">
<!-- Site wrapper -->
<div class="wrapper" id="search-application" v-cloak>

  <!-- Navbar -->
  <#assign hideBarsIcon=true>
  <#include "libs/aside-navbar.ftl">
  <!-- /.navbar -->

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header bg-info pb-0">
      <div class="container-fluid">
        <h1><@message "search"/></h1>
      </div>

      <@searchInfo/>

    </section>

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
          <nav id="sidebar" class="col-xs-12 col-sm-12 col-lg-2 sidebar sidebar-light-primary mt-0">
            <search-criteria></search-criteria>
          </nav>

          <div class="col-xs-12 col-sm-12 col-lg-10">
            <div id="query-builder" class="card card-info card-outline" v-if="!noQueries">
              <div class="card-header d-flex align-items-center py-2">
                <h3 class="card-title"><@message "query"/></h3>
                <div class="card-tools ml-auto">
                  <a class="btn btn-secondary btn-sm ml-2" href="javascript:void(0)" @click="onSearchModeToggle" v-cloak>
                    <span v-if="advanceQueryMode" title="<@message "search.basic-help"/>"><@message "search-basic-mode"/></span>
                    <span v-else title="<@message "search.advanced-help"/>"><@message "search-advanced-mode"/></span>
                  </a>
                  <#if showCopyQuery>
                    <div class="btn-group ml-2">
                      <button type="button" class="btn btn-sm btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false"><@message "global.copy-query"/></button>
                      <ul class="dropdown-menu dropdown-menu-right">
                        <li class="pr-3 pl-3 pt-3">
                          <div class="input-group mb-2">
                            <input v-model="queryToCopy" disabled type="text" class="form-control" style="width: 300px;">
                            <div class="input-group-append">
                              <button class="btn btn-outline-secondary" type="button" @click="onCopyQuery"
                                      title="<@message "global.copy-to-clipboard"/>">
                                <i class="fas fa-copy"></i></button>
                            </div>
                          </div>
                          <div class="text-muted">
                            <small><@message "search.query-copy-help"/></small>
                          </div>
                        </li>
                      </ul>
                    </div>
                  </#if>
                  <button type="button" class="btn btn-sm btn-default" @click="onClearQuery" title="<@message "search-tooltip.clear"/>">
                    <@message "clear"/>
                  </button>
                </div>
              </div>
              <div class="card-body py-2">
                <div>
                  <div class="text-muted" v-show="noQueries">
                    <@message "no-query"/>
                  </div>

                  <!-- Query Builder -->
                  <rql-query-builder v-if="queries['network']" v-bind:target="'network'" v-bind:taxonomy="getTaxonomyForTarget('network')" v-bind:query="queries['network']" v-bind:advanced-mode="advanceQueryMode" @update-node="onNodeUpdate" @update-query="onQueryUpdate" @remove-query="onQueryRemove"></rql-query-builder>

                  <rql-query-builder v-if="queries['study']" v-bind:target="'study'" v-bind:taxonomy="getTaxonomyForTarget('study')" v-bind:query="queries['study']" v-bind:advanced-mode="advanceQueryMode" @update-node="onNodeUpdate" @update-query="onQueryUpdate" @remove-query="onQueryRemove"></rql-query-builder>

                  <rql-query-builder v-if="queries['dataset']" v-bind:target="'dataset'" v-bind:taxonomy="getTaxonomyForTarget('dataset')" v-bind:query="queries['dataset']" v-bind:advanced-mode="advanceQueryMode" @update-node="onNodeUpdate" @update-query="onQueryUpdate" @remove-query="onQueryRemove"></rql-query-builder>

                  <rql-query-builder v-if="queries['variable']" v-bind:target="'variable'" v-bind:taxonomy="getTaxonomyForTarget('variable')" v-bind:query="queries['variable']" v-bind:advanced-mode="advanceQueryMode" @update-node="onNodeUpdate" @update-query="onQueryUpdate" @remove-query="onQueryRemove"></rql-query-builder>
                </div>
              </div>
              <!-- /.card-body -->
            </div>

            <div class="card" id="results-tab-content">
              <div class="card-header p-0">
                <div class="row">
                  <div class="col">
                    <ul id="search-tabs" class="nav nav-tabs h6 border-bottom-0">
                      <#if searchListDisplay>
                        <li class="nav-item"><a id="lists-tab" class="nav-link active py-3" href="#tab_lists" data-toggle="tab" @click="onSelectSearch()"><@message "search.list"/></a></li>
                      </#if>
                      <#if searchCoverageDisplay>
                        <li class="nav-item"><a id="coverage-tab" class="nav-link py-3" href="#tab_coverage" data-toggle="tab" @click="onSelectCoverage()"><@message "search.coverage"/></a></li>
                      </#if>
                      <#if searchGraphicsDisplay>
                        <li class="nav-item"><a id="graphics-tab" class="nav-link py-3" href="#tab_graphics" data-toggle="tab" @click="onSelectGraphics()"><@message "search.graphics"/></a></li>
                      </#if>
                    </ul>
                  </div>

                  <div v-if="display !== 'graphics'" class="col my-auto">
                    <div class="float-right pr-2">
                      <#if cartEnabled>
                        <#if listsEnabled>
                          <div class="btn-group ml-2">
                            <button id="cart-add-variables" type="button" class="btn btn-sm btn-info dropdown-toggle" data-toggle="dropdown" title="<@message "sets.add.button.set-label"/>"><i class="fas fa-cart-plus"></i></button>
                            <div ref="listsDropdownMenu" class="dropdown-menu dropdown-menu-right" style="min-width: 24em;">
                              <form class="px-3 py-3" v-if="numberOfSetsRemaining > 0">

                                <div class="form-group mb-0">
                                  <div class="input-group">
                                    <input type="text" class="form-control" placeholder="<@message "sets.add.modal.create-new"/>" v-model="newVariableSetName" @keyup.enter.prevent.stop="onAddToSet()">
                                    <div class="input-group-append">
                                      <button v-bind:class="{ disabled: !newVariableSetName }" class="btn btn-info" type="button" @click="onAddToSet()">
                                        <i class="fa fa-plus"></i> <@message "global.add"/>
                                      </button>
                                    </div>
                                  </div>
                                </div>

                              </form>
                              <div class="dropdown-divider" v-if="variableSets.length > 0 && numberOfSetsRemaining > 0"></div>
                              <button type="button" class="dropdown-item" v-for="set in variableSets" v-bind:key="set.id" @click="onAddToSet(set.id)">
                                {{ set.name }}
                                <span class="badge badge-light float-right">{{ set.count }}</span>
                              </button>
                            </div>
                          </div>

                        <#else>
                          <a href="${contextPath}/signin?redirect=${contextPath}/search" class="btn btn-info ml-2" title="<@message "sets.add.button.set-label"/>"><i class="fas fa-cart-plus"></i></a>
                        </#if>
                      </#if>
                      <#if downloadQueryEnabled>
                        <a id="download-query" href="javascript:void(0)" class="btn btn-default " @click="onDownloadQueryResult" title="<@message "download"/>"><i class="fas fa-download"></i> <@message "download"/></a>
                      </#if>
                    </div>
                  </div>
                </div>
              </div><!-- /.card-header -->

              <div class="card-body pt-0">
                <div class="tab-content">

                  <div class="tab-pane active" id="tab_lists">
                    <p class="text-muted mt-3">
                      <@message "results-lists-text"/>
                    </p>

                    <div class="my-3" v-cloak>
                      <ul class="nav nav-pills" id="results-tab" role="tablist">
                          <#if searchVariableListDisplay>
                            <li class="nav-item variables">
                              <a class="nav-link active" id="variables-tab" data-toggle="pill" href="#variables" role="tab" @click="onSelectResult('variables', 'variable')"
                                 aria-controls="variables" aria-selected="true"><@message "variables"/> <span id="variable-count" class="pl-1">{{counts.variables}}</span></a>
                            </li>
                          </#if>
                        <#if searchDatasetListDisplay>
                          <li class="nav-item datasets">
                            <a class="nav-link" id="datasets-tab" data-toggle="pill" href="#datasets" role="tab" @click="onSelectResult('datasets', 'dataset')"
                               aria-controls="datasets" aria-selected="false"><@message "datasets"/> <span id="dataset-count" class="pl-1">{{counts.datasets}}</span></a>
                          </li>
                        </#if>
                        <#if searchStudyListDisplay>
                          <li class="nav-item studies">
                            <a class="nav-link" id="studies-tab" data-toggle="pill" href="#studies" role="tab" @click="onSelectResult('studies', 'study')"
                                aria-controls="studies" aria-selected="false"><@message "studies"/> <span id="study-count" class="pl-1">{{counts.studies}}</span></a>
                          </li>
                        </#if>
                        <#if searchNetworkListDisplay>
                          <li class="nav-item networks">
                            <a class="nav-link" id="networks-tab" data-toggle="pill" href="#networks" role="tab" @click="onSelectResult('networks', 'network')"
                               aria-controls="networks" aria-selected="false"><@message "networks"/> <span id="network-count" class="pl-1">{{counts.networks}}</span></a>
                          </li>
                        </#if>
                      </ul>
                    </div>
                    
                    <div class="mt-3">
                      <div class="tab-content" id="results-tabContent">

                        <div v-show="loading" class="spinner-border spinner-border-sm" role="status"></div>

                        <#if searchVariableListDisplay>
                          <div class="tab-pane fade show active" id="variables" role="tabpanel" aria-labelledby="variables-tab">
                            <p class="text-muted"><@message "results-list-of-variables-text"/></p>
                            <div id="list-variables">
                              <div class="mt-3 text-muted" v-show="!loading && !hasListResult">{{ "no-variable-found" | translate }}</div>
                              <variables-result v-show="!loading && hasListResult"></variables-result>
                            </div>
                          </div>
                        </#if>
                        <#if searchDatasetListDisplay>
                          <div class="tab-pane fade" id="datasets" role="tabpanel" aria-labelledby="datasets-tab">
                            <p class="text-muted"><@message "results-list-of-datasets-text"/></p>
                            <div id="list-datasets">
                              <div class="mt-3 text-muted" v-show="!loading && !hasListResult">{{ "no-dataset-found" | translate }}</div>
                              <datasets-result v-show="!loading && hasListResult"></datasets-result>
                            </div>
                          </div>
                        </#if>
                        <#if searchStudyListDisplay>
                          <div class="tab-pane fade" id="studies" role="tabpanel" aria-labelledby="studies-tab">
                            <p class="text-muted"><@message "results-list-of-studies-text"/></p>
                            <div id="list-studies">
                              <div class="mt-3 text-muted" v-show="!loading && !hasListResult">{{ "no-study-found" | translate }}</div>
                              <studies-result v-show="!loading && hasListResult"></studies-result>
                            </div>
                          </div>
                        </#if>
                        <#if searchNetworkListDisplay>
                          <div class="tab-pane fade" id="networks" role="tabpanel" aria-labelledby="networks-tab">
                            <p class="text-muted"><@message "results-list-of-networks-text"/></p>
                            <div id="list-networks">
                              <div class="mt-3 text-muted" v-show="!loading && !hasListResult">{{ "no-network-found" | translate }}</div>
                              <networks-result v-show="!loading && hasListResult"></networks-result>
                            </div>
                          </div>
                        </#if>
                      </div>
                    </div>
                  </div>
                  <!-- /.tab-pane -->

                  <#if searchCoverageDisplay>

                    <div class="tab-pane" id="tab_coverage">

                      <div class="mt-3 text-muted" v-show="!hasVariableQuery">{{ "missing-variable-query" | translate }}</div>

                      <div v-show="hasVariableQuery">
                        <div id="coverage">
                          <div class="mb-3">
                            <div class="mt-4 mb-2 clearfix">
                              <ul class="nav nav-pills float-left" role="tablist">
                                <li class="nav-item">
                                  <a class="nav-link active"
                                    data-toggle="pill"
                                    id="bucket-dataset-tab"
                                    href role="tab"
                                    @click="onSelectBucket('dataset')"
                                    aria-controls="dataset"
                                    aria-selected="true">{{ bucketTitles.dataset }}</a>
                                </li>
                              </ul>

                              <ul class="nav nav-pills float-right" role="tablist">
                                <li class="ml-3">
                                  <div class="dropleft">
                                    <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown"><@message "search.filter"/></button>

                                    <div class="dropdown-menu">
                                      <button type="button" @click="onFullCoverage()" class="dropdown-item" v-bind:class="{ disabled: !canDoFullCoverage }">
                                        <@message "search.coverage-select.full"/>
                                      </button>
                                      <button type="button" @click="onZeroColumnsToggle()" class="dropdown-item" v-bind:class="{ disabled: !hasCoverageTermsWithZeroHits }">
                                        <@message "search.coverage-without-zeros"/>
                                      </button>
                                    </div>
                                  </div>
                                </li>
                              </ul>
                            </div>

                          </div>

                          <div v-show="loading" class="spinner-border spinner-border-sm mt-3" role="status"></div>
                          <div class="mt-3 text-muted" v-show="!loading && !hasCoverageResult">{{ "no-coverage-available" | translate }}</div>
                          <coverage-result v-show="!loading && hasCoverageResult" class="mt-2"></coverage-result>
                        </div>
                      </div>

                    </div>
                  </#if>
                  <!-- /.tab-pane -->

                  <#if searchGraphicsDisplay>
                    <div class="tab-pane" id="tab_graphics">
                      <p class="text-muted mt-3">
                        <@message "results-graphics-text"/>
                      </p>
                      <div id="graphics">
                        <div v-show="loading" class="spinner-border spinner-border-sm" role="status"></div>
                        <div class="mt-3 text-muted" v-show="!loading && !hasGraphicsResult">{{ "no-graphics-result" | translate }}</div>
                        <graphics-result v-show="!loading && hasGraphicsResult" v-bind:chart-options="chartOptions"></graphics-result>
                      </div>
                    </div>
                  </#if>
                  <!-- /.tab-pane -->
                </div>
                <!-- /.tab-content -->
              </div><!-- /.card-body -->
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <div class="modal fade" id="taxonomy-modal">
    <div class="modal-dialog modal-xl" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title"><@message "select-criteria"/></h5>

          <div>
            <#if searchNetworkListDisplay>
              <button type="button" class="btn btn-sm networks" data-dismiss="modal" @click="onSelectResult('networks', 'network')"><@message "networks"/> <span class="pl-1">{{counts.networks}}</span></button>
            </#if>

            <#if searchStudyListDisplay>
              <button type="button" class="btn btn-sm studies" data-dismiss="modal" @click="onSelectResult('studies', 'study')"><@message "studies"/> <span class="pl-1">{{counts.studies}}</span></button>
            </#if>

            <#if searchDatasetListDisplay>
              <button type="button" class="btn btn-sm datasets" data-dismiss="modal" @click="onSelectResult('datasets', 'dataset')"><@message "datasets"/> <span class="pl-1">{{counts.datasets}}</span></button>
            </#if>

            <#if searchVariableListDisplay>
              <button type="button" class="btn btn-sm variables" data-dismiss="modal" @click="onSelectResult('variables', 'variable')"><@message "variables"/> <span class="pl-1">{{counts.variables}}</span></button>
            </#if>
          </div>

          <button type="button" class="btn btn-sm btn-info" data-dismiss="modal"><span aria-hidden="true"><@message "global.close-panel"/></span></button>
        </div>
        <div class="modal-body" v-if="selectedTarget">
          <rql-panel v-bind:target="selectedTarget" v-bind:taxonomy="selectedTaxonomy" v-bind:query="selectedQuery" @update-query="onQueryUpdate" @remove-query="onQueryRemove"></rql-panel>
        </div>
      </div>
    </div>
  </div>
  <!-- /.modal -->

  <#include "libs/footer.ftl">
</div>
<!-- ./wrapper -->

<#include "libs/scripts.ftl">
<#include "libs/search-scripts.ftl">

</body>
</html>
