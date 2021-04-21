class MlstrEntityService {
  constructor() {
  }

  __getResources(urls, onsuccess, onfailure) {
    const requests = urls.map(url => axios.get(MicaService.normalizeUrl(url)));

    axios.all(requests)
      .then(axios.spread((...responses) => {
        if (onsuccess) {
          onsuccess(responses.map(response => response.data));
        }
      }))
      .catch(response => {
        if (onfailure) {
          onfailure(response);
          console.error(`Failed to retrieve ${urls.join(', ')} - ${response}`);
        }
      });
  }

  __getResource(url, onsuccess, onfailure) {
    axios.get(MicaService.normalizeUrl(url))
      .then(response => {
        if (onsuccess) {
          onsuccess(response.data);
        }
      })
      .catch(response => {
        if (onfailure) {
          onfailure(response);
          console.error(`Failed to retrieve ${url} - ${response}`);
        }
      });
  }

  __getTaxonomy(target, onsuccess, onfailure) {
    let url = `/ws/taxonomies/_filter?target=${target}`;
    this.__getResource(url, onsuccess, onfailure);
  }

  __ensureDesign(design, taxonomyTitleFinder) {
    return design && taxonomyTitleFinder ? taxonomyTitleFinder.title('Mica_study', 'methods-design', design) : '';
  }

  __ensureTargetNumber(targetNumber) {
    return targetNumber && targetNumber.number
      ? targetNumber.number.toLocaleString()
      : '-';
  }

  __ensureCountries(countries, taxonomyTitleFinder) {
    return countries
      ? countries.map(country => taxonomyTitleFinder.title('Mica_study', 'populations-selectionCriteria-countriesIso', country)).join(', ')
      : '';
  }

  __sortStudiesByAcronymComparator(a, b) {
    const lang = document.querySelector('html').getAttribute("lang") || "en";
    const aAcronym = LocalizedValues.forLang(a.studySummary.acronym, lang);
    const bAcronym = LocalizedValues.forLang(b.studySummary.acronym, lang);
    return aAcronym.localeCompare(bAcronym);

  }

  __ensureDistinctStudies(studies) {
    return Object.values(
      (studies || []).reduce((acc, item) => {
        acc[item.studyId || item.studySummary.id] = item;
        return acc;
      }, {})
    )
  }

  __createIndividualStudiesTable(id, studies, lang, taxonomyTitleFinder, showVariables) {
    if (studies.length > 0) {
      const studyList = this.__ensureDistinctStudies(studies);
      studyList.sort(this.__sortStudiesByAcronymComparator);

      const createVariablesUrl = (id, studyId, count) => count && count > 0
        ? `<a href="/search#lists?type=variables&query=study(in(Mica_study.id,(${studyId})))">${count.toLocaleString()}</a>`
        : '-';

      $(`#${id}-individual-studies-card`).removeClass('d-none');
      $('#loading-individual-studies-summary').hide();
      let rows = [];
      studyList.forEach(study => {
        const summary = study.studySummary;
        const acronym = LocalizedValues.forLang(summary.acronym, lang);
        let row = [];
        row.push(study.studySummary.published ? `<a href=/study/${summary.id}>${acronym}</a>` : acronym);
        row.push(LocalizedValues.forLang(summary.name, lang));
        row.push(this.__ensureDesign(study.studySummary.published ? summary.design : null, taxonomyTitleFinder));
        row.push(this.__ensureTargetNumber(study.studySummary.published ? summary.targetNumber : null));
        row.push(this.__ensureCountries(study.studySummary.published ? summary.countries : null, taxonomyTitleFinder));
        if (showVariables) {
          row.push(createVariablesUrl(id, summary.id, summary.variables));
        }
        rows.push(row);
      })

      const tableOptions = {
        ordering: false,
        columnDefs: [],
        data: rows
      };
      $(`#${id}-individual-studies`).DataTable({...mlstrDataTablesDefaultOpts, ...tableOptions});
    }
  }

  __createHarmonizationStudiesTable(id, studies, lang, showVariables) {
    if (studies.length > 0) {
      const studyList = this.__ensureDistinctStudies(studies);
      studyList.sort(this.__sortStudiesByAcronymComparator);

      const createVariablesUrl = (id, studyId, count) => count === 0
        ? '-'
        : `<a href="/search#lists?type=variables&query=study(in(Mica_study.id,${studyId}))">${count.toLocaleString()}</a>`

      $(`#${id}-harmonization-studies-card`).removeClass('d-none');
      $('#loading-harmonization-studies-summary').hide();
      let rows = [];
      studyList.forEach(study => {
        const summary = study.studySummary;
        const acronym = LocalizedValues.forLang(summary.acronym, lang);
        let row = [];
        row.push(study.studySummary.published ? `<a href=/study/${summary.id}>${acronym}</a>` : acronym);
        row.push(LocalizedValues.forLang(summary.name, lang));
        if (showVariables) {
          row.push(createVariablesUrl(id, summary.id, summary.variables));
        }
        rows.push(row);
      })

      const tableOptions = {
        ordering: false,
        columnDefs: [],
        data: rows
      };
      $(`#${id}-harmonization-studies`).DataTable({...mlstrDataTablesDefaultOpts, ...tableOptions});
    }
  }
}

