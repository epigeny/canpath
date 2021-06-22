<!-- Macros -->
<#include "libs/header.ftl">
<#include "models/index.ftl">

<!DOCTYPE html>
<html lang="${.lang}">
<head>
  <title>${config.name!""}</title>
  <#include "libs/head.ftl">
</head>
<body id="index-page" class="hold-transition layout-top-nav layout-navbar-fixed">
<div class="wrapper">

  <!-- Navbar -->
  <#include "libs/top-navbar.ftl">
  <!-- /.navbar -->


  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">

    <div class="jumbotron jumbotron-fluid">
      <div class="container">
        <div class="row">
          <div class="col-lg-2"></div>
          <div class="col-lg-8">
            <h1 class="text-center"><@message "data-portal-title"/></h1>
            <p class="lead text-center">
              <@message "data-portal-text"/>
            </p>
          </div>
          <div class="col-lg-2">
            <div class="logo-canpath">
              <#if config??>
                <a href="${portalLink}" class="navbar-brand order-3">
                  <img src="/assets/images/logo_${.lang}.png" alt="CanPath Portal">
                </a>
              <#else>
                <img src="/assets/images/logo_${.lang}.png" alt="CanPath Portal">
              </#if>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Main content -->
    <div class="content">
      <div class="container">
        <div class="row">
          <div class="col-lg-3 col-sm-12">
            <div class="title-center">
              <h2 class="text-center"><@message "cohort"/></h2>
            </div>
            <div>
              <div class="text-center"><a href="/individual-studies"><img alt="Cohort design"
                                            src="/assets/images/icon_mica_cohorts_0.png"
                                            style="width: 250px; height: 217px;"></a>
              </div>
            </div>
            <p class="text-center">&nbsp;</p>
            <p class="text-center"><@message "cohort-text"/></p>
            <p class="text-center"><a href="/individual-studies"><@message "global.read-more"/></a></p>
          </div>
          <div class="col-lg-3 col-sm-12">
            <div class="title-center">
              <h2 class="text-center"><@message "data"/></h2>
            </div>
            <div>
              <div class="text-center"><a href="/harmonization-studies"><img alt="Data"
                                               src="/assets/images/icon_mica_datasets_0.png"
                                               style="width: 250px; height: 217px;"></a>
              </div>
            </div>
            <p class="text-center">&nbsp;</p>
            <p class="text-center"><@message "data-text"/></p>
            <p class="text-center"><a href="/harmonization-studies"><@message "global.read-more"/></a></p>
          </div>
          <div class="col-lg-3 col-sm-12">
            <div class="title-center">
              <h2 class="text-center"><@message "biosamples"/></h2>
            </div>
            <div>
              <div class="text-center"><a href="/page/samples"><img alt="Samples"
                                          src="/assets/images/icon_mica_samples_0.png"
                                          style="width: 250px; height: 216px;"></a>
              </div>
            </div>
            <p class="text-center">&nbsp;</p>
            <p class="text-center"><@message "biosamples-text"/></p>
            <p class="text-center"><a href="/page/samples"><@message "global.read-more"/></a></p>
          </div>
          <div class="col-lg-3 col-sm-12">
            <div class="title-center">
              <h2 class="text-center"><@message "research"/></h2>
            </div>
            <div>
              <div class="text-center"><a href="/data-access-process"><img alt="Access"
                                             src="/assets/images/icon_mica_access_0.png"
                                             style="width: 250px; height: 217px;"></a>
              </div>
            </div>
            <p class="text-center">&nbsp;</p>
            <p class="text-center"><@message "research-text"/></p>
            <p class="text-center"><a href="/data-access-process"><@message "global.read-more"/></a></p>
          </div>
        </div>

      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <#include "libs/footer.ftl">
</div>
<!-- ./wrapper -->

<#include "libs/scripts.ftl">
<#include "libs/index-scripts.ftl">

</body>
</html>
