<!-- Default model macros -->
<#include "../libs/study.ftl">

<#macro networkList studyId>
  <div id="${studyId}-networks-card" class="row d-none">
    <div class="col-lg-12">
      <div class="card card-info card-outline">
        <div class="card-header">
          <h3 class="card-title"><@message "networks"/></h3>
        </div>
        <div class="card-body">
          <div class="tab-content">
            <div id="loading-networks-summary" class="spinner-border spinner-border-sm" role="status"></div>
            <table id="${studyId}-networks" class="table table-striped">
              <thead>
              <tr>
                <th><@message "acronym"/></th>
                <th><@message "name"/></th>
                <th><@message "studies"/></th>
              </tr>
              </thead>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</#macro>

<#macro individualStudyList studyId>
  <div id="${studyId}-individual-studies-card" class="row d-none">
    <div class="col-lg-12">
      <div class="card card-info card-outline">
        <div class="card-header">
          <h3 class="card-title"><@message "individual-studies-included"/></h3>
        </div>
        <div class="card-body">
          <div class="tab-content">
            <div id="loading-individual-studies-summary" class="spinner-border spinner-border-sm" role="status"></div>
            <table id="${studyId}-individual-studies" class="table table-striped">
              <thead>
              <tr>
                <th><@message "acronym"/></th>
                <th><@message "name"/></th>
                <th><@message "study-design"/></th>
                <th><@message "participants"/></th>
                <th style="width: 10% !important;"><@message "countries"/></th>
                <#if harmonizationStudyStudyTableShowVariables>
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

<#macro harmonizationStudyList studyId>
  <div id="${studyId}-harmonization-studies-card" class="row d-none">
    <div class="col-lg-12">
      <div class="card card-info card-outline">
        <div class="card-header">
          <h3 class="card-title"><@message "harmonization-studies-included"/></h3>
        </div>
        <div class="card-body">
          <div class="tab-content">
            <div id="loading-harmonization-studies-summary" class="spinner-border spinner-border-sm" role="status"></div>
            <table id="${studyId}-harmonization-studies" class="table table-striped">
              <thead>
              <tr>
                <th><@message "acronym"/></th>
                <th><@message "name"/></th>
                <#if harmonizationStudyStudyTableShowVariables>
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

<#macro datasetList studyId type>
  <div id="${studyId}-datasets-card" class="row d-none">
    <div class="col-lg-12">
      <div class="card card-info card-outline">
        <div class="card-header">
          <h3 class="card-title"><@message "datasets"/></h3>
        </div>
        <div class="card-body">
          <div class="tab-content">
            <div id="loading-datasets-summary" class="spinner-border spinner-border-sm" role="status"></div>
            <table id="${studyId}-datasets" class="table table-striped">
              <thead>
              <tr>
                <th><@message "name"/></th>
                <th><@message "type"/></th>
                <#if type == "Individual">
                  <th><@message "data-collection-events"/></th>
                </#if>
                <th><@message "variables"/></th>
              </tr>
              </thead>
            </table>
          </div>
        </div>
      </div>
    </div>
  </div>
</#macro>

<#macro studyMarkerPaper study>
  <div class="card card-info card-outline w-100">
    <div class="card-header">
      <h3 class="card-title">
          <@message "study.marker-paper"/>
      </h3>
    </div>
    <!-- /.card-header -->
    <div class="card-body">
        <p>
          ${study.model.markerPaper}
        </p>
        <#if (study.model.pubmedId)?has_content>
          <a href="http://www.ncbi.nlm.nih.gov/pubmed/${study.model.pubmedId}" target="_blank">PUBMED ${study.model.pubmedId}</a>
        </#if>
    </div>
  </div>
</#macro>

<#macro studyModel study type>
    <#if study.model??>
      <!-- Individual study -->
        <#if type == "Individual">
          <div class="row d-flex align-items-stretch">
            <#if (study.model.access)??>
            <div class="col-sm-12 col-md d-flex align-items-stretch">
              <@studyAccess study=study/>
            </div>
            </#if>

            <#if (study.model.markerPaper)?has_content>
              <div class="col-sm-12 col-md d-flex align-items-stretch">
                <@studyMarkerPaper study=study/>
              </div>
            </#if>

          </div>

          <div class="row">
            <#if localizedStringNotEmpty((study.model.info))>
              <div class="col-sm-12 col-lg-12">
                <div class="card card-info card-outline">
                  <div class="card-header">
                    <h3 class="card-title">
                        <@message "suppl-info"/>
                    </h3>
                  </div>
                  <div class="card-body">
                    <div class="tab-content">
                        ${localize(study.model.info)}
                    </div>
                  </div>
                </div>
              </div>
            </#if>
          </div>
        </#if>
    </#if>