class StringLocalizer {
  static __localizeInternal(entries, locale) {
    const result = (Array.isArray(entries) ? entries : [entries]).filter((entry) => entry && (locale === entry.lang || locale === entry.locale)).pop();

    if (result) {
      let value = result.value ? result.value : result.text;
      return value ? value : null;
    }
    return null;
  }

  static localize(entries) {
    if (entries) {
      const result = StringLocalizer.__localizeInternal(entries, DefaultMica.locale)
        || StringLocalizer.__localizeInternal(entries, "en")
        || StringLocalizer.__localizeInternal(entries, 'und');

      return result ? result : '';
    } else {
      return '';
    }
  }
}

class TaxonomyTitleFinder {
  constructor() {
    this.taxonomies = {};
  }

  initialize(taxonomies) {
    this.taxonomies = taxonomies.reduce((acc, taxonomy) => {
      acc[taxonomy.name] = taxonomy;
      return acc;
    }, {});
  }

  title(taxonomyName, vocabularyName, termName) {
    if (taxonomyName) {
      const taxonomy = this.taxonomies[taxonomyName];
      if (taxonomy) {
        if (!vocabularyName && !termName) return StringLocalizer.localize(taxonomy.title);
        else if (vocabularyName) {
          let foundVocabulary = (taxonomy.vocabularies || []).filter(vocabulary => vocabulary.name === vocabularyName)[0];

          if (foundVocabulary) {
            if (!termName) return StringLocalizer.localize(foundVocabulary.title);
            else {
              let foundTerm = (foundVocabulary.terms || []).filter(term => term.name === termName)[0];

              if (foundTerm) return StringLocalizer.localize(foundTerm.title);
            }
          }
        }
      }
    }

    return null;
  }
}

class MlstrVariableService {

  /**
   * Get the css class that represents the harmonization status.
   * @param status
   * @returns {string}
   */
  static getHarmoStatusClass(status) {
    let iconClass = 'fas fa-minus text-muted';
    if (status === 'complete') {
      iconClass = 'fas fa-check text-success';
    } else if (status === 'impossible') {
      iconClass = 'fas fa-times text-danger';
    } else if (status === 'undetermined') {
      iconClass = 'fas fa-question text-warning';
    } else if (status === 'partial') {
      iconClass = 'fas fa-adjust text-partial';
    } else if (status === 'na') {
      iconClass = 'fas fa-ban text-black';
    }
    return iconClass;
  };

}


// Register all filters

Vue.filter("ellipsis", (input, n, link) => {
  if (input.length <= n) { return input; }
  const subString = input.substr(0, n-1); // the original check
  const anchor = link ? ` <a href="${link}">...</a>` : " ...";
  return subString.substr(0, subString.lastIndexOf(" ")) + anchor;
});

Vue.filter("readmore", (input, link, text) => {
  return `${input} <a href="${link}" class="clearfix btn-link">${text}</a>`;
});

Vue.filter("concat", (input, suffix) => {
  return input + suffix;
});

Vue.filter("localize-string", (input) => {
  if (typeof input === "string") return input;
  return StringLocalizer.localize(input);
});

Vue.filter("markdown", (input) => {
  return marked(input);
});

Vue.filter("localize-number", (input) => {
  return (input || 0).toLocaleString();
});

Vue.filter("translate", (key) => {
  let value = MlstrTranslations[key];
  return typeof value === "string" ? value : key;
});

const DEFAULT_PAGE_SIZES = [10,20,50,100];
const DEFAULT_PAGE_SIZE = DEFAULT_PAGE_SIZES[2];
