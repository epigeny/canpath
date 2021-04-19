<!-- Default model macros -->
<#include "../libs/member.ftl">

<!-- Member list by role -->
<#macro memberListCompact members role>
  <ul class="list-unstyled">
      <#assign i=0>
      <#list members as member>
        <li>
            <#assign i++>
          <a href="#" data-toggle="modal" data-target="#modal-${role}-${i}">
              ${member.person.title!""} ${member.person.firstName!""} ${member.person.lastName}

          </a>
            <#if member.person.institution?? && member.person.institution.name??>
              <span class="text-muted">(${localize(member.person.institution.name)})</span>
            </#if>

          <@memberDialog id="${role}-${i}" member=member/>
        </li>
      </#list>
  </ul>
</#macro>

<#macro memberDialog id member>
  <div class="modal fade" id="modal-${id}">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title"><#if member.person.firstName??>${member.person.firstName} </#if>${member.person.lastName}</h4>
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span>
          </button>
        </div>
        <div class="modal-body">
            <@memberModel member=member/>
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

<#macro memberList members role>
  <ul class="list-unstyled" style="columns: ${(members?size == 1)?then(1, 2)}">
      <#assign i=0>
      <#list members as member>
        <li class="mb-2">
          <#assign i++>
          <a class="text-info" href="#" data-toggle="modal" data-target="#modal-${role}-${i}">
              ${member.person.title!""} ${member.person.firstName!""} ${member.person.lastName}
          </a>
          <#if member.person.institution?? && member.person.institution.name??>
            <br/>
            <span class="text-muted">${localize(member.person.institution.name)}</span>
          </#if>
            <@memberDialog id="${role}-${i}" member=member/>
        </li>
      </#list>
  </ul>
</#macro>