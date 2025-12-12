<#include "navbar-menus.ftl">
<nav class="app-header">
  <div class="navbar navbar-expand-md navbar-yellow text-dark">
    <div>
      <!-- Top navbar items (left-aligned as requested) -->
      <ul class="navbar-nav">
        <@rightmenus></@rightmenus>
      </ul>
    </div>
  </div>
  <div class="navbar navbar-expand-md navbar-navy text-white">
    <div class="container">
      <button class="navbar-toggler order-1" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse order-2" id="navbarCollapse">
        <!-- Left navbar links -->
        <ul class="navbar-nav">
          <@leftmenus></@leftmenus>
        </ul>
      </div>
      <#if config??>
        <a href="${portalLink}" class="navbar-brand order-3">
          <img src="${brandImageSrc}" alt="Logo" class="brand-image ${brandImageClass}">
        </a>
      <#else>
        <img src="${brandImageSrc}" alt="Logo" class="brand-image order-3 ${brandImageClass}">
      </#if>
    </div>
  </div>
</nav>

