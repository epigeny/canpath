<!-- Default model macros -->
<#include "../libs/dce.ftl">

<!-- Custom model macros, to redefine some default model macros -->

<#function dateAsYearMonthName date="">
  <#if date?? && date?has_content>
    <#assign parts =date?split("-")>
    <#if parts?? && parts?size == 2>
      <#assign aDate = "${parts?first}${parts?last}01">
      <#return aDate?datetime("yyyyMMdd")?string("yyyy (MMMM)")>
    </#if>
  </#if>
  <#return date>
</#function>

<#macro dceModals population>
  <#if population.dataCollectionEvents?? && population.dataCollectionEvents?size != 0>
    <#list population.dataCollectionEventsSorted as dce>
        <#assign dceId="${population.id}-${dce.id}">
        <@dceDialog id=dceId dce=dce></@dceDialog>
    </#list>
  </#if>
</#macro>

<#macro dceList population>
  <!-- DCE list -->
    <#if population.dataCollectionEvents?? && population.dataCollectionEvents?size != 0>
      <div class="card">
        <div class="card-header">
          <h3 class="card-title">
            <@message "study.data-collection-events"/>
          </h3>
        </div>
        <div class="card-body">
          <table id="population-${population.id}-dces" class="table table-striped">
            <thead>
            <tr>
              <th>#</th>
              <th class="w-25"><@message "name"/></th>
              <th class="w-50"><@message "description"/></th>
              <th style="width: 12em !important;"><@message "study.start"/></th>
              <th style="width: 12em !important;"><@message "study.end"/></th>
            </tr>
            </thead>
            <tbody>
            <#list population.dataCollectionEventsSorted as dce>
                <#assign dceId="${population.id}-${dce.id}">
              <tr>
                <td>${dce.weight}</td>
                <td>
                  <a href="#" data-toggle="modal" data-target="#modal-${dceId}">
                      ${localize(dce.name)}
                  </a>
                </td>
                <td class="marked"><template>${localize(dce.description)?trim?truncate(150, "...")}</template></td>
                <td><#if dce.start?? && dce.start.yearMonth??>${dateAsYearMonthName(dce.start.yearMonth)}</#if></td>
                <td><#if dce.end?? && dce.end.yearMonth??>${dateAsYearMonthName(dce.end.yearMonth)}</#if></td>
              </tr>
            </#list>
            </tbody>
          </table>
        </div>
      </div>
    </#if>
</#macro>

<#macro dceModel dce>
    <#if dce.model.dataSources?? && dce.model.dataSources?size != 0>
      <dt class="col-sm-4" title="<@message "study_taxonomy.vocabulary.populations-dataCollectionEvents-dataSources.description"/>">
          <@message "study_taxonomy.vocabulary.populations-dataCollectionEvents-dataSources.title"/>
      </dt>
      <dd class="col-sm-8">
        <ul class="list-unstyled">
            <#list dce.model.dataSources as item>
              <li>
                  <#assign txt = "study_taxonomy.vocabulary.populations-dataCollectionEvents-dataSources.term." + item + ".title"/>
                  <@message txt/>
                  <#if item == "others" && dce.model.otherDataSources??>
                    : ${localize(dce.model.otherDataSources)}
                  </#if>
              </li>
            </#list>
        </ul>
      </dd>
    </#if>

    <#if dce.model.bioSamples?? && dce.model.bioSamples?size != 0>
      <dt class="col-sm-4" title="<@message "study_taxonomy.vocabulary.populations-dataCollectionEvents-bioSamples.description"/>">
          <@message "study_taxonomy.vocabulary.populations-dataCollectionEvents-bioSamples.title"/>
      </dt>
      <dd class="col-sm-8">
        <ul class="list-unstyled">
            <#list dce.model.bioSamples as item>
              <li>
                  <#assign txt = "study_taxonomy.vocabulary.populations-dataCollectionEvents-bioSamples.term." + item + ".title"/>
                  <@message txt/>
                  <#if item == "tissues" && dce.model.tissueTypes??>
                    : ${localize(dce.model.tissueTypes)}
                  <#elseif item == "others" && dce.model.otherBioSamples??>
                    : ${localize(dce.model.otherBioSamples)}
                  </#if>
              </li>
            </#list>
        </ul>
      </dd>
    </#if>

    <#if dce.model.administrativeDatabases?? && dce.model.administrativeDatabases?size != 0>
      <dt class="col-sm-4" title="<@message "study_taxonomy.vocabulary.populations-dataCollectionEvents-administrativeDatabases.description"/>">
          <@message "study_taxonomy.vocabulary.populations-dataCollectionEvents-administrativeDatabases.title"/>
      </dt>
      <dd class="col-sm-8">
        <ul class="list-unstyled">
            <#list dce.model.administrativeDatabases as item>
              <li>
                  <#assign txt = "study_taxonomy.vocabulary.populations-dataCollectionEvents-administrativeDatabases.term." + item + ".title"/>
                  <@message txt/>
              </li>
            </#list>
        </ul>
      </dd>
    </#if>
</#macro>

<#macro dceDialog id dce>
  <div class="modal fade" id="modal-${id}">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">${localize(dce.name)}</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
          <div class="mb-3 marked">
            <template>${localize(dce.description)}</template>
          </div>
          <dl class="row striped border">
              <#if dce.start??>
                <dt class="col-sm-4">
                    <@message "start-date"/>
                </dt>
                <dd class="col-sm-8">
                  <div>${dateAsYearMonthName(dce.start.yearMonth)}</div>
                </dd>
              </#if>
              <#if dce.end??>
                <dt class="col-sm-4">
                    <@message "end-date"/>
                </dt>
                <dd class="col-sm-8">
                  <div>${dateAsYearMonthName(dce.end.yearMonth)}</div>
                </dd>
              </#if>

              <@dceModel dce=dce/>
          </dl>
            <#if showStudyDCEFiles>
                <@dceFilesBrowser id=id/>
            </#if>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-success" data-dismiss="modal"><@message "close"/></button>
        </div>
      </div>
      <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
  </div>
  <!-- /.modal -->
</#macro>
