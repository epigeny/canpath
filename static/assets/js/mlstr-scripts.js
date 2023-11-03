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

  __ensureStudyClassNameQuery(studyType, query) {
    const classNameQuery = 'harmonization-study' === studyType ? 'in(Mica_study.className,HarmonizationStudy)' : 'in(Mica_study.className,Study)';
    return query ? `and(${classNameQuery},${query})`: classNameQuery;
  }

  __getSearchPageUrl(studyType) {
    return 'harmonization-study' === studyType ? 'harmonization-search' : 'individual-search';
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
        row.push(this.__ensureTargetNumber(study.studySummary.published ? summary.targetNumber : null));
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

class MlstrStudyTablePopoverFactory {

  static create(study, studyTableName) {
    const title = studyTableName;
    let colName = title;

    if (study.description) {
      const description = marked(localizedString(study.description));
      colName =
          '<a class="text-decoration-none" style="cursor: help;" href="javascript:void(0)" ' +
          'data-type="description" ' +
          'data-html="true" ' +
          'data-toggle="popover" ' +
          'data-trigger="hover" ' +
          'data-placement="top" ' +
          'data-boundary="viewport" ' +
          'title="' + Mica.tr['dataset.harmonized-table']+ '"' +
          'data-content="' + description.replaceAll('"', "'") + '">' + title + '</a>';
    }

    return colName;
  }
}

class RoundPercentages {
  static round(numArr, arrDimension) {
    // Normalize array
    if ((numArr || []).length < 1) return Array(arrDimension).fill(0);
    else if (numArr.length < arrDimension) numArr.push(...Array(numArr.length).fill(0));

    const getLargestNumInArrayIndex = (array) => array.indexOf(Math.max.apply(Math, array))

    // Total of all numbers passed.
    const total = numArr[0] + numArr[1] + numArr[2];

    if (total < 1) return numArr;

    // Percentage representations of each number (out of 100).
    const num1Percent = Math.round((numArr[0] / total) * 100);
    const num2Percent = Math.round((numArr[1] / total) * 100);
    const num3Percent = Math.round((numArr[2] / total) * 100);

    // Total percent of the 3 numbers combined (doesnt always equal 100%).
    const totalPercentage = num1Percent + num2Percent + num3Percent;

    // If not 100%, then we need to work around it by subtracting from the largest number (not as accurate but works out).
    if (totalPercentage != 100) {
      // Get the index of the largest number in the array.
      const index = getLargestNumInArrayIndex(numArr);

      // Take the difference away from the largest number.
      numArr[index] = numArr[index] - (totalPercentage - 100);

      // Re-run this method recursively, until we get a total percentage of 100%.
      return RoundPercentages.round(numArr);
    }

    // Return the percentage version of the array passed in.
    return [num1Percent, num2Percent, num3Percent];
  }

}

class MlstrHarmonizationTablePopoverFactory {

  static create(completeCount, partialCount, impossibleCount, statusDetails) {

    const completePercentages = RoundPercentages.round(
      [statusDetails.complete.filter(sd => sd === 'identical').length,
      statusDetails.complete.filter(sd => sd === 'compatible').length,
      statusDetails.complete.filter(sd => sd === 'unknown').length],
      3
    )

    const partialPercentages = RoundPercentages.round(
      [statusDetails.partial.filter(sd => sd === 'proximate').length,
      statusDetails.partial.filter(sd => sd === 'tentative').length,
      statusDetails.partial.filter(sd => sd === 'unknown').length],
      3
    )

    const impossiblePercentages = RoundPercentages.round(
      [statusDetails.impossible.filter(sd => sd === 'unavailable').length,
      statusDetails.impossible.filter(sd => sd === 'incompatible').length,
      statusDetails.impossible.filter(sd => sd === 'unknown').length],
      3
    )

    const template =
      `
<span class='row'>
  <span class='col-4'>
    <i class='fas fa-check fa-fw text-success'></i>
      <span class='pl-1'>
        ${Mica.tr['complete']}
        <span class='float-right'>${completeCount}
      </span>
    </span>
  </span>
  <span class='col-4'>
    <i class='fas fa-adjust fa-fw text-partial'></i>
    <span class='pl-1'>
      ${Mica.tr['partial']}
      <span class='float-right'>${partialCount}</span>
    </span>
  </span>
  <span class='col-4'>
    <i class='fas fa-times fa-fw text-danger'></i>
    <span class='pl-1'>
      ${Mica.tr['impossible']}
      <span class='float-right'>${impossibleCount}</span>
    </span>
  </span>
</span>
<hr />

<span class='row'>
  <span class='col-4'>
    <span class='row'>
      <span class='col-12'>
        <i class='fas fa-check fa-fw text-success'></i>
        <span class='pl-2'>
          ${Mica.tr['sd-identical']}
          <span class='float-right'>
            ${completePercentages[0]}%
          </span>
        </span>
      </span>
    </span>
    <span class='row'>
      <span class='col-12'>
        <i class='fas fa-check fa-fw text-success'></i>
        <span class='pl-2'>
          ${Mica.tr['sd-compatible']}
          <span class='float-right'>
            ${completePercentages[1]}%
          </span>
        </span>
      </span>
    </span>
    <span class='row'>
      <span class='col-12'>
        <i class='fas fa-check fa-fw text-success'></i>
        <span class='pl-2'>
          ${Mica.tr['sd-unknown']}
          <span class='float-right'>
            ${completePercentages[2]}%
          </span>
        </span>
      </span>
    </span>
  </span>

  <span class='col-4'>
    <span class='row'>
      <span class='col-12'>
        <i class='fas fa-adjust fa-fw text-partial'></i>
        <span class='pl-2'>
          ${Mica.tr['sd-proximate']}
          <span class='float-right'>
            ${partialPercentages[0]}%
          </span>
        </span>
      </span>
    </span>
    <span class='row'>
      <span class='col-12'>
        <i class='fas fa-adjust fa-fw text-partial'></i>
        <span class='pl-2'>
          ${Mica.tr['sd-tentative']}
          <span class='float-right'>
            ${partialPercentages[1]}%
          </span>
        </span>
      </span>
    </span>
    <span class='row'>
      <span class='col-12'>
        <i class='fas fa-adjust fa-fw text-partial'></i>
        <span class='pl-2'>
          ${Mica.tr['sd-unknown']}
          <span class='float-right'>
            ${partialPercentages[2]}%
          </span>
        </span>
      </span>
    </span>
  </span>

  <span class='col-4'>
     <span class='row'>
      <span class='col-12'>
        <i class='fas fa-times fa-fw text-danger'></i>
        <span class='pl-2'>
          ${Mica.tr['sd-unavailable']}
          <span class='float-right'>
            ${impossiblePercentages[0]}%
          </span>
        </span>
      </span>
    </span>
    <span class='row'>
      <span class='col-12'>
        <i class='fas fa-times fa-fw text-danger'></i>
        <span class='pl-2'>
          ${Mica.tr['sd-incompatible']}
          <span class='float-right'>
            ${impossiblePercentages[1]}%
          </span>
        </span>
      </span>
    </span>
    <span class='row'>
      <span class='col-12'>
        <i class='fas fa-times fa-fw text-danger'></i>
        <span class='pl-2'>
          ${Mica.tr['sd-unknown']}
          <span class='float-right'>
            ${impossiblePercentages[2]}%
          </span>
        </span>
      </span>
    </span>
  </span>
</span>
      `

    return template.replace(/(\r\n|\n|\r)/gm, "").replace(/>\s+</gm, "><").replace(/\s{3,}/gm, "");
  }
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
