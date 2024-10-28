<!-- ChartJS -->
<script src="${adminLTEPath}/plugins/chart.js/Chart.min.js"></script>
<script src="${assetsPath}/js/mica-charts.js"></script>
<script src="${assetsPath}/libs/node_modules/plotly.js-dist-min/plotly.min.js"></script>

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

  const renderVariablesClassifications = function() {
    $('#loadingClassifications').hide();
    const chartsElem = $('#chartsContainer');
    chartsElem.children().remove();
    if (Mica.variablesCoverage) {
      Mica.variablesCoverage.forEach(chartData => {
        chartsElem.append('<h5 class="text-center">' + "<@message 'variables-classifications-chart-title'/>" + '</h5>');
        // chartsElem.append('<p class="text-center">' + chartData.subtitle + '</p>');
        chartsElem.append('<div id="bar-graph-' + chartData.taxonomy + '" class="mb-4"></div>');

        const chartConfig = makeVariablesClassificationsChartSettings(chartData, {
          key: '${dataset.id}',
          label: "<@message "variables"/>",
          borderColor: '${barChartBorderColor}',
          backgroundColor: '${barChartBackgroundColor}',
          useColorsArray: ${useColorsArrayForClassificationsChart?c}
        });

        chartConfig.layout.modebar = {remove: ['select2d', 'lasso2d', 'pan', 'zoom', 'autoscale', 'zoomin', 'zoomout', 'resetscale']};
        chartConfig.layout.margin = {
          t: 0,
          b: 50
        };
        chartConfig.layout.xaxis = {title: "<@message "client.label.dataset.number-of-variables"/>"};
        chartConfig.layout.font = {size: 12, family: "Gothic A1"};

        Plotly.newPlot("bar-graph-" + chartData.taxonomy, chartConfig.data, chartConfig.layout, {responsive: true, displaylogo: false});
      });
      $('#classificationsContainer').show();

      Mica.variablesCoverage.forEach(chartData => {
        let contentLength = Math.max(Mica.variablesCoverage.filter(c => c.taxonomy === chartData.taxonomy)[0].vocabularies.length, 7);
        let contentWidth = $('#classificationsContainer #bar-graph-' + chartData.taxonomy).width();

        Plotly.relayout("bar-graph-" + chartData.taxonomy, {width: contentWidth, height: (2*1.42857)*12*contentLength});

        document.getElementById('bar-graph-' + chartData.taxonomy).on('plotly_click', function (data) {
          let point = data.points[0];
          let foundVocabulary =  chartData.vocabularies.find(v => v.label === point.label);
          const searchUrl = "${contextPath}/search#lists?query=variable(and(exists("+chartData.taxonomy+"."+foundVocabulary.name+"),in(Mica_variable.datasetId,"+encodeURIComponent("${dataset.id}")+")))&type=variables";
          window.location.assign(searchUrl);
        });
      });
    } else {
      $('#noVariablesClassifications').show();
    }
  };

  const excludeStatusList = ['na', 'undetermined'];

  $(function () {
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
      function getStudySummaries(dataset, percentageCompleteMap) {
        let columns = (dataset.studyTable || []).concat(dataset.harmonizationStudyTable || []);
        const percentage = 74 / (columns.length);
        originalWeights = columns.map(col => col.weight);
        columns.sort((a, b) => a.weight - b.weight);
        let sorted = [];
        columns.forEach(study => {
          const emptyPercentageCompleMap = {complete: 0, partial: 0, impossible: 0};
          const studyTableName = StringLocalizer.localize(study.name) || StringLocalizer.localize(study.studySummary.acronym);
          const dceId = study.dceId || study.studyId +':.:.';
          const tableUid = study.tableUid;
          const dceStats = tableUid ? percentageCompleteMap[tableUid] || emptyPercentageCompleMap : emptyPercentageCompleMap;
          const percComplete = dceStats.percentage || 0;

          const explaination =
            '<span class=\'row\'>' +
            '<span class=\'col-6 popover-row\'><i class=\'fas fa-check fa-fw text-success\'></i><span class=\'pl-2\'>' + dceStats.complete + '</span></span>' +
            '<span class=\'col-6 popover-row\'><i class=\'fas fa-times fa-fw text-danger\'></i><span class=\'pl-2\'>' + dceStats.impossible + '</span></span>' +
            '</span>';

          let name = MlstrStudyTablePopoverFactory.create(study, studyTableName);

          name += '<p class="py-0"><button type="button" class="btn btn-xs btn-link text-muted" data-toggle="popover" data-trigger="hover" data-placement="bottom" title="<@message "status-distribution"/>" data-content="' + explaination + '">' + percComplete + '%</button></p>';

          sorted.push({title: name, width: percentage + '%'});
        });

        return [{title: "<@message "variable"/>", width: '25%'}, {title: "<@message "percentage-complete-column-title"/>", width: '10%'}].concat(sorted);
      }

      $('#harmonizedTable').show();
      const dataTableOpts = {
        drawCallback: function() {
          const pagination = $(this).closest('.dataTables_wrapper').find('.pagination-bar');
          if (pagination) {
            if (this.api().page.info().pages > 1) {
              pagination.removeClass('d-none');
            } else {
              pagination.addClass('d-none');
            }
          }
        },
        "paging": true,
        "pageLength": 25,
        "lengthChange": true,
        "lengthMenu": [25, 50, 75, 100],
        "searching": true,
        "ordering": false,
        "info": false,
        "language": {
          "url": "${assetsPath}/i18n/mlstr-datatables.${.lang}.json"
        },
        "processing": true,
        "serverSide": true,
        "ajax": function(data, callback, settings) {
          const search = 'search' in data && data.search.value ? data.search.value : null;
          DatasetService.getHarmonizedVariables('${dataset.id}', search, data.start, data.length, function(response) {
            $('#loadingSummary').hide();
            if (response.variableHarmonizations) {
              let rows = [];
              for (const i in response.variableHarmonizations) {
                const variableHarmonization = response.variableHarmonizations[i];
                let row = [];
                const name = variableHarmonization.dataschemaVariableRef.name;
                row.push('<a href="${contextPath}/variable/${dataset.id}:' + name + ':Dataschema">' + name + '</a>');

                var statusDetails = {complete: [], partial: [], impossible: []};

                var completeCount = variableHarmonization.harmonizedVariables.reduce((acc, curr) => {
                  if (curr.status === 'complete') {
                    acc = acc + 1;
                    statusDetails.complete.push(curr.statusDetail);
                  }
                  return acc;
                }, 0);

                var partialCount = variableHarmonization.harmonizedVariables.reduce((acc, curr) => {
                  if (curr.status === 'partial') {
                    acc = acc + 1;
                    statusDetails.partial.push(curr.statusDetail);
                  }
                  return acc;
                }, 0);

                var impossibleCount = variableHarmonization.harmonizedVariables.reduce((acc, curr) => {
                  if (curr.status === 'impossible') {
                    acc = acc + 1;
                    statusDetails.impossible.push(curr.statusDetail);
                  }
                  return acc;
                }, 0);

                var denominator = variableHarmonization.harmonizedVariables.reduce((acc, curr) => {
                  acc = acc + (curr.status && curr.status.length > 0 && !excludeStatusList.includes(curr.status) ? 1 : 0);
                  return acc;
                }, 0);

                const explaination = MlstrHarmonizationTablePopoverFactory.create(completeCount, partialCount, impossibleCount, statusDetails);

                row.push('<button type="button" class="btn btn-xs btn-link text-muted" data-toggle="popover" data-container="#harmo-status-popover" data-trigger="hover" title="<@message "status-distribution"/>" data-content="' + explaination + '">' + Math.round(completeCount * 100 / Math.max(1, denominator)) + '%</button>');

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

              $('#harmonizedTable tr [data-type="description"]').popover({html: true, delay: { show: 250, hide: 1000 }});
              $('#harmonizedTable tr [data-toggle="popover"]').popover({html: true});
            } else {
              callback({
                data: [],
                recordsTotal: 0,
                recordsFiltered: 0
              });
            }
          });
        },
        "fixedHeader": true,
        dom: "<'row'<'col-sm-5'i><'col-sm-7'f>><'row'<'table-responsive'tr>><'row'<'col-sm-3'l><'col-sm-9'p>>"
      };

      function processAggregations(aggregations) {
        const completeStatusList = ['complete'];

        let result = {};
        Object.keys(aggregations).forEach(key => {
          let total = Object.keys(aggregations[key]).reduce((acc, val) => acc + aggregations[key][val], 0);
          let complete = aggregations[key]["complete"] || 0;

          result[key] = {
            percentage: Math.round(complete / (total || 1) * 100),
            complete: complete,
            partial: aggregations[key]["partial"] || 0,
            impossible: aggregations[key]["impossible"] || 0
          }
        });

        return result;
      }

      async function getHarmomizationVariables() {
        let percentageCompleteMap = null;

        try {
          percentageCompleteMap = await axios.get(MicaService.normalizeUrl("/ws/harmonized-dataset/${dataset.id}/tables/harmonizations")).then(res => res.data);
        } catch(error) {
          console.error(error);
          percentageCompleteMap = {};
        }

        DatasetService.getHarmonizedVariables('${dataset.id}', null, 0, 1, function(response) {
          const columns = getStudySummaries(response, processAggregations(percentageCompleteMap || {}));
          dataTableOpts.columns = columns;
          $("#harmonizedTable").DataTable(dataTableOpts);

          setTimeout(() => {
            let percentColumn = document.querySelector('#harmonizedTable thead th:nth-child(2)');
            if (percentColumn) {
              percentColumn.title = "<@message "percentage-complete-column-info"/>";
              percentColumn.classList.add('text-muted', 'font-weight-normal');
            }
          }, 500);
        });
      }

      getHarmomizationVariables();
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
          <#if table.study?? && table.population??>
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
          </#if>
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
          <#if table.study?? && table.population?? && table.dce??>
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
          </#if>
        </#list>
      </#if>
    </#if>

    <#if datasetVariablesClassificationsTaxonomies?? && datasetVariablesClassificationsTaxonomies?size gt 0>
      function vocabulariesColorsMapFunc(variableTaxonomies, colors) {
        let colorsMap = {};

        if (Array.isArray(variableTaxonomies) && Array.isArray(colors)) {
          let filteredVariableTaxonomies = variableTaxonomies.filter(taxo => taxo.name !== 'Mica_variable');
          filteredVariableTaxonomies.forEach(taxo => {
            let index = 0;

            colorsMap[taxo.name] = {};

            taxo.vocabularies.forEach(voc => {
              colorsMap[taxo.name][voc.name] = colors[index % colors.length];
              index = index + 1;
            });
          });
        }

        return colorsMap;
      }

      const taxonomies = ['${datasetVariablesClassificationsTaxonomies?join("', '")}'];

      axios.get(MicaService.normalizeUrl('/ws/taxonomies/_filter?target=variable')).then(function (taxonomiesRes) {

        let colorsMap = vocabulariesColorsMapFunc(taxonomiesRes.data, ['${colors?join("', '")}']);

        DatasetService.getVariablesCoverage('${dataset.id}', taxonomies, '${.lang}', function(data) {
          if (data && data.charts) {
            Mica.variablesCoverage = data.charts.map(chart => prepareVariablesClassificationsData(chart, colorsMap[taxonomies[0]]));
            Mica.variablesCoverage.forEach(i => i.taxonomy = taxonomies[0]);
          }
          renderVariablesClassifications();
        }, function(response) {

        });
      });

    </#if>
  });
</script>
