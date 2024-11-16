class MlstrStudyService extends MlstrEntityService {

  static newInstance() {
    return new MlstrStudyService();
  }

  constructor() {
    super();
  }

  /**
   * Give a study ID, returns the networks this study belongs to.
   *
   * @param studyId
   * @param start
   * @param length
   * @param lang
   * @param onsuccess
   * @param onfailure
   */
  __getNetworks(studyId, start, length, lang, onsuccess, onfailure) {
    let url = `/ws/networks/_rql?query=network(limit(${start},${length}),and(exists(Mica_network.id),in(Mica_network.studyIds,(${studyId}))),sort(-numberOfStudies),fields((studyIds,acronym.*,name.*,description.*))),locale(${lang || 'en'})`;
    this.__getResource(url, onsuccess, onfailure);
  }

  __getDatasets(studyId, start, length, lang, sortKey, onsuccess, onfailure) {
    const sort = sortKey ? sortKey : 'studyTable.studyId,studyTable.populationWeight,studyTable.dataCollectionEventWeight,acronym';
    let url = `/ws/datasets/_rql?query=dataset(limit(${start},${length}),exists(Mica_dataset.id),sort(${sort}),fields((name.*,studyTables.*,harmonizationTables.*,studyTable.studyId,studyTable.populationId,studyTable.dataCollectionEventId,studyTable.project,studyTable.table,model.*))),locale(${lang}),study(in(Mica_study.id,(${studyId})))`;
    this.__getResource(url, onsuccess, onfailure);
  }

  __getHarmonizationStudy(studyId, lang, onsuccess, onfailure) {
    let url = `/ws/harmonization-study/${studyId}?participatingStudies=true`;
    this.__getResource(url, onsuccess, onfailure);
  }

  __getDceFromStudySummary(studyTable, lang) {
    let dceName = "";
    const dceId = studyTable.dceId.split(/:/).pop();
    if (studyTable.studySummary) {
      const population = (studyTable.studySummary.populationSummaries || []).filter(population => studyTable.populationId === population.id).pop();
      if (population) {
        dceName = `${LocalizedValues.forLang(population.name, lang)}`;
        let dce = (population.dataCollectionEventSummaries || []).filter(dce => dceId === dce.id).pop();
        if (dce) {
          dceName = `${dceName} -- ${LocalizedValues.forLang(dce.name, lang)}`;
        }
      }
    }

    return dceName;
  }

  createNetworksTable(studyId, lang) {
    const getNetworksCallback = (data, callback) => {
      $('#loading-networks-summary').removeClass('d-none');
      this.__getNetworks(studyId, data.start, data.length, lang, (response) => {
        $('#loading-networks-summary').addClass('d-none');
        if (response.networkResultDto && response.networkResultDto['networkResult']) {
          const total = response.networkResultDto.totalHits;
          const networks = response.networkResultDto['networkResult'].networks || [];
          if (networks.length > 0) {
            $(`#${studyId}-networks-card`).removeClass('d-none');
            let rows = [];
            networks.forEach(network => {
              let row = [];
              const url = MicaService.normalizeUrl(`/network/${network.id}`);
              const studies = network['countStats.networkCountStats'] ? network['countStats.networkCountStats'].studies : '';
              const searchUrl = MicaService.normalizeUrl(`/search#lists?type=studies&query=network(in(Mica_network.id,${network.id}))`);

              row.push(`<a href="${url}">${LocalizedValues.forLang(network.acronym, lang)}</a>`);
              row.push(`${LocalizedValues.forLang(network.name, lang)}`);
              row.push(`<a href="${searchUrl}">${studies}</a>`);
              rows.push(row);
            });
            callback({
              data: rows,
              recordsTotal: total,
              recordsFiltered: total
            });
          }
        }
      });
    }
    const tableOptions = {
      ordering: false,
      serverSide: true,
      ajax: getNetworksCallback
    };

    $(`#${studyId}-networks`).DataTable({ ...mlstrDataTablesDefaultOpts, ...tableOptions });
  }

  createDatasetsTable(studyId, lang, isHarmonization, sortKey) {

    const addCollectedDatasetColumns = (dataset, row, /*model*/) => {
      const datasetType = `${dataset.variableType.toLowerCase()}-dataset`;
      const dceName = this.__getDceFromStudySummary(dataset['obiba.mica.CollectedDatasetDto.type'].studyTable, lang);
      const dceId = dataset['obiba.mica.CollectedDatasetDto.type'].studyTable.populationId + '-' + dataset['obiba.mica.CollectedDatasetDto.type'].studyTable.dataCollectionEventId;
      row.push(Mica.tr[datasetType] || datasetType);
      row.push(`<a href="#" data-toggle="modal" data-target="#modal-${dceId}">${dceName}</a>`);
    }

    const countProtocolStudies = (studyTableData) => {

      if ('studyTables' in studyTableData) {
        const studies = new Set();
        studyTableData.studyTables.forEach(table => studies.add(table.studyId))
        return studies.size;
      }

      return 0;
    };

    const addHarmonizationProtocolColumns = (dataset, row, model) => {
      // let quantitative = model.qualitativeQuantitative ? Mica.tr['harmonization-protocol.qualitative-quantitative.enum.' + model.qualitativeQuantitative] : '-';
      // let prospective = model.qualitativeQuantitative ? Mica.tr['harmonization-protocol.prospective-retrospective.enum.' + model.prospectiveRetrospective] : '-';
      let participants = model.participants ? model.participants.toLocaleString() : '-';
      // row.push(quantitative)
      // row.push(prospective)
      if ('obiba.mica.HarmonizedDatasetDto.type' in dataset) {
        row.push((!('hide_var' in model) || false === model['hide_var']) ? countProtocolStudies(dataset['obiba.mica.HarmonizedDatasetDto.type']) : '-');
      }
      row.push(participants);
    }

    const addDatasetSpecificColumns = isHarmonization ? addHarmonizationProtocolColumns : addCollectedDatasetColumns;

    const getDatasetsCallback = (data, callback) => {
      $('#loading-datasets-summary').removeClass('d-none');
      this.__getDatasets(studyId, data.start, data.length, lang, sortKey, (response) => {
        $('#loading-datasets-summary').addClass('d-none');
        if (response.datasetResultDto && response.datasetResultDto['datasetResult']) {
          const total = response.datasetResultDto.totalHits;
          const datasets = response.datasetResultDto['datasetResult'].datasets || [];
          if (datasets.length > 0) {
            $(`#${studyId}-datasets-card`).removeClass('d-none');
            let rows = [];
            datasets.forEach(dataset => {
              const model = JSON.parse(dataset.content) || {};
              const datasetType = `${dataset.variableType.toLowerCase()}-dataset`;
              const studyClassName = 'collected-dataset' === datasetType ? 'individual-study' : 'harmonization-study';

              let row = [];
              const url = MicaService.normalizeUrl(`/dataset/${dataset.id}`);
              const studyQuery = this.__ensureStudyClassNameQuery(studyClassName);
              const searchUrl = MicaService.normalizeUrl(`/${this.__getSearchPageUrl(studyClassName)}#lists?type=variables&query=study(${studyQuery}),dataset(in(Mica_dataset.id,${dataset.id}))`);
              const variables = dataset['countStats.datasetCountStats'] ? dataset['countStats.datasetCountStats'].variables : '';

              row.push(`<a href="${url}">${LocalizedValues.forLang(dataset.name, lang)}</a>`);
              addDatasetSpecificColumns(dataset, row, model);
              row.push((!('hide_var' in model) || false === model['hide_var']) ? `<a href=${searchUrl}>${variables}</a>` : '-');
              rows.push(row);
            });
            callback({
              data: rows,
              recordsTotal: total,
              recordsFiltered: total
            });
          }
        }
      });
    }
    const tableOptions = {
      ordering: false,
      serverSide: true,
      searching: false,
      ajax: getDatasetsCallback
    };
    $(`#${studyId}-datasets`).DataTable({ ...mlstrDataTablesDefaultOpts, ...tableOptions });
  }

  createStudiesTables(studyId, lang, showVariables) {
    this.__getTaxonomy('study', (response) => {
      const taxonomyTitleFinder = new TaxonomyTitleFinder()
      taxonomyTitleFinder.initialize(response);

      this.__getHarmonizationStudy(studyId, lang, (response) => {
        if ('obiba.mica.HarmonizationStudyDto.type' in response) {
          const tables = response['obiba.mica.HarmonizationStudyDto.type'];
          const studyTables = tables.studyTables || [];
          const harmonizationTables = tables.harmonizationTables || [];
          this.__createIndividualStudiesTable(studyId, studyTables, lang, taxonomyTitleFinder, showVariables);
          this.__createHarmonizationStudiesTable(studyId, harmonizationTables, lang, showVariables);

        }
      });
    });
  }

  ensurePopulationDceSelection() {
    const hash = new URL(window.location).hash;
    const regex = /population\/([^\/]*)|data-collection-event\/(.*)$/g;

    const matches = [...StringMatcher.matchAll(hash, regex)];
    if (matches.length > 0) {
      const populationId = matches[0][1].split(/:/).pop();
      let dceId = '';
      if (matches.length > 1) {
        dceId = matches[1][2].split(/:/).pop();
      }

      console.log(`#population-${populationId}`, `#modal-${populationId}-${dceId}`)
      $([document.documentElement, document.body]).animate({
        scrollTop: $("#populations").offset().top
      }, 250
      );
      setTimeout(() => {
        $(`a[href="#population-${populationId}"]`).tab('show');
        if (dceId) {
          $(`#modal-${populationId}-${dceId}`).modal();
        }
      }, 250);

    }
  }
}

