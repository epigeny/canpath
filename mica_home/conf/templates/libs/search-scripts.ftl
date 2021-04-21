<!-- Repository -->
<script src="${assetsPath}/js/mica-repo.js"></script>

<!-- MicaConfig in JSON Format -->
<script>
  const Mica = {...DefaultMica};
  Mica.config = ${configJson!"{}"};
  Mica.defaultLocale = "${defaultLang}";

  Mica.trArgs = (msgKey, msgArgs) => {
    let template = Mica.tr[msgKey] || msgKey;
    (msgArgs || []).forEach((arg, index) => template = template.replace('{'+index+'}', arg));
    return template;
  };

  Mica.maxNumberOfSets = ${maxNumberOfSets};

  Mica.querySettings = {
    variable: {
      fields: ['${searchVariableFields?join("', '")}'],
      sortFields: ['${searchVariableSortFields?join("', '")}']
    },
    dataset: {
      fields: ['${searchDatasetFields?join("', '")}'],
      sortFields: ['${searchDatasetSortFields?join("', '")}']
    },
    study: {
      fields: ['${searchStudyFields?join("', '")}'],
      sortFields: ['${searchStudySortFields?join("', '")}']
    },
    network: {
      fields: ['${searchNetworkFields?join("', '")}'],
      sortFields: ['${searchNetworkSortFields?join("', '")}']
    }
  }

  Mica.icons = {
    variable: '${variableIcon}',
    dataset: '${datasetIcon}',
    study: '${studyIcon}',
    network: '${networkIcon}'
  };

  Mica.charts = {
    backgroundColor: '${barChartBackgroundColor}',
    borderColor: '${barChartBorderColor}',
    backgroundColors: ['${colors?join("', '")}'],
    studyDesignColors: ['${studyDesignColors?join("', '")}'],
    chartIds: ['${searchCharts?join("', '")}']
  };

  Mica.display = {
    variableColumns: ['${searchVariableColumns?join("', '")}'],
    datasetColumns: ['${searchDatasetColumns?join("', '")}'],
    studyColumns: ['${searchStudyColumns?join("', '")}'],
    networkColumns: ['${searchNetworkColumns?join("', '")}'],
    searchCriteriaMenus: ['${searchCriteriaMenus?join("', '")}']
  };

  fetch(contextPath + '/assets/topojson/${mapName}.json').then(r => r.json())
          .then(data => Mica.map = {
            name: '${mapName}',
            topo: data
          });
</script>

<!-- ChartJS -->
<script src="${adminLTEPath}/plugins/chart.js/Chart.min.js"></script>
<script src="${assetsPath}/libs/node_modules/chartjs-chart-geo/build/Chart.Geo.min.js"></script>

<!-- Mica Search and dependencies -->
<script src="${assetsPath}/libs/node_modules/vue/dist/vue.js"></script>
<script src="${assetsPath}/libs/node_modules/rql/dist/rql.js"></script>
<script src="${assetsPath}/libs/node_modules/vue-mica-search/dist/VueMicaSearch.umd.js"></script>
<script src="${assetsPath}/js/mica-tables.js"></script>
<script src="${assetsPath}/js/mlstr-query.js"></script>
<script src="${assetsPath}/js/mlstr-search.js"></script>
