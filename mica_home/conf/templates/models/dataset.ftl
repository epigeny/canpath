<!-- Default model macros -->
<#include "../libs/dataset.ftl">

<!-- Custom model macros, to redefine some default model macros -->

<!-- Variables classifications -->
<#macro variablesClassifications dataset>
  <div id="loadingClassifications" class="spinner-border spinner-border-sm" role="status"></div>
  <div id="classificationsContainer" style="display: none;" class="card card-info card-outline">
    <div class="card-header">
      <h3 class="card-title"><@message "variables-classifications"/></h3>
    </div>
    <div class="card-body">
      <div>
        <div id="chartsContainer"></div>
      </div>
      <div id="noVariablesClassifications" style="display: none">
        <span class="text-muted"><@message "no-variables-classifications"/></span>
      </div>
    </div>
  </div>
</#macro>

<#macro individualStudy study population dce>
  <div class="col-sm-12 col-md d-flex align-items-stretch">
    <div class="card card-info card-outline w-100">
      <div class="card-header">
        <h3 class="card-title"><@message "individual-study"/></h3>
      </div>
      <div class="card-body">
        <div class="tab-content">
          <dl class="row striped mt-0 mb-1">
            <#if study??>
              <dt class="col-sm-4">
                  <@message "acronym"/>
              </dt>
              <dd class="col-sm-8">
                  <a href="${contextPath}/study/${study.id}">${localize(study.acronym)}</a>
              </dd>
              <dt class="col-sm-4">
                  <@message "name"/>
              </dt>
              <dd class="col-sm-8">
                  ${localize(study.name)}
              </dd>
            </#if>
            <#if population??>
              <dt class="col-sm-4">
                  <@message "population"/>
              </dt>
              <dd class="col-sm-8">
                  <a href="#" data-toggle="modal" data-target="#modal-population-${population.id}">${localize(population.name)}</a>
                  <@populationDialog id=population.id population=population></@populationDialog>
              </dd>
            </#if>
            <#if dce??>
              <dt class="col-sm-4">
                  <@message "data-collection-event"/>
              </dt>
              <dd class="col-sm-8">
                <a href="#" data-toggle="modal" data-target="#modal-${dce.id}">${localize(dce.name)}</a>
                <@dceDialog id=dce.id dce=dce></@dceDialog>
              </dd>
            </#if>
            <#if study??>
              <#if (study.model.methods.design)??>
                <dt class="col-sm-4">
                    <@message "study-design"/>
                </dt>
                <dd class="col-sm-8">
                    <@message "study_taxonomy.vocabulary.methods-design.term.${study.model.methods.design}.title"/>
                </dd>
              </#if>
              <#if (study.model.numberOfParticipants.participant.number)??>
                <dt class="col-sm-4">
                  <@message "numberOfParticipants.label"/>
                </dt>
                <dd class="col-sm-8">
                  ${study.model.numberOfParticipants.participant.number}
                </dd>
              </#if>
            </#if>
            <#if population??>
              <#if population.model.selectionCriteria.countriesIso?? && population.model.selectionCriteria.countriesIso?size != 0>
                <dt class="col-sm-4">
                    <@message "client.label.countries"/>
                </dt>
                <dd class="col-sm-8">
                  <ul class="list-inline list-comma-separated my-0">
                      <#list population.model.selectionCriteria.countriesIso as country>
                        <li class="list-inline-item"><@message country/></li>
                      </#list>
                  </ul>
                </dd>
              </#if>
            </#if>
          </dl>
        </div>
      </div>
    </div>
  </div>
</#macro>

<#macro harmonizationStudy study>
  <div class="col-sm-12 col-md d-flex align-items-stretch">
    <div class="card card-info card-outline w-100">
      <div class="card-header">
        <h3 class="card-title"><@message "harmonization-study"/></h3>
      </div>
      <div class="card-body">
        <div class="tab-content">
          <dl class="row striped mt-0 mb-1">
            <#if study??>
              <dt class="col-sm-4">
                  <@message "acronym"/>
              </dt>
              <dd class="col-sm-8">
                <a href="${contextPath}/study/${study.id}">${localize(study.acronym)}</a>
              </dd>
              <dt class="col-sm-4">
                  <@message "name"/>
              </dt>
              <dd class="col-sm-8">
                  ${localize(study.name)}
              </dd>
            </#if>
          </dl>
        </div>
      </div>
    </div>
  </div>
</#macro>

<#macro individualStudyList datasetId>
  <div id="${datasetId}-individual-studies-card" class="row d-none">
    <div class="col-lg-12">
      <div class="card card-info card-outline">
        <div class="card-header">
          <h3 class="card-title"><@message "global.included-individual-studies"/></h3>
        </div>
        <div class="card-body">
          <div class="tab-content">
            <div id="loading-individual-studies-summary" class="spinner-border spinner-border-sm" role="status"></div>
            <table id="${datasetId}-individual-studies" class="table table-striped">
              <thead>
              <tr>
                <th><@message "acronym"/></th>
                <th><@message "name"/></th>
                <th><@message "study-design"/></th>
                <th><@message "participants"/></th>
                <th style="width: 10% !important;"><@message "countries"/></th>
                <#if harmonizationDatasetStudyTableShowVariables>
                  <th style="width: 10% !important;"><@message "variables"/></th>
                </#if>
              </tr>
              </thead>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</#macro>

<#macro harmonizationStudyList datasetId>
  <div id="${datasetId}-harmonization-studies-card" class="row d-none">
    <div class="col-lg-12">
      <div class="card card-info card-outline">
        <div class="card-header">
          <h3 class="card-title"><@message "harmonization-studies-included"/></h3>
        </div>
        <div class="card-body">
          <div class="tab-content">
            <div id="loading-harmonization-studies-summary" class="spinner-border spinner-border-sm" role="status"></div>
            <table id="${datasetId}-harmonization-studies" class="table table-striped">
              <thead>
              <tr>
                <th><@message "acronym"/></th>
                <th><@message "name"/></th>
                <#if harmonizationDatasetStudyTableShowVariables>
                  <th style="width: 10% !important;"><@message "variables"/></th>
                </#if>
              </tr>
              </thead>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</#macro>

<#macro harmonizationTableLegend showMessage=true>
  <div class="pb-2">
    <#if showMessage>
      <p><@message "harmonization-table-legend-title"/></p>
    </#if>
    <ul id="harmonization-legend" class="list-unstyled">
      <li><i class="fas fa-check fa-fw text-success"></i><span class="pl-2"><@message "harmonization-complete"/></small></span></li>
      <li><i class="fas fa-times fa-fw text-danger"></i><span class="pl-2"><@message "harmonization-impossible"/></small></span></li>
      <li><i class="fas fa-ban fa-fw text-black"></i><span class="pl-2"><@message "harmonization-na"/></small></span></li>
      <li><i class="fas fa-question fa-fw text-warning"></i><span class="pl-2"><@message "harmonization-undetermined"/></small></span></li>
    </ul>
  </div>
</#macro>