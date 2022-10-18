// Summary
const makeSummary = function(showHarmonizedVariableSummarySelector) {

  const initStudySelector = function(data) {
    let selectStudy = $('#select-study');
    selectStudy.parent().hide();
    if (data.aggregations && data.aggregations.length > 0) {
      selectStudy.parent().show();
      if (selectStudy.children().length === 0) {
        selectStudy.append(new Option(Mica.tr.all, -1, true, true));
        data.aggregations.forEach((agg, i) => {
          const studyTable = agg.studyTable;
          const populationSummary = studyTable.studySummary.populationSummaries.filter(pop => pop.id === studyTable.populationId).pop();
          const dceSummary = populationSummary.dataCollectionEventSummaries ? populationSummary.dataCollectionEventSummaries.filter(dce => dce.id === studyTable.dataCollectionEventId).pop() : undefined;
          let text = LocalizedValues.forLang(studyTable.studySummary.acronym, Mica.currentLanguage) + ' / '
            + LocalizedValues.forLang(populationSummary.name, Mica.currentLanguage)
            + (dceSummary ?  (' / ' + LocalizedValues.forLang(dceSummary.name, Mica.currentLanguage)) : '');
          const tableName = studyTable.name ? LocalizedValues.forLang(studyTable.name, Mica.currentLanguage) : undefined;
          const tableDescription = studyTable.description ? LocalizedValues.forLang(studyTable.description, Mica.currentLanguage) : undefined;
          if (tableName) {
            text = text + ' [' + tableName + (tableDescription ? ': ' + tableDescription : '') + ']';
          } else if (tableDescription) {
            text = text + ' [' + tableDescription + ']';
          }
          selectStudy.append(new Option(text, i, false, false));
        });
      }
      selectStudy.select2({
        theme: 'bootstrap4'
      }).on('select2:select', function (e) {
        let selId = e.params.data.id;
        //console.log(sel);
        if (selId === '-1') {
          renderSummary(Mica.data)
        } else {
          renderSummary(Mica.data.aggregations[Number.parseInt(selId)])
        }
      });
    }
  };

  const renderSummary = function(data) {
    renderFrequencies(data);
    renderStatistics(data);

    if (Mica.nature === 'CONTINUOUS') {
      $('#categoricalSummary').hide();
    }

    if (!data.frequencies && !data.statistics) {
      $('#noSummary').show();
    }
  };

  const customMakeVariableFrequenciesChartSettings = function(frequencies, backgroundColors, tr) {
    const labels = [];
    const dataset = {
      data: [],
      backgroundColor: backgroundColors,
    };
    frequencies.forEach(frequency => {
      if (frequency.count>0) {
        labels.push(tr[frequency.label] ? tr[frequency.label] : frequency.label);
        dataset.data.push(frequency.count);
      }
    });

    return [{
      type: "pie",
      sort: false,
      hole: 0,
      marker: {
        colors: dataset.backgroundColors
      },
      hoverinfo: "label+value",
      values: dataset.data,
      labels
    }];
  };

  const renderFrequencies = function(data) {
    const frequencyChartElem = $('#frequencyChart');
    if (data.frequencies) {

      const padStringWithZeros = (s) => !isNaN(s) ? '0'.repeat(10 - s.length) + s : s;

      if (Mica.nature === 'CATEGORICAL' && Mica.valueType !== 'text') {
        // frequencies chart
        const chartData = customMakeVariableFrequenciesChartSettings(data.frequencies, Mica.backgroundColors, {
          'NOT_NULL': Mica.tr['not-empty-values'],
          'N/A': Mica.tr['empty-values']
        });

        if (frequencyChartElem.length) {
          Plotly.newPlot("frequencyChart", chartData, null, {responsive: true, displaylogo: false, modeBarButtonsToRemove: ['select2d', 'lasso2d', 'pan', 'zoom', 'autoscale', 'zoomin', 'zoomout', 'resetscale']});
          frequencyChartElem.show();
        }
      }

      $('#frequencyTotal').html(numberFormatter.format(data.total));

      // frequencies table
      let frequencyRows = '';
      let missingRows = '';
      data.frequencies.forEach(frequency => {
        // % over not empty values
        let pctValues = data.n === 0 ? 0 : (frequency.count / data.n) * 100;
        pctValues = numberFormatter.format(pctValues.toFixed(2));

        let pctMissings = data.n === data.total ? 0 : (frequency.count / (data.total - data.n)) * 100;
        pctMissings = numberFormatter.format(pctMissings.toFixed(2));

        let pctTotal = data.total === 0 ? 0 : (frequency.count / data.total) * 100;
        pctTotal = numberFormatter.format(pctTotal.toFixed(2));

        let value = frequency.value;

        try {
          value = numberFormatter.format(frequency.value);
          if (isNaN(value)) {
            value = frequency.value;
          }
        } catch(e) {}

        let valueTxt = Mica.categories[frequency.value] ? Mica.categories[frequency.value] : '';
        if (valueTxt === '') {
          if (value === 'NOT_NULL') {
            value = Mica.tr['not-empty-values'];
            valueTxt = Mica.tr['not-empty-values-description'];
          } else if (value === 'N/A') {
            value = Mica.tr['empty-values'];
            valueTxt = Mica.tr['empty-values-description'];
          }
        }

        if (frequency.missing) {
          pctValues = '';

          missingRows = missingRows +
          `<tr>
            <td>
              ${value}
              <p class="text-muted mb-0">${valueTxt}</p>
            </td>
            <td>
              ${numberFormatter.format(frequency.count)}
              <p class="text-muted mb-0">${pctMissings}%</p>
              <p class="text-muted mb-0"><em>(${pctTotal}%)</em></p>
            </td>
          </tr>`;
        } else {
          pctMissings = '';

          frequencyRows = frequencyRows +
          `<tr>
            <td>
              ${value}
              <p class="text-muted">${valueTxt}</p>
            </td>
            <td>
              ${numberFormatter.format(frequency.count)}
              <p class="text-muted mb-0">${pctValues}%</p>
              <p class="text-muted mb-0"><em>(${pctTotal}%)</em></p>
            </td>
          </tr>`;
        }


      });
      frequencyRows = `<tr><th colspan="2" style="padding: 0.25rem 0.75rem;">${Mica.tr['valid-values']}</td></tr>` +
        (Mica.nature === 'CATEGORICAL' && Mica.valueType !== 'text' ? frequencyRows : '') +
        `<tr>
          <td><em>${Mica.tr['subtotal']}</em></td>
          <td>
            ${numberFormatter.format(data.n)}
            <p class="text-muted mb-0">${numberFormatter.format((100 * data.n / data.total).toFixed(2))}%</p>
          </td>
        </tr>`;
      $('#validValues').html(frequencyRows);

      if (data.n !== data.total) {
        missingRows = `<tr><th colspan="2" style="padding: 0.25rem 0.75rem;">${Mica.tr['other-values']}</td></tr>` +
          (Mica.nature === 'CATEGORICAL' ? missingRows : '') +
          `<tr>
            <td><em>${Mica.tr['subtotal']}</em></td>
            <td>
              ${numberFormatter.format(data.total - data.n)}
              <p class="text-muted mb-0">${numberFormatter.format((100 * (data.total - data.n) / data.total).toFixed(2))}%</p>
            </td>
          </tr>`;

        $('#otherValues').html(missingRows);
      }

      $('#categoricalSummary').show();
    } else {
      frequencyChartElem.hide();
      $('#categoricalSummary').hide();
    }
  };

  const renderStatistics = function(data) {
    if (data.statistics) {
      const summary = data.statistics;

      $('#continuousSummary tbody').html(`
        <tr>
          <td>${summary.n === 0 ? '-' : numberFormatter.format(summary.min.toFixed(2))}</td>
          <td>${summary.n === 0 ? '-' : numberFormatter.format(summary.max.toFixed(2))}</td>
          <td>${summary.n === 0 ? '-' : numberFormatter.format(summary.mean.toFixed(2))}</td>
          <td>${summary.n === 0 ? '-' : numberFormatter.format(summary.stdDeviation.toFixed(2))}</td>
          <td>${data.n === 0 ? '-' : numberFormatter.format(data.n)}<p class="text-muted">(${numberFormatter.format((100 * data.n / data.total).toFixed(2))}%)</p></td>
          <td>${data.total === 0 ? '-' : numberFormatter.format(data.total)}</td>
        </tr>
      `);

      $('#continuousSummary').show();
      $('#frequencyChart').hide(); // hide if continuous
    } else {
      $('#continuousSummary').hide();
    }
  };

  VariableService.getAggregation(Mica.variableId, function (data) {
    Mica.data = data;
    if ('frequencies' in data) {
      data.frequencies.forEach(frequency =>
        frequency.label = Mica.categories[frequency.value] ? `${Mica.categories[frequency.value]} (${frequency.value})` : frequency.value
      )
    }

    $('#loadingSummary').hide();

    if (showHarmonizedVariableSummarySelector && (data.frequencies || data.statistics)) {
      // study tables selector
      initStudySelector(data);
    }
    renderSummary(data);
  }, function (data) {
    $('#loadingSummary').hide();
    $('#noSummary').show();
  });

};

