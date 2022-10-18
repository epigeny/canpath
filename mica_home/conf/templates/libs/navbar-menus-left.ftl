<#macro leftmenus hideBarsIcon=false>
  <li id="homeMenu" class="nav-item <#if rc.requestUri == "/">active</#if>">
    <a href="${contextPath}/" class="nav-link <#if !hideBarsIcon>pl-0</#if>"><@message "home"/></a>
  </li>
  <li id="cohortMenu" class="nav-item <#if rc.requestUri?ends_with("/individual-studies")>active</#if>">
    <a href="${contextPath}/individual-studies" class="nav-link"><@message "cohort"/></a>
  </li>
  <li id="dataMenu" class="nav-item <#if rc.requestUri?ends_with("/harmonization-studies")>active</#if>">
    <a href="${contextPath}/harmonization-studies" class="nav-link"><@message "data"/></a>
  </li>
  <li id="samplesMenu" class="nav-item <#if rc.requestUri?ends_with("/samples")>active</#if>">
    <a href="${contextPath}/page/samples" class="nav-link"><@message "biosamples"/></a>
  </li>
  <li id="researchMenu" class="nav-item dropdown <#if rc.requestUri?ends_with("/data-access-process") || rc.requestUri?ends_with("/projects")>active</#if>">
    <a href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="nav-link dropdown-toggle"><@message "research"/></a>
    <ul aria-labelledby="dropdownSubMenu1" class="dropdown-menu navbar-navy border-0 shadow">
      <li id="dataAccessProcessMenu" >
        <a href="${contextPath}/data-access-process" class="dropdown-item <#if rc.requestUri?ends_with("/data-access-process")>active</#if>"><@message "data-access-process"/></a>
      </li>
      <li id="projectMenu">
        <a href="<#if .lang?starts_with("fr")>https://canpath.ca/fr/projets-etudes-approuves/<#else>https://canpath.ca/approved-projects-studies/</#if>" target="_blank" class="dropdown-item"><@message "approved-projects"/></a>
      </li>
    </ul>
  </li>
  <li id="dataAccessMenu" class="nav-item">
    <a href="${contextPath}/data-accesses" class="btn btn-warning"><@message "data-access"/> <i class="fas fa-arrow-circle-right"></i></a>
  </li>
  <li id="searchMenu" class="nav-item <#if rc.requestUri?ends_with("/harmonization-search")>active</#if>">
    <a href="${contextPath}/harmonization-search${defaultSearchState}" class="nav-link"><@message "search"/></a>
  </li>
  <li class="nav-item <#if rc.requestUri?ends_with("/contact")>active</#if>">
    <a href="${contextPath}/contact" class="nav-link"><@message "contact-menu"/></a>
  </li>
</#macro>