</#macro>

<#macro studyOverview study type>
  <div class="card card-info card-outline w-100">
    <div class="card-header">
      <h3 class="card-title"><@message "overview"/></h3>
    </div>
    <div class="card-body pb-0">
      <div class="tab-content">
        <dl class="row striped mt-0 mb-1">
          <dt class="col-sm-4">
              <@message "acronym"/>
          </dt>
          <dd class="col-sm-8">
              ${localize(study.acronym)}
          </dd>
          <#if study.model??>
            <#if study.model.website??>
              <dt class="col-sm-4">
                  <@message "website"/>
              </dt>
              <dd class="col-sm-8">
                <a href="${study.model.website}" target="_blank">${localize(study.acronym)}</a>
              </dd>
            </#if>

            <#if study.model.funding??>
              <dt class="col-sm-4">
                  <@message "funding"/>
              </dt>
              <dd class="col-sm-8">
                  ${localize(study.model.funding)}
              </dd>
            </#if>
            <#if study.memberships.investigator??>
              <dt class="col-sm-4">
                  <@message "investigators"/>
              </dt>
              <dd class="col-sm-8" id="study-investigators">
                  <@memberList members=study.memberships.investigator role="investigator"/>
              </dd>
            </#if>
            <#if study.memberships.contact??>
              <dt class="col-sm-4">
                  <@message "contacts"/>
              </dt>
              <dd class="col-sm-8" id="study-contacts">
                  <@memberList members=study.memberships.contact role="contact"/>
              </dd>
            </#if>
          </#if>
        </dl>
      </div>
    </div>
  </div>
</#macro>

<!-- Custom model macros, to redefine some default model macros -->
<#macro studyAccess study>
  <div class="card card-info card-outline">
    <div class="card-header">
      <h3 class="card-title">
        <@message "study.access.label"/>
      </h3>
      <div class="card-tools">
        <button type="button" class="btn btn-tool" data-card-widget="collapse" data-toggle="tooltip" title="<@message "collapse"/>">
          <i class="fas fa-minus"></i></button>
      </div>
    </div>
    <!-- /.card-header -->
    <div class="card-body">
      <dl class="row">
        <dt class="col" title="<@message "study_taxonomy.vocabulary.methods-recruitments.description"/>">
          <@message "study.access.for"/>
        </dt>
        <dd class="col">
          <ul class="pl-3">
            <#list study.model.access as type>
              <li>
                <#assign text = "study_taxonomy.vocabulary.access.term." + type + ".title"/>
                <@message text/>
                <#if type == "other" && study.model.otherAccess??>
                  : ${localize(study.model.otherAccess)}
                </#if>
              </li>
            </#list>
          </ul>
        </dd>
      </dl>
    </div>
  </div>
</#macro>

