<!-- File browser, vuejs template -->
<#macro filesBrowser>
  <div class="files-browser" v-cloak>
    <div v-if="folder.children">
      <div>
        <table class="table table-sm table-striped my-0">
          <tbody>
          <tr is="file-row-simple" v-for="file in folder.children" v-bind:key="file.name"
              v-bind:file="file" v-bind:tr="tr" v-bind:locale="locale"
              v-on:select-folder="onSelectFolder"></tr>
          </tbody>
        </table>
      </div>
    </div>
    <div v-else>
      <span class="text-muted"><@message "no-documents"/></span>
    </div>
  </div>
</#macro>

<#macro studyFilesBrowser study>
  <div  id="study-files-app-container" style="display: none;" class="card card-info card-outline">
    <div class="card-header">
      <h3 class="card-title"><@message "documents"/></h3>
    </div>
    <div class="card-body">
      <div id="study-files-app">
          <@filesBrowser/>
      </div>
    </div>
  </div>
</#macro>


<#macro datasetFilesBrowser dataset>
  <div id="files-app-container" style="display: none;" class="card card-info card-outline">
    <div class="card-header">
      <h3 class="card-title"><@message "documents"/></h3>
    </div>
    <div class="card-body">

      <div id="files-app">
          <@filesBrowser/>
      </div>

    </div>
  </div>
</#macro>

<#macro populationFilesBrowser id>
  <div id="study-${id}-files-app-container" class="card" style="display: none;">
    <div class="card-header">
      <h3 class="card-title">
          <@message "documents"/>
      </h3>
    </div>
    <!-- /.card-header -->
    <div class="card-body">
      <div id="study-${id}-files-app" class="mt-2">
          <@filesBrowser/>
      </div>
    </div>
  </div>
</#macro>

<#macro dceFilesBrowser id>
  <dl id="study-${id}-files-app-container" style="display: none;" class="row">
    <dt class="col-sm-12">
        <@message "documents"/>
    </dt>
    <dd class="col-sm-12">
      <div id="study-${id}-files-app" class="mt-2">
          <@filesBrowser/>
      </div>
    </dd>
  </dl>
</#macro>

