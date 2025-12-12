<#macro staticTopMenus>
  <li class="nav-item <#if .lang == "en">active</#if>">
    <a id="lang-en" href="#" onclick="agatejs.changeLanguage('en')" class="nav-link pe-1" href="#">English</a>
  </li>
  <li class="nav-item">
    <span class="nav-link ps-0 pe-0">/</span>
  </li>
  <li class="nav-item <#if .lang == "fr">active</#if>">
    <a id="lang-fr" href="#" onclick="agatejs.changeLanguage('fr')" class="nav-link ps-1" href="#">Français</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="<#if .lang == "fr">https://canpath.ca/fr/nouvelles-evenements/<#else>https://www.canpath.ca/news-events</#if>" target="_blank"><@message "news-events"/></a>
  </li>
</#macro>

<#macro rightmenus>
  <#if username??>
    <@staticTopMenus/>
    <li class="nav-item">
      <#if user??>
        <a href="${contextPath}/profile" class="nav-link">
          <i class="fa-solid fa-user"></i> ${user.displayName}
        </a>
      <#else>
        <span class="nav-link">
          <i class="fa-solid fa-user"></i> ${username}
        </span>
      </#if>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#" onclick="agatejs.signout();"><@message "sign-out"/></a>
    </li>
  <#else>
    <@staticTopMenus/>
    <li class="nav-item">
      <a class="nav-link pe-1" href="${portalLink}/signup"><@message "sign-up"/></a>
    </li>
    <li class="nav-item">
      <span class="nav-link ps-0 pe-0">|</span>
    </li>
    <li class="nav-item">
      <a class="nav-link ps-1" href="${contextPath}/signin"><@message "sign-in"/></a>
    </li>
  </#if>
</#macro>
