<!-- Default model macros -->
<#include "../libs/population.ftl">

<!-- Custom model macros, to redefine some default model macros -->

<!-- Population model -->
<#macro populationModel population id=population.id>

  <!-- Individual study -->
  <div class="row">
    <#if population.model.selectionCriteria??>
      <div class="col-sm-12 col-lg-6">
        <div class="card">
          <div class="card-header">
            <h5 class="card-title">
              <@message "study.selection-criteria.label"/>
            </h5>
          </div>
          <!-- /.card-header -->
          <div class="card-body">
            <dl class="row">
              <#if population.model.selectionCriteria.gender??>
                <dt class="col-sm-4">
                  <@message "population.gender"/>
                </dt>
                <dd class="col-sm-8">
                  <div>${population.model.selectionCriteria.gender}</div>
                </dd>
              </#if>

              <#if population.model.selectionCriteria.ageMin??>
                <dt class="col-sm-4">
                  <@message "population.ageMin"/>
                </dt>
                <dd class="col-sm-8">
                  <div>${population.model.selectionCriteria.ageMin}</div>
                </dd>
              </#if>

              <#if population.model.selectionCriteria.ageMax??>
                <dt class="col-sm-4">
                  <@message "population.ageMax"/>
                </dt>
                <dd class="col-sm-8">
                  <div>${population.model.selectionCriteria.ageMax}</div>
                </dd>
              </#if>

              <#if population.model.selectionCriteria.pregnantWomen?? && population.model.selectionCriteria.pregnantWomen?size != 0>
                <dt class="col-sm-4" title="<@message "study_taxonomy.vocabulary.populations-selectionCriteria-pregnantWomen.description"/>">
                  <@message "study.selection-criteria.pregnant-women"/>
                </dt>
                <dd class="col-sm-8">
                  <ul class="pl-3">
                    <#list population.model.selectionCriteria.pregnantWomen as type>
                      <li>
                        <#assign text = "study_taxonomy.vocabulary.populations-selectionCriteria-pregnantWomen.term." + type + ".title"/>
                        <@message text/>
                      </li>
                    </#list>
                  </ul>
                </dd>
              </#if>

              <#if population.model.selectionCriteria.countriesIso?? && population.model.selectionCriteria.countriesIso?size != 0>
                <dt class="col-sm-4">
                  <@message "client.label.countries"/>
                </dt>
                <dd class="col-sm-8">
                  <ul class="pl-3">
                    <#list population.model.selectionCriteria.countriesIso as country>
                      <li>
                        <@message country/>
                      </li>
                    </#list>
                  </ul>
                </dd>
              </#if>

              <#if population.model.selectionCriteria.territory??>
                <dt class="col-sm-4">
                  <@message "study.selection-criteria.territory"/>
                </dt>
                <dd class="col-sm-8">
                  ${localize(population.model.selectionCriteria.territory)}
                </dd>
              </#if>

              <#if population.model.selectionCriteria.ethnicOrigin?? && population.model.selectionCriteria.ethnicOrigin?size != 0>
                <dt class="col-sm-4">
                  <@message "study.selection-criteria.ethnic-origin"/>
                </dt>
                <dd class="col-sm-8">
                  <ul class="pl-3">
                    <#list population.model.selectionCriteria.ethnicOrigin as item>
                      <li>${localize(item)}</li>
                    </#list>
                  </ul>
                </dd>
              </#if>

              <#if population.model.selectionCriteria.healthStatus?? && population.model.selectionCriteria.healthStatus?size != 0>
                <dt class="col-sm-4">
                  <@message "study.selection-criteria.health-status"/>
                </dt>
                <dd class="col-sm-8">
                  <ul class="pl-3">
                    <#list population.model.selectionCriteria.healthStatus as item>
                      <li>${localize(item)}</li>
                    </#list>
                  </ul>
                </dd>
              </#if>

              <#if population.model.selectionCriteria.otherCriteria??>
                <dt class="col-sm-4">
                  <@message "population.otherCriteria"/>
                </dt>
                <dd class="col-sm-8">
                  ${localize(population.model.selectionCriteria.otherCriteria)}
                </dd>
              </#if>

              <#if population.model.selectionCriteria.info??>
                <dt class="col-sm-4">
                  <@message "population.info"/>
                </dt>
                <dd class="col-sm-8">
                  ${localize(population.model.selectionCriteria.info)}
                </dd>
              </#if>
            </dl>
          </div>
          <!-- /.card-body -->
        </div>
      </div>
    </#if>

    <#if population.model.recruitment?? || population.model.numberOfParticipants??>
      <div class="col-sm-12 col-lg-6">

        <#if population.model.recruitment??>
          <div class="card">
            <div class="card-header">
              <h3 class="card-title">
                <@message "population.recruitment"/>
              </h3>
            </div>
            <!-- /.card-header -->
            <div class="card-body">
              <dl class="row">

                <#if population.model.recruitment.dataSources?? && population.model.recruitment.dataSources?size != 0>
                  <dt class="col-sm-6" title="<@message "study_taxonomy.vocabulary.populations-recruitment-dataSources.description"/>">
                    <@message "study_taxonomy.vocabulary.populations-recruitment-dataSources.title"/>
                  </dt>
                  <dd class="col-sm-6">
                    <ul class="pl-3">
                      <#list population.model.recruitment.dataSources as type>
                        <li>
                          <#assign text = "study_taxonomy.vocabulary.populations-recruitment-dataSources.term." + type + ".title"/>
                          <@message text/>
                          <#if type == "other" && population.model.recruitment.otherSource??>
                            : ${localize(population.model.recruitment.otherSource)}
                          </#if>
                        </li>
                      </#list>
                    </ul>
                  </dd>
                </#if>

                <#if population.model.recruitment.generalPopulationSources?? && population.model.recruitment.generalPopulationSources?size != 0>
                  <dt class="col-sm-6" title="<@message "study_taxonomy.vocabulary.populations-recruitment-generalPopulationSources.description"/>">
                    <@message "study.recruitment-sources.general-population"/>
                  </dt>
                  <dd class="col-sm-6">
                    <ul class="pl-3">
                      <#list population.model.recruitment.generalPopulationSources as type>
                        <li>
                          <#assign text = "study_taxonomy.vocabulary.populations-recruitment-generalPopulationSources.term." + type + ".title"/>
                          <@message text/>
                        </li>
                      </#list>
                    </ul>
                  </dd>
                </#if>

                <#if population.model.recruitment.specificPopulationSources?? && population.model.recruitment.specificPopulationSources?size != 0>
                  <dt class="col-sm-6" title="<@message "study_taxonomy.vocabulary.populations-recruitment-specificPopulationSources.description"/>">
                    <@message "study.recruitment-sources.specific-population"/>
                  </dt>
                  <dd class="col-sm-6">
                    <ul class="pl-3">
                      <#list population.model.recruitment.specificPopulationSources as type>
                        <li>
                          <#assign text = "study_taxonomy.vocabulary.populations-recruitment-specificPopulationSources.term." + type + ".title"/>
                          <@message text/>
                          <#if type == "other" && population.model.recruitment.otherSpecificPopulationSource??>
                            : ${localize(population.model.recruitment.otherSpecificPopulationSource)}
                          </#if>
                        </li>
                      </#list>
                    </ul>
                  </dd>
                </#if>

                <#if population.model.recruitment.studies?? && population.model.recruitment.studies?size != 0>
                  <dt class="col-sm-6">
                    <@message "study.recruitment-sources.studies"/>
                  </dt>
                  <dd class="col-sm-6">
                    <ul class="pl-3">
                      <#list population.model.recruitment.studies as item>
                        <li>${localize(item)}</li>
                      </#list>
                    </ul>
                  </dd>
                </#if>

              </dl>
            </div>
            <!-- /.card-body -->
          </div>
        </#if>

        <#if population.model.numberOfParticipants??>
          <div class="card">
            <div class="card-header">
              <h3 class="card-title">
                <@message "numberOfParticipants.label"/>
              </h3>
            </div>
            <!-- /.card-header -->
            <div class="card-body">
              <dl class="row">
                <#if population.model.numberOfParticipants.participant.number??>
                  <dt class="col-sm-6">
                    <@message "numberOfParticipants.participants"/>
                  </dt>
                  <dd class="col-sm-6">
                    ${population.model.numberOfParticipants.participant.number}
                    <#if population.model.numberOfParticipants.participant.noLimit == true>
                      (<@message "numberOfParticipants.no-limit"/>)
                    </#if>
                  </dd>
                <#else>
                  <dt class="col-sm-6">
                    <@message "numberOfParticipants.participants"/>
                  </dt>
                  <dd class="col-sm-6">
                    <#if population.model.numberOfParticipants.participant.noLimit?? && population.model.numberOfParticipants.participant.noLimit == true>
                      <@message "numberOfParticipants.no-limit"/>
                    <#else>
                      <i class="fas fa-minus"></i>
                    </#if>
                  </dd>
                </#if>

                <#if population.model.numberOfParticipants.sample.number??>
                  <dt class="col-sm-6">
                    <@message "numberOfParticipants.sample"/>
                  </dt>
                  <dd class="col-sm-6">
                    ${population.model.numberOfParticipants.sample.number}
                    <#if population.model.numberOfParticipants.sample.noLimit == true>
                      (<@message "numberOfParticipants.no-limit"/>)
                    </#if>
                  </dd>
                <#else>
                  <dt class="col-sm-6">
                    <@message "numberOfParticipants.sample"/>
                  </dt>
                  <dd class="col-sm-6">
                    <#if population.model.numberOfParticipants.sample.noLimit?? && population.model.numberOfParticipants.sample.noLimit == true>
                      <@message "numberOfParticipants.no-limit"/>
                    <#else>
                      <i class="fas fa-minus"></i>
                    </#if>
                  </dd>
                </#if>

                <#if population.model.numberOfParticipants.info??>
                  <dt class="col-sm-6">
                    <@message "population.info"/>
                  </dt>
                  <dd class="col-sm-6">
                    ${localize(population.model.numberOfParticipants.info)}
                  </dd>
                </#if>
              </dl>
            </div>
          </div>
        </#if>

      </div>
    </#if>
  </div>

  <!-- Harmonization study -->
  <!-- place model rules here -->

  <!-- Files -->
  <#if showStudyPopulationFiles>
    <@populationFilesBrowser id=id/>
  </#if>
</#macro>