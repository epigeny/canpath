<!-- Custom js -->

<script>
  $(function () {
    // set moment's locale
    moment.locale('${.lang}');
    $('.moment-date2').each(function () {
      var msg = $.trim($(this).html());
      if (msg && msg.length > 0) {
          msg = moment(msg, 'DD-MM-YYYY').format('LL');
          $(this).html(msg);
      }
    });
    $('a.brand-link').removeClass('bg-white').addClass('bg-navy');
    $('#search-page aside.sidebar-dark-primary').removeClass('sidebar-dark-primary').addClass('sidebar-light-primary');

    // searchinfo cookie to hide for ever the search-info alert once closed
    const searchInfoCookie = 'searchinfo';
    $('#search-info').on('closed.bs.alert', function () {
        document.cookie = searchInfoCookie + '=1';
    });
    function getCookieValue(name) {
        let result = document.cookie.match("(^|[^;]+)\\s*" + name + "\\s*=\\s*([^;]+)")
        return result ? result.pop() : ""
    }
    const searchInfoValue = getCookieValue(searchInfoCookie);
    if (searchInfoValue === '1') {
        $('#search-info').hide();
    } else {
        $('#search-info').show();
    }
  });

  // make sure website is always in English
  const cookie = document.cookie || "";
  let cookieMap = {};

  if (cookie.length > 0) {
    cookieMap = cookie.split(';').reduce((acc, part) => {
      const [key, value] = part.split('=');
      acc[key.trim()] = value.trim();
      return acc
    }, {});
  }

  let mlstrDataTablesDefaultOpts = {
    paging: true,
    pageLength: 50,
    lengthChange: true,
    searching: true,
    ordering: false,
    processing: true,
    info: true,
    autoWidth: false,
    fixedHeader: true,
    language: {
      "url": "${assetsPath}/i18n/mlstr-datatables.${.lang}.json"
    },
    dom: "<'row'<'col-sm-5'i><'col-sm-7'f>><'row'<'table-responsive'tr>><'row'<'col-sm-3'l><'col-sm-9'p>>",
    preDrawCallback: function (settings) {
      const api = new $.fn.dataTable.Api(settings);
      const data  = api.data();
      const paginationAndLength = $(this)
        .closest('.dataTables_wrapper')
        .find('.dataTables_paginate, .dataTables_length');
      paginationAndLength.toggle(api.page.info().pages > 1);

      if (data) {
        const searchAndPageInfo = $(this)
          .closest('.dataTables_wrapper')
          .find('.dataTables_info, .dataTables_filter');
        searchAndPageInfo.toggle(data.length > 5);
      }
    }
  };

  class StringMatcher {
    static matchAll(text, regexp) {
      if (text.matchAll) {
        return text.matchAll(regexp);
      }

      let match, matches = [];
      while(match = regexp.exec(text)){
        matches.push(match);
      }

      return matches;
    }
  }

  const MlstrTranslations = {
    "all": "<@message "all"/>",
    "variables": "<@message "variables"/>",
    "variable": "<@message "variable"/>",
    "datasets": "<@message "datasets"/>",
    "studies": "<@message "studies"/>",
    "networks": "<@message "networks"/>",
    "network": "<@message "network"/>",
    "name": "<@message "name"/>",
    "label": "<@message "label"/>",
    "annotations": "<@message "annotations"/>",
    "study": "<@message "study"/>",
    "dataset": "<@message "dataset"/>",
    "population": "<@message "population"/>",
    "data-collection-event-bucket": "<@message "search.coverage-buckets.dce"/>",
    "data-collection-event": "<@message "data-collection-event"/>",
    "dce": "<@message "search.study.dce-name"/>",
    "acronym": "<@message "acronym"/>",
    "valueType": "<@message "value-type"/>",
    "text-type": "<@message "text-type"/>",
    "integer-type": "<@message "integer-type"/>",
    "decimal-type": "<@message "decimal-type"/>",
    "boolean-type": "<@message "boolean-type"/>",
    "binary-type": "<@message "binary-type"/>",
    "date-type": "<@message "date-type"/>",
    "datetime-type": "<@message "datetime-type"/>",
    "point-type": "<@message "point-type"/>",
    "linestring-type": "<@message "linestring-type"/>",
    "polygon-type": "<@message "polygon-type"/>",
    "locale-type": "<@message "locale-type"/>",
    "type": "<@message "type"/>",
    "study-design": "<@message "study-design"/>",
    "data-sources-available": "<@message "data-sources-available"/>",
    "participants": "<@message "participants"/>",
    "individual": "<@message "individual"/>",
    "harmonization": "<@message "harmonization"/>",
    "collected": "<@message "collected"/>",
    "harmonized": "<@message "harmonized"/>",
    "dataschema": "<@message "Dataschema"/>",
    "no-variable-found": "<@message "no-variable-found"/>",
    "no-dataset-found": "<@message "no-dataset-found"/>",
    "no-study-found": "<@message "no-study-found"/>",
    "no-network-found": "<@message "no-network-found"/>",
    "coverage-buckets-study": "<@message "coverage-buckets-study"/>",
    "coverage-buckets-dce": "<@message "coverage-buckets-dce"/>",
    "coverage-buckets-dataset": "<@message "coverage-buckets-dataset"/>",
    "no-coverage-available": "<@message "no-coverage-available"/>",
    "coverage-end-date-ongoing": "<@message "coverage-end-date-ongoing"/>",
    "missing-variable-query": "<@message "missing-variable-query"/>",
    "no-graphics-result":  "<@message "no-graphics-result"/>",
    "taxonomy": "<@message "taxonomy"/>",
    "select-all": "<@message "select-all"/>",
    "clear-selection": "<@message "clear-selection"/>",
    "search.filter": "<@message "search-filter"/>",
    "search.filter-help": "<@message "search-filter-help"/>",
    "search.in": "<@message "search-in"/>",
    "search.out": "<@message "search-out"/>",
    "search.none": "<@message "search-none"/>",
    "search.any": "<@message "search-any"/>",
    "search.from": "<@message "search-from"/>",
    "search.to": "<@message "search-to"/>",
    "search.and": "<@message "search-and"/>",
    "search.or": "<@message "search-or"/>",
    "query-update": "<@message "query-update"/>",
    "criterion.created": "<@message "criterion-created"/>",
    "criterion.updated": "<@message "criterion-updated"/>",
    "geographical-distribution-chart-title": "<@message "geographical-distribution-chart-title"/>",
    "geographical-distribution-chart-text": "<@message "geographical-distribution-chart-text"/>",
    "study-design-chart-title": "<@message "study-design-chart-title"/>",
    "study-design-chart-text": "<@message "study-design-chart-text"/>",
    "number-participants-chart-title": "<@message "number-participants-chart-title"/>",
    "number-participants-chart-text": "<@message "number-participants-chart-text"/>",
    "bio-samples-chart-title": "<@message "bio-samples-chart-title"/>",
    "bio-samples-chart-text": "<@message "bio-samples-chart-text"/>",
    "study-start-year-chart-title": "<@message "study-start-year-chart-title"/>",
    "study-start-year-chart-text": "<@message "study-start-year-chart-text"/>",
    "to": "<@message "to"/>",
    "more": "<@message "search.facet.more"/>",
    "less": "<@message "search.facet.less"/>",
    "no-variable-added": "<@message "sets.cart.no-variable-added"/>",
    "no-variable-added-set": "<@message "sets.set.no-variable-added"/>",
    "variables-added-to-cart": "<@message "variables-added-to-cart"/>",
    "variables-added-to-set": "<@message "variables-added-to-set"/>",
    "collapse": "<@message "collapse"/>",
    "value": "<@message "value"/>",
    "frequency": "<@message "frequency"/>",
    "graphics.total": "<@message "graphics.total"/>",
    "collected-dataset": "<@message "collected-dataset"/>",
    "collected-datasets": "<@message "collected-datasets"/>",
    "harmonized-dataset": "<@message "harmonized-dataset"/>",
    "harmonized-datasets": "<@message "harmonized-datasets"/>",
    "collected-variable": "<@message "collected-variable"/>",
    "collected-variables": "<@message "client.label.study-variables"/>",
    "harmonized-variable": "<@message "harmonized-variable"/>",
    "harmonized-variables": "<@message "harmonized-variables"/>",
    "number-participants": "<@message "number-participants"/>",
    "cohort_study": "<@message "study_taxonomy.vocabulary.methods-design.term.cohort_study.title"/>",
    "case_control": "<@message "study_taxonomy.vocabulary.methods-design.term.case_control.title"/>",
    "case_only": "<@message "study_taxonomy.vocabulary.methods-design.term.case_only.title"/>",
    "cross_sectional": "<@message "study_taxonomy.vocabulary.methods-design.term.cross_sectional.title"/>",
    "clinical_trial": "<@message "study_taxonomy.vocabulary.methods-design.term.clinical_trial.title"/>",
    "other": "<@message "study_taxonomy.vocabulary.methods-design.term.other.title"/>",
    "registry": "<@message "Registry"/>",
    "listing-typeahead-placeholder": "<@message "global.list-search-placeholder"/>",
    "no-limit": "<@message "no-limit"/>",
    "search.coverage-dce-cols.study": "<@message "search.coverage-dce-cols.study"/>",
    "search.coverage-dce-cols.population": "<@message "search.coverage-dce-cols.population"/>",
    "search.coverage-dce-cols.dce": "<@message "search.coverage-dce-cols.dce"/>",
    "search.coverage-buckets.dataset": "<@message "search.coverage-buckets.dataset"/>",
    "search.coverage-buckets.study": "<@message "search.coverage-buckets.study"/>",
    "complete": "<@message "harmonization-status-complete"/>",
    "undetermined": "<@message "harmonization-status-undetermined"/>",
    "impossible": "<@message "harmonization-status-impossible"/>",
    "partial": "<@message "harmonization-status-partial"/>",
    "na": "<@message "harmonization-status-na"/>"
  };

  const Mica = {
    locale: "${.lang}",
    tr: MlstrTranslations
  };

  class ColorManagementUtility {
    // colors generated by https://coolors.co/6c9a00-afbb54-d0cc7e-f1dca7-f8d488-ffcb69-f9b463-f39d5d-ed8657-e76f51
    static get RGB_ARRAY() {
      return ['${colors?join("', '")}'].map(color => color.match(/[a-zA-Z0-9]{1,2}/g).map(c => parseInt(c, 16)));
    }

    static get PADDED_RGB_ARRAY() {
      return ColorManagementUtility.createPaddedColorArray([]); // empty array for to add nothing, else adds 4 more
    }

    static applyAlpha(rgbColorArray, ratio) {
      const alpha = 1 - ratio;
      return rgbColorArray.map(c => Math.round((alpha * 255) + (ratio * c)));
    }

    static createPaddedColorArray(steps) {
      function luma(rgb) {
        // based on https://stackoverflow.com/a/56678483
        // Step One: Convert all sRGB 8 bit integer values to decimal 0.0-1.0
        const decimalR = rgb[0] / 255;
        const decimalG = rgb[1] / 255;
        const decimalB = rgb[2] / 255;

        // Step Two: Convert a gamma encoded RGB to a linear value and apply the standard coefficients
        const luminance = 
          (0.2126 * decimalColorValueToLinearized(decimalR)) + 
          (0.7152 * decimalColorValueToLinearized(decimalG)) + 
          (0.0722 * decimalColorValueToLinearized(decimalB));

        // Percieved lightness 
        if (luminance <= (216 / 24389)) {
          return luminance * (24389 / 27);
        } else {
          return (Math.pow(luminance, (1 / 3)) * 116) - 16;
        }
      }

      function decimalColorValueToLinearized(value) {
        if (value <= 0.04045) {
          return value / 12.92;
        } else {
          return Math.pow(((value + 0.055) / 1.055), 2.4);
        }
      }

      if (!Array.isArray(steps)) {
        steps = [0.1, 0.2, 0.35, 0.5];
      }

      const paddedRgbArray = [];

      ColorManagementUtility.RGB_ARRAY.forEach(item => {
        paddedRgbArray.push(item);
        steps.map(step => ColorManagementUtility.applyAlpha(item, step)).forEach(step => paddedRgbArray.push(step));
      });

      const sortFunction = (rgbA, rgbB) => {
        const a = luma(rgbA);
        const b = luma(rgbB);

        if (a === b) {
          return 0;
        }

        return a < b ? 1 : -1;
      };

      return paddedRgbArray;
    }

    static colorize(ratio) {
      const array = ColorManagementUtility.PADDED_RGB_ARRAY;
      let index = Math.ceil((ratio * 100) / array.length);

      if (index >= array.length) {
        index = array.length - 1;
      }

      return 'rgb(' + array[index].join() + ')';
    }
  }

</script>

<!-- Default model macros -->

<script src="/assets/js/custom.js"></script>
