<!-- ChartJS -->
<script src="${adminLTEPath}/plugins/chart.js/Chart.min.js"></script>
<script src="${assetsPath}/js/mica-charts.js"></script>

<!-- Files -->
<script src="${assetsPath}/libs/node_modules/vue/dist/vue.js"></script>
<script src="${assetsPath}/js/mica-files.js"></script>

<!-- Repository -->
<script src="${assetsPath}/js/mica-repo.js"></script>

<script>
  const Mica = {...DefaultMica};

  // cart
  <#if cartEnabled>
  const onVariablesCartAdd = function(id) {
    VariablesSetService.addQueryToCart('dataset(in(Mica_dataset.id,' + id + ')),variable(limit(0,10000),fields(variableType))', function(cart, oldCart) {
      VariablesSetService.showCount('#cart-count', cart, '${.lang}');
      if (cart.count === oldCart.count) {
        MicaService.toastInfo("<@message "sets.cart.no-variable-added"/>");
      } else {
        MicaService.toastSuccess("<@message "variables-added-to-cart"/>".replace('{0}', (cart.count - oldCart.count).toLocaleString('${.lang}')));
      }
    });
  };
  </#if>

  const makeVariablesClassificationsChartSettingsMlstr = function(datasetId, chartData, chartDataset) {
    const names = chartData.vocabularies.map(v => v.name);
    const labels = chartData.vocabularies.map(v => v.label);

    const datasets = [];
    Object.keys(chartData.itemCounts).filter(k => k === chartDataset.key).forEach(k => {
      const dataset = {
        label: chartDataset.label,
        data: names.map(n => {
          return chartData.itemCounts[k][n] ? chartData.itemCounts[k][n] : 0;
        }),
        borderColor: chartDataset.borderColor,
        backgroundColor: chartDataset.backgroundColor
      };
      datasets.push(dataset);
    });

    return {
      type: 'horizontalBar',
      data: {
        labels: labels,
        datasets: datasets
      },
      options: {
        onClick: (event, chartElement) => {
          const index =  chartElement[0]._index;
          const vocabularyData = chartData.vocabularies[index];
          if (vocabularyData) {
            const searchUrl = "${contextPath}/search#lists?query=variable(and(exists("+vocabularyData.taxonomy+"."+vocabularyData.name+"),in(Mica_variable.datasetId,"+encodeURIComponent(datasetId)+")))&type=variables";
            window.location.assign(searchUrl);
          }
        },
        scales: {
          xAxes: [{
            scaleLabel: {
              display: true,
              labelString: "<@message "client.label.dataset.number-of-variables"/>",
            }
          }]
        },
        indexAxis: 'y',
        // Elements options apply to all of the options unless overridden in a dataset
        // In this case, we are setting the border of each horizontal bar to be 2px wide
        elements: {
          rectangle: {
            borderWidth: 2,
          }
        },
        responsive: true,
        legend: {
          display: false,
        },
        title: {
          display: false,
          text: chartData.title
        }
      }
    };
  };

  const renderVariablesClassifications = function(datasetId) {
    $('#loadingClassifications').hide();
    const chartsElem = $('#chartsContainer');
    chartsElem.children().remove();
    if (Mica.variablesCoverage) {
      Mica.variablesCoverage.forEach(chartData => {
        chartsElem.append('<h5 class="text-center">' + chartData.title + '</h5>');
        chartsElem.append('<p class="text-center">' + chartData.subtitle + '</p>');
        chartsElem.append('<canvas class="mb-4"></canvas>');
        const chartCanvas = $('#chartsContainer canvas:last-child').get(0).getContext('2d');
        new Chart(chartCanvas, makeVariablesClassificationsChartSettingsMlstr(datasetId, chartData, {
          key: '${dataset.id}',
          label: "<@message "variables"/>",
          borderColor: '${barChartBorderColor}',
          backgroundColor: '${barChartBackgroundColor}'
        }));
      });
      $('#classificationsContainer').show();
    } else {
      $('#noVariablesClassifications').show();
    }
  };

  $(function () {
    function prepareDatasetVariablesClassificationsData(chart) {
      const itemCounts = {};
      let vocabularies = [];
      chart.data.forEach(vocabularyData => {
        const title = vocabularyData.items[0].title;
        const vocabulary = {
          taxonomy: chart.taxonomy,
          name: vocabularyData.vocabulary,
          label: title
        };
        vocabularyData.items.filter(item => item.key !== '').forEach(item => {
          if (!itemCounts[item.key]) {
            itemCounts[item.key] = {};
          }
          if (!itemCounts._all) {
            itemCounts._all = {};
          }
          itemCounts[item.key][vocabularyData.vocabulary] = item.value;
          itemCounts._all[vocabularyData.vocabulary] =
            (itemCounts._all[vocabularyData.vocabulary] ? itemCounts._all[vocabularyData.vocabulary] : 0) + item.value;
        });
        vocabularies.push(vocabulary);
      });

      return {
        vocabularies: vocabularies,
        itemCounts: itemCounts,
        title: chart.title,
        subtitle: chart.subtitle
      };
    }

    QueryService.getCounts('datasets', {query: "dataset(in(Mica_dataset.id,${dataset.id}))"}, function (stats) {
      $('#network-hits').text(numberFormatter.format(stats.networkResultDto.totalHits));
      $('#study-hits').text(numberFormatter.format(stats.studyResultDto.totalHits));
      $('#variable-hits').text(numberFormatter.format(stats.variableResultDto.totalHits));
      if (stats.variableResultDto.totalHits>0) {
        $('#cart-add').show();
      }
    });

    <#if type == "Harmonized">
      let originalWeights = [];
      function getStudySummaries(dataset) {
        let columns = (dataset.studyTable || []).concat(dataset.harmonizationStudyTable || []);
        const percentage = 74 / (columns.length);
        originalWeights = columns.map(col => col.weight);
        columns.sort((a, b) => a.weight - b.weight);
        const sorted = columns.map(study => {
          let name = StringLocalizer.localize(study.studySummary.acronym);
          if (study.studySummary.published) {
            name = '<a href="${contextPath}' + '/study/' + study.studyId + '">'+name+'</a>';
          }

          if (study.name) {
            name = name + ' ' + StringLocalizer.localize(study.name);
          }

          return {title: name, width: percentage + '%'};
        });

        return [{title: "<@message "variable"/>", width: '25%'}].concat(sorted);
      }

      $('#harmonizedTable').show();
      const dataTableOpts = {
        "paging": true,
        "pageLength": 25,
        "lengthChange": true,
        "searching": false,
        "ordering": false,
        "info": false,
        "language": {
          "url": "${assetsPath}/i18n/mlstr-datatables.${.lang}.json"
        },
        "processing": true,
        "serverSide": true,
        "ajax": function(data, callback, settings) {
          DatasetService.getHarmonizedVariables('${dataset.id}', data.start, data.length, function(response) {
            $('#loadingSummary').hide();
            if (response.variableHarmonizations) {
              let rows = [];
              for (const i in response.variableHarmonizations) {
                const variableHarmonization = response.variableHarmonizations[i];
                let row = [];
                const name = variableHarmonization.dataschemaVariableRef.name;
                row.push('<a href="${contextPath}/variable/${dataset.id}:' + name + ':Dataschema">' + name + '</a>');

                variableHarmonization.harmonizedVariables
                  .forEach((harmonizedVariable, index) => harmonizedVariable.weight = originalWeights[index]);
                variableHarmonization.harmonizedVariables.sort((a, b) => a.weight - b.weight);
                variableHarmonization.harmonizedVariables.forEach((harmonizedVariable, index) => {
                    harmonizedVariable.weight = originalWeights[index];
                    let iconClass = MlstrVariableService.getHarmoStatusClass(harmonizedVariable.status);
                    if (!harmonizedVariable.status || harmonizedVariable.status.length === 0) {
                      row.push('<i class="' + iconClass + '"></i>');
                    } else {
                      const url = harmonizedVariable.harmonizedVariableRef ? '../variable/' + harmonizedVariable.harmonizedVariableRef.id : '#';
                      row.push('<a title="' + Mica.tr[harmonizedVariable.status] + '" href="' + url + '"><i class="' + iconClass + '"></i></a>');
                    }
                  });
                rows.push(row);
              }
              callback({
                data: rows,
                recordsTotal: response.total,
                recordsFiltered: response.total
              });
            }
          });
        },
        "fixedHeader": true,
        dom: "<'row'<'col-sm-5'i><'col-sm-7'f>><'row'<'table-responsive'tr>><'row'<'col-sm-3'l><'col-sm-9'p>>"
      };

      DatasetService.getHarmonizedVariables('${dataset.id}', 0, 1, function(response) {
        const columns = getStudySummaries(response);
        dataTableOpts.columns = columns;
        $("#harmonizedTable").DataTable(dataTableOpts);
      });


      /*
      $('#harmonizedTable').on( 'page.dt', function () {
        var info = table.page.info();
        console.dir(info);
      } );
      */
    </#if>

    <!-- Files -->
    const filesTr = {
      'item': "<@message "item"/>",
      'items': "<@message "items"/>",
      'download': "<@message "download"/>"
    };
    <#if showDatasetFiles>
      makeFilesVue('#files-app', {
        type: '${type?lower_case}-dataset',
        id: '${dataset.id}',
        basePath: '',
        path: '/',
        folder: {},
        tr: filesTr,
        locale: '${.lang}',
        contextPath: '${contextPath}'
      });
    </#if>
    <#if showStudyPopulationFiles>
      <#if study?? && population??>
        makeFilesVue('#study-${population.id}-files-app', {
          type: '<#if type == "Harmonized">harmonization<#else>individual</#if>-study',
          id: '${study.id}',
          basePath: '/population/${population.id}',
          path: '/',
          folder: {},
          tr: filesTr,
          locale: '${.lang}',
          contextPath: '${contextPath}'
        }, function(file) {
          return !(file.type === 'FOLDER' && file.name === 'data-collection-event');
        });
      </#if>
      <#if studyTables?? && studyTables?size != 0>
        <#list studyTables as table>
          makeFilesVue('#study-${table.study.id}-${table.population.id}-files-app', {
            type: 'individual-study',
            id: '${table.study.id}',
            basePath: '/population/${table.population.id}',
            path: '/',
            folder: {},
            tr: filesTr,
            locale: '${.lang}',
            contextPath: '${contextPath}'
          }, function(file) {
            return !(file.type === 'FOLDER' && file.name === 'data-collection-event');
          });
        </#list>
      </#if>
    </#if>
    <#if showStudyDCEFiles>
      <#if study?? && population?? && dce??>
        makeFilesVue('#study-${population.id}-${dce.id}-files-app', {
          type: 'individual-study',
          id: '${study.id}',
          basePath: '/population/${population.id}/data-collection-event/${dce.id}',
          path: '/',
          folder: {},
          tr: filesTr,
          locale: '${.lang}',
          contextPath: '${contextPath}'
        });
      </#if>
      <#if studyTables?? && studyTables?size != 0>
        <#list studyTables as table>
          makeFilesVue('#study-${table.study.id}-${table.population.id}-${table.dce.id}-files-app', {
            type: 'individual-study',
            id: '${table.study.id}',
            basePath: '/population/${table.population.id}/data-collection-event/${table.dce.id}',
            path: '/',
            folder: {},
            tr: filesTr,
            locale: '${.lang}',
            contextPath: '${contextPath}'
          });
        </#list>
      </#if>
    </#if>

    <#if datasetVariablesClassificationsTaxonomies?? && datasetVariablesClassificationsTaxonomies?size gt 0>
      const taxonomies = ['${datasetVariablesClassificationsTaxonomies?join("', '")}'];
      DatasetService.getVariablesCoverage('${dataset.id}', taxonomies, '${.lang}', function(data) {
        if (data && data.charts) {
          Mica.variablesCoverage = data.charts.map(chart => prepareDatasetVariablesClassificationsData(chart));
        }
        renderVariablesClassifications('${dataset.id}');
      }, function(response) {

      });
    </#if>
  });
</script>
