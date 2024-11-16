class MlstrDatasetService extends MlstrEntityService {

  static newInstance() {
    return new MlstrDatasetService();
  }

  constructor() {
    super();
  }

  __searchDataset(datasetId, lang, onsuccess, onfailure) {
    let url = `/ws/datasets/_rql?query=dataset(limit(0,1),in(Mica_dataset.id,${datasetId}),fields(acronym.*,name.*,description.*,variableType,studyTable.studyId,studyTable.project,studyTable.table,studyTable.populationId,studyTable.dataCollectionEventId,harmonizationTable.studyId,harmonizationTable.project,harmonizationTable.table,harmonizationTable.populationId)),locale(${lang})`;
    this.__getResource(url, onsuccess, onfailure);
  }

  updateVariablesCount(datasetId, lang, elementId) {
    this.__searchDataset(datasetId, lang, (response) => {
      if (response.datasetResultDto && 'datasetResult' in response.datasetResultDto) {
        const dataset = response.datasetResultDto['datasetResult'].datasets.pop();
        const counts = dataset ? dataset['countStats'].variables : 0;
        const element = document.querySelector(`#${elementId}`);
        if (element) {
          const searchUrl = `/search#lists?type=variables&query=dataset(in(Mica_dataset.id,${datasetId}))`;
          if (counts > 0) {
            element.insertAdjacentHTML('beforeend',`<a href="${searchUrl}">${counts.toLocaleString()}</a>`);
          } else {
            element.textContent = `${counts}`;
          }
        }
      }
    });
  }

  __getDataset(datasetId, lang, onsuccess, onfailure) {
    let url = `/ws/dataset/${datasetId}`;
    this.__getResource(url, onsuccess, onfailure);
  }

  createStudiesTables(datasetId, lang, showVariables) {
    this.__getTaxonomy('study', (response) => {
      const taxonomyTitleFinder = new TaxonomyTitleFinder()
      taxonomyTitleFinder.initialize(response);

      this.__getDataset(datasetId, lang, (response) => {
        if ('obiba.mica.HarmonizedDatasetDto.type' in response) {
          const tables = response['obiba.mica.HarmonizedDatasetDto.type'];
          const studyTables = tables.studyTables || [];
          const harmonizationTables = tables.harmonizationTables || [];
          this.__createIndividualStudiesTable(datasetId, studyTables, lang, taxonomyTitleFinder, showVariables);
          this.__createHarmonizationStudiesTable(datasetId, harmonizationTables, lang, showVariables);
        }
      });
    });
  }
}
