<#macro leftmenus>
  <li id="homeMenu" class="nav-item <#if springMacroRequestContext.requestUri == "/">active</#if>">
    <a href="${portalLink}/" class="nav-link"><@message "home"/></a>
  </li>
  <li id="cohortMenu" class="nav-item <#if springMacroRequestContext.requestUri?ends_with("/individual-studies")>active</#if>">
    <a href="${portalLink}/individual-studies" class="nav-link"><@message "cohort"/></a>
  </li>
  <li id="dataMenu" class="nav-item <#if springMacroRequestContext.requestUri?ends_with("/harmonization-studies")>active</#if>">
    <a href="${portalLink}/harmonization-studies" class="nav-link"><@message "data"/></a>
  </li>
  <li id="samplesMenu" class="nav-item <#if springMacroRequestContext.requestUri?ends_with("/samples")>active</#if>">
    <a href="${portalLink}/page/samples" class="nav-link"><@message "biosamples"/></a>
  </li>
  <li id="researchMenu" class="nav-item dropdown <#if springMacroRequestContext.requestUri?ends_with("/data-access-process") || springMacroRequestContext.requestUri?ends_with("/projects")>active</#if>">
    <a href="#" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="nav-link dropdown-toggle"><@message "research"/></a>
    <ul aria-labelledby="dropdownSubMenu1" class="dropdown-menu navbar-navy border-0 shadow">
      <li id="dataAccessProcessMenu" >
        <a href="${portalLink}/data-access-process" class="dropdown-item <#if springMacroRequestContext.requestUri?ends_with("/data-access-process")>active</#if>"><@message "data-access-process"/></a>
      </li>
      <li id="projectMenu">
        <a href="${portalLink}/projects" class="dropdown-item <#if springMacroRequestContext.requestUri?ends_with("/projects")>active</#if>"><@message "approved-projects"/></a>
      </li>
    </ul>
  </li>
  <li id="dataAccessMenu" class="nav-item">
    <a href="${portalLink}/data-accesses" class="btn btn-warning"><@message "data-access"/> <i class="fa-solid fa-arrow-circle-right"></i></a>
  </li>
  <li id="searchMenu" class="nav-item <#if springMacroRequestContext.requestUri?ends_with("/search")>active</#if>">
    <a href="${portalLink}/search${defaultSearchState}" class="nav-link"><@message "search"/></a>
  </li>
  <li class="nav-item <#if springMacroRequestContext.requestUri?ends_with("/contact")>active</#if>">
    <a href="${portalLink}/contact" class="nav-link"><@message "contact-menu"/></a>
  </li>
</#macro>
