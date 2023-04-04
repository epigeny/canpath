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
 <div class="navbar navbar-expand navbar-navy">
  <!-- Left navbar links -->

  <#if !(hideBarsIcon!false)>
  <ul class="navbar-nav">
    <li class="nav-item">
      <a class="nav-link" data-widget="pushmenu" href="#">
            <i class="fas fa-bars"></i>
      </a>
    </li>
  </ul>
  </#if>

  <button class="navbar-toggler order-1" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse order-3" id="navbarCollapse">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
      <@leftmenus hideBarsIcon=hideBarsIcon></@leftmenus>
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
</nav>
