<!-- Default model macros -->
<#include "../libs/variable.ftl">

<!-- Custom model macros, to redefine some default model macros -->

<#macro variableSummary variable>
  <div id="loadingSummary" class="spinner-border spinner-border-sm" role="status"></div>

  <#if showHarmonizedVariableSummarySelector>
    <div style="display: none;" class="mb-4">
      <select id="select-study" class="form-control select2 float-right" style="width: 100%;"></select>
    </div>
  </#if>

  <div>
    <div class="row">
      <div id="categoricalSummary" style="display: none" class="col-xs-12 col-lg-6">
        <div class="table-responsive" style="max-height: 48em;">
          <table class="table table-striped border">
            <thead>
              <tr>
                <th><@message "value"/></th>
                <th><@message "frequency"/></th>
              </tr>
            </thead>
            <tbody id="validValues"></tbody>
            <tbody id="otherValues"></tbody>
            <tbody>
              <tr>
                <th><@message "total"/></th>
                <td id="frequencyTotal"></td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
      <div class="col-xs-12 col-lg-6">
        <canvas id="frequencyChart"></canvas>

        <div id="continuousSummary" class="table-responsive">
          <span><@message "continuous-summary-title"/></span>
          <table class="table border">
            <thead>
            <tr>
              <th><@message "min"/></th>
              <th><@message "max"/></th>
              <th><@message "mean"/></th>
              <th><@message "stdDev"/></th>
              <th><@message "n-with-values"/></th>
              <th><@message "total"/></th>
            </tr>
            </thead>
            <tbody></tbody>
          </table>
        </div>
      </div>
    </div>
  </div>

  <div id="noSummary" style="display: none">
    <span class="text-muted"><@message "no-variable-summary"/></span>
  </div>
</#macro>

