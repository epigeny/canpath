<#macro staticTopMenus>
  <li class="nav-item <#if .lang == "en">active</#if>">
    <a id="lang-en" href="#" onclick="UserService.changeLanguage('en')" class="nav-link pr-1" href="#">English</a>
  </li>
  <li class="nav-item">
    <span class="nav-link pl-0 pr-0">/</span>
  </li>
  <li class="nav-item <#if .lang == "fr">active</#if>">
    <a id="lang-fr" href="#" onclick="UserService.changeLanguage('fr')" class="nav-link pl-1" href="#">Français</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="<#if .lang == "fr">https://canpath.ca/fr/nouvelles-evenements/<#else>https://www.canpath.ca/news-events</#if>" target="_blank"><@message "news-events"/></a>
  </li>
</#macro>

<#macro portalOverview>
  <ul class="order-1 order-md-3 navbar-nav navbar-no-expand ml-auto">
    <li class="nav-item">
      <a class="nav-link" target="_blank" href="${portalNavOverviewUrl[.lang]}"><i class="fab fa-youtube"></i> <@message "portal-nav-overview"/></a>
    </li>
  </ul>

</#macro>

<#macro rightmenus>
  <#if user??>
    <@staticTopMenus/>
    <#if isAdministrator || isReviewer || isEditor>
      <li class="nav-item">
        <a href="${contextPath}/admin" class="nav-link">
          <@message "administration"/>
        </a>
      </li>
    </#if>
    <#if cartEnabled>
      <li class="nav-item">
        <a href="${contextPath}/cart" class="nav-link">
          <i class="fas fa-shopping-cart"></i>
          <span id="cart-count" class="badge badge-danger navbar-badge"></span>
        </a>
      </li>
      <#if listsEnabled>
        <li class="nav-item">
          <a href="${contextPath}/lists" class="nav-link" title="<@message "sets.set.title"/>">
            <i class="far fa-list-alt"></i>
            <span id="list-count" class="badge badge-danger navbar-badge" <#if !(sets?? && sets.variablesLists?has_content)>style="display: none"</#if>>
              <#if sets?? && sets.variablesLists?has_content>${sets.variablesLists?size}</#if>
            </span>
          </a>
        </li>
      </#if>
    </#if>
    <li class="nav-item dropdown">
      <a id="userMenu" href="#" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" class="nav-link dropdown-toggle"><i class="fas fa-user"></i> ${user.fullName}</a>
      <ul aria-labelledby="dropdownSubMenu1" class="dropdown-menu navbar-yellow border-0 shadow">
        <li><a href="${contextPath}/profile" class="dropdown-item"><@message "profile"/></a></li>
        <li><a href="#" onclick="UserService.signout();" class="dropdown-item"><@message "sign-out"/></a></li>
      </ul>
    </li>
  <#else>
    <@staticTopMenus/>
    <#if !showMaintenance>
    <li class="nav-item">
      <a class="nav-link pr-1" href="${contextPath}/signup"><@message "sign-up"/></a>
    </li>
    <li class="nav-item">
      <span class="nav-link pl-0 pr-0">|</span>
    </li>
    <li class="nav-item">
      <a class="nav-link pl-1" href="${contextPath}/signin<#if rc.requestUri != "/" && !rc.requestUri?contains("/forgot-password") && !rc.requestUri?contains("/just-registered") && !rc.requestUri?contains("/error") && !rc.requestUri?contains("/signin")>?redirect=${rc.requestUri}</#if>"><@message "sign-in"/></a>
    </li>
    </#if>
  </#if>
</#macro>
