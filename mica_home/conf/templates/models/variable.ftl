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

  <div id="categoricalSummary" style="display: none" class="mt-3 pt-3">
    <div class="row">
      <div class="col-xs-12 col-lg">
        <dl>
          <dt><@message "frequencies"/></dt>
          <dd>
            <div class="table-responsive">
              <table class="table table-striped">
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
          </dd>
        </dl>
      </div>
      <div class="col-xs-12 col-lg">
        <canvas id="frequencyChart"></canvas>
      </div>
    </div>
  </div>

  <div id="continuousSummary" style="display: none" class="mt-3 pt-3">
    <div class="row">
      <div class="col">
        <div class="table-responsive">
          <table class="table">
            <thead>
              <tr>
                <th><@message "min"/></th>
                <th><@message "max"/></th>
                <th><@message "mean"/></th>
                <th><@message "stdDev"/></th>
                <th><@message "sum"/></th>
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