<#macro generalDesing study>
    <div class="card card-info card-outline w-100">
      <div class="card-header">
        <h3 class="card-title"><@message "general-design"/></h3>
      </div>
      <div class="card-body pb-0">
        <div class="tab-content">
          <dl class="row striped">
            <#if study.model.methods.design??>
                <dt class="col-sm-4">
                  <span title="<@message "study_taxonomy.vocabulary.methods-design.description"/>">
                    <@message "study_taxonomy.vocabulary.methods-design.title"/>
                  </span>
                </dt>
                <dd class="col-sm-8">
                    <#assign text = "study_taxonomy.vocabulary.methods-design.term." + study.model.methods.design + ".title"/>
                    <@message text/>
                    <#if study.model.methods.design == "other" && study.model.methods.otherDesign??>
                      : ${localize(study.model.methods.otherDesign)}
                    </#if>
                </dd>
            </#if>

            <#if study.model.startYear??>
              <dt class="col-sm-4">
                  <@message "study.start-year"/>
              </dt>
              <dd class="col-sm-8">
                  ${study.model.startYear?c}
              </dd>
            </#if>

            <#if study.model.endYear??>
              <dt class="col-sm-4">
                  <@message "study.end-year"/>
              </dt>
              <dd class="col-sm-8">
                  ${study.model.endYear?c}
              </dd>
            </#if>

              <#if study.model.methods.followUpInfo??>
                <dt class="col-sm-4">
                  <@message "study.general-follow-up"/>
                </dt>
                <dd class="col-sm-8">
                  ${localize(study.model.methods.followUpInfo)}
                </dd>
            </#if>
            <#if study.model.methods?? && study.model.methods.recruitments??>
                <dt class="col-sm-4">
                  <span title="<@message "study_taxonomy.vocabulary.methods-recruitments.description"/>">
                    <@message "study.recruitment-sources"/>
                  </span>
                </dt>
                <dd class="col-sm-8">
                  <ul class="list-unstyled">
                      <#list study.model.methods.recruitments as type>
                        <li>
                            <#assign text = "study_taxonomy.vocabulary.methods-recruitments.term." + type + ".title"/>
                            <@message text/>
                            <#if type == "other" && study.model.methods.otherRecruitment??>
                              : ${localize(study.model.methods.otherRecruitment)}
                            </#if>
                        </li>
                      </#list>
                  </ul>
                </dd>
            </#if>
            <#if (study.model.numberOfParticipants.participant.number)??>
              <dt class="col-sm-4">
                <span>
                  <@message "numberOfParticipants.participants"/>
                </span>
              </dt>
              <dd class="col-sm-8">
                  ${study.model.numberOfParticipants.participant.number}
                  <#if study.model.numberOfParticipants.participant.noLimit == true>
                    (<@message "numberOfParticipants.no-limit"/>)
                  </#if>
              </dd>
            <#elseif study.model.numberOfParticipants.participant.noLimit?? && study.model.numberOfParticipants.participant.noLimit == true>
              <dt class="col-sm-4">
               <@message "numberOfParticipants.participants"/>
              </dt>
              <dd class="col-sm-8">
                <@message "numberOfParticipants.no-limit"/>
              </dd>
            </#if>
            <#if study.model.numberOfParticipants.sample.number??>
              <dt class="col-sm-4">
                <span>
                  <@message "numberOfParticipants.sample"/>
                </span>
              </dt>
              <dd class="col-sm-8">
                  ${study.model.numberOfParticipants.sample.number}
                  <#if study.model.numberOfParticipants.sample.noLimit == true>
                    (<@message "numberOfParticipants.no-limit"/>)
                  </#if>
              </dd>
            <#elseif study.model.numberOfParticipants.sample.noLimit?? && study.model.numberOfParticipants.sample.noLimit == true>
              <dt class="col-sm-4">
                <@message "numberOfParticipants.sample"/>
              </dt>
              <dd class="col-sm-8">
                <@message "numberOfParticipants.no-limit"/>
              </dd>
            </#if>
            <#if localizedStringNotEmpty((study.model.numberOfParticipants.info))>
                <dt class="col-sm-4">
                    <@message "study.number-participants-suppl-info"/>
                </dt>
                <dd class="col-sm-8">
                    ${localize(study.model.numberOfParticipants.info)}
                </dd>
              </tr>
            </#if>
            <#if localizedStringNotEmpty((study.model.methods.info))>
                <dt class="col-sm-4">
                    <@message "suppl-info"/>
                </dt>
                <dd class="col-sm-8">
                    ${localize(study.model.methods.info)}
                </dd>
            </#if>
          </dl>
        </div>
      </div>
    </div>
</#macro>

<#macro variablesClassifications study>
  <div id="loadingClassifications" class="spinner-border spinner-border-sm" role="status"></div>
  <div id="classificationsContainer" style="display: none;" class="card card-info card-outline">
    <div class="card-header">
      <h3 class="card-title"><@message "variables-classifications"/></h3>
    </div>
    <div class="card-body">
      <div>
        <div class="mb-4">
          <select id="select-bucket" class="form-control select2">
            <option value="_all" selected><#if type == "Individual"><@message "all-dces"/><#else><@message "all-populations"/></#if></option>
          </select>
        </div>
        <div id="chartsContainer"></div>
      </div>
      <div id="noVariablesClassifications" style="display: none">
        <span class="text-muted"><@message "no-variables-classifications"/></span>
      </div>
    </div>
  </div>
</#macro>

<#function canShowTimeline study>
  <#assign show = false>
  <#if study?? && study.populations?? && study.populations?size gt 0>
    <#list study.populations as population>
      <#assign show = show || (population.dataCollectionEvents?? && population.dataCollectionEvents?size gt 0)>
    </#list>
  </#if>
  <#return show>
</#function>