<#include "navbar-menus.ftl">
<nav class="main-header">
  <#if showMaintenance>
  <div class="navbar navbar-expand-md navbar-yellow text-dark">
    <div class="py-3 bg-danger w-100 text-center">
      <strong>IMPORTANT: </strong><@message "maintenance-message"/>
    </div>
  </div> 
  </#if>
  <div class="navbar navbar-expand-md navbar-yellow text-dark">
    <div class="collapse navbar-collapse order-2" id="navbarCollapse">
      <!-- Right navbar links -->
      <ul class="order-1 order-md-3 navbar-nav navbar-no-expand">
        <@rightmenus></@rightmenus>
      </ul>
      <@portalOverview/>
    </div>
  </div>
  <div class="navbar navbar-expand-md navbar-navy">
    <div class="container">
      <button class="navbar-toggler order-1 ml-2" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
        <span class="fas fa-bars"></span>
      </button>
      <div class="collapse navbar-collapse ml-3 pl-0 order-2" id="navbarCollapse">
        <!-- Left navbar links -->
        <ul class="navbar-nav">
          <@leftmenus></@leftmenus>
        </ul>
      </div>
      <#if rc.requestUri != "/">
        <#if config??>
          <a href="${portalLink}" class="navbar-brand ml-3 order-3">
            <img src="${brandImageSrc}" alt="Logo" class="brand-image ${brandImageClass}">
          </a>
        <#else>
          <img src="${brandImageSrc}" alt="Logo" class="brand-image order-3 ${brandImageClass}">
        </#if>
      </#if>
    </div>
  </div>
</nav>