// Harmonizations table
const makeHarmonizedVariablesTable = function() {
  VariableService.getHarmonizations(Mica.variableId, function(data) {
    $('#loadingHarmonizedVariables').hide();
    const harmonizedVariablesTableBody = $('#harmonizedVariables > tbody');
    if (data.datasetVariableSummaries) {
      for (const harmonizedVariable of data.datasetVariableSummaries) {
        const status = localizedString(VariableService.getHarmoStatus(harmonizedVariable));
        const statusDetail = VariableService.getHarmoStatusDetail(harmonizedVariable);
        const comment = VariableService.getHarmoComment(harmonizedVariable);
        const baseStudyTable = harmonizedVariable.studyTable ? harmonizedVariable.studyTable : harmonizedVariable.harmonizationStudyTable;
        const population = StudyService.findPopulation(baseStudyTable.studySummary, baseStudyTable.populationId);
        const dce = population ? StudyService.findPopulationDCE(population, baseStudyTable.dataCollectionEventId) : undefined;
        const studyAnchor = (summary) => summary.published
          ? '<a href="' + Mica.contextPath + '/study/' + baseStudyTable.studyId + '">' + localizedString(baseStudyTable.studySummary.acronym) + '</a></td>'
          : localizedString(baseStudyTable.studySummary.acronym);

        let dceName = population ? localizedString(population.name) : "";

        if (dce) {
          dceName = dceName + ' -- ' + localizedString(dce.name);
        }

        let tableName = localizedString(baseStudyTable.name);

        harmonizedVariablesTableBody.append('<tr>' +
          '<td title=""><a href="' + Mica.contextPath + '/variable/' + harmonizedVariable.resolver.id + '">' + harmonizedVariable.resolver.name + '</a> ' +
          '</td>' +
          '<td>' + localizedString(baseStudyTable.studySummary.acronym) +
          (tableName ? (' (' + localizedString(baseStudyTable.name) + ') ') : '') +
          '<div class="text-muted">' + localizedString(baseStudyTable.description) + '</div>' +
          '</td>' +
          '<td>' + studyAnchor(baseStudyTable.studySummary) + '</td>' +
          '<td><i class=" ' + VariableService.getHarmoStatusClass(status) + '"></i></td>' +
          '<td>' + localizedString(comment) + '</td>' +
          '</tr>')
      }
      $('#harmonizedVariables').show();
    } else {
      $('#noHarmonizedVariables').show();
    }
  }, function (data) {
    $('#loadingHarmonizedVariables').hide();
    $('#noHarmonizedVariables').show();
  });
};
