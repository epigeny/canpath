<!-- Timeline -->
<script src="${contextPath}/bower_components/d3/d3.js"></script>
<script src="${contextPath}/bower_components/mica-study-timeline/dist/mica-study-timeline.js"></script>

<!-- ChartJS -->
<script src="${adminLTEPath}/plugins/chart.js/Chart.min.js"></script>
<script src="${assetsPath}/js/mica-charts.js"></script>
<!-- Select2 -->
<script src="${adminLTEPath}/plugins/select2/js/select2.js"></script>
<script src="${adminLTEPath}/plugins/select2/js/i18n/${.lang}.js"></script>

<!-- Files -->
<script src="${assetsPath}/libs/node_modules/vue/dist/vue.js"></script>
<script src="${assetsPath}/js/mica-files.js"></script>

<!-- Repository -->
<script src="${assetsPath}/js/mica-repo.js"></script>

<script>
  Mica.options = {};
  <#if study.populations?? && study.populations?size != 0>
    <#list study.populationsSorted as population>
      <#if type == "Individual">
        <#assign graphicsSubTitle = "study.graphics.areas-of-information.subtitle"/>
        <#if population.dataCollectionEvents?? && population.dataCollectionEvents?size != 0>
          <#list population.dataCollectionEventsSorted as dce>
            Mica.options['${study.id}:${population.id}:${dce.id}'] =
                    escapeQuotes(<#if study.populations?size == 1>"${localize(dce.name)}"<#else>"${localize(population.name)} / ${localize(dce.name)}"</#if>);
          </#list>
        </#if>
      <#else>
        <#assign graphicsSubTitle = "harmonization-project.graphics.areas-of-information.subtitle"/>
        Mica.options['${study.id}:${population.id}:.'] = escapeQuotes("${localize(population.name)}");
      </#if>
    </#list>
  </#if>

  const makeVariablesClassificationsChartSettingsMlstr = function(studyId, chartData, chartDataset) {
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
          let searchUrl;
          const index =  chartElement[0]._index;
          const vocabularyData = (chartData.vocabularies || [])[index];
          if (vocabularyData) {
            if ('_all' === chartDataset.key) {
              searchUrl = "${contextPath}/search#lists?query=variable(and(exists(" + vocabularyData.taxonomy + "." + vocabularyData.name + "),in(Mica_variable.studyId,(" + encodeURIComponent(studyId) + "))))&type=variables";
            } else {
              searchUrl = "${contextPath}/search#lists?query=variable(and(exists(" + vocabularyData.taxonomy + "." + vocabularyData.name + "),in(Mica_variable.dceId,(" + encodeURIComponent(chartDataset.key) + "))))&type=variables";
            }

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
  }

  const renderVariablesClassifications = function(studyId, key) {
    $('#loadingClassifications').hide();
    const chartsElem = $('#chartsContainer');
    chartsElem.children().remove();
    if (Mica.variablesCoverage) {
      Mica.variablesCoverage.forEach(chartData => {
        chartsElem.append('<h5 class="text-center">' + chartData.title + '</h5>');
        chartsElem.append('<p class="text-center">' + chartData.subtitle + '</p>');
        chartsElem.append('<canvas class="mb-4"></canvas>');
        const chartCanvas = $('#chartsContainer canvas:last-child').get(0).getContext('2d');
        new Chart(chartCanvas, makeVariablesClassificationsChartSettingsMlstr(studyId, chartData, {
          key: key,
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

  const initSelectBucket = function() {
    // scan for bucket ids
    if (Mica.variablesCoverage) {
      const buckets = [];
      Mica.variablesCoverage.forEach(chartData => {
        Object.keys(chartData.itemCounts).forEach(k => {
          if (k !== '_all' && !buckets.includes(k)) {
            buckets.push(k);
          }
        });
      });
      const selectBucketElem = $('#select-bucket');
      selectBucketElem.select2({
        theme: 'bootstrap4'
      }).on('select2:select', function (e) {
        let data = e.params.data;
        //console.log(data);
        $('#classificationsContainer').hide();
        renderVariablesClassifications('${study.id}', data.id);
      });
      buckets.forEach(k => {
        let newOption = new Option(Mica.options[k], k, false, false);
        selectBucketElem.append(newOption);
      });

      if (buckets.length < 2) {
        selectBucketElem.parent().hide();
      }
    }
  };

  $(function () {
    function prepareStudyVariablesClassificationsData(chart) {
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

    let options = dataTablesDefaultOpts;
    options.columnDefs = [
      { "type": "num", "targets": 0, "visible": false }
    ];
    <#list study.populations as pop>
      $("#population-${pop.id}-dces").DataTable(options);
    </#list>

    QueryService.getCounts('studies', { query: "study(in(Mica_study.id,${study.id}))" }, function(stats) {
      $('#network-hits').text(numberFormatter.format(stats.networkResultDto.totalHits));
      $('#dataset-hits').text(numberFormatter.format(stats.datasetResultDto.totalHits));
      $('#variable-hits').text(numberFormatter.format(stats.variableResultDto.totalHits));
    });

    <#if timelineData??>
      let timelineData = ${timelineData};

      new $.MicaTimeline(new $.StudyDtoParser('${.lang}'), (study, pop, dce) => "#modal-"+pop.id+"-"+dce.id)
        .create('#timeline', timelineData)
        .addLegend();

    </#if>

    <!-- Files -->
    const filesTr = {
      "item": "<@message "item"/>",
      "items": "<@message "items"/>",
      "download": "<@message "download"/>"
    };
    <#if showStudyFiles>
      makeFilesVue('#study-files-app', {
        type: '${type?lower_case}-study',
        id: '${study.id}',
        basePath: '',
        path: '/',
        folder: {},
        tr: filesTr,
        locale: '${.lang}',
        contextPath: '${contextPath}'
      }, function(file) {
        return !(file.type === 'FOLDER' && file.name === 'population');
      });
    </#if>

    <#if study.populations?? && study.populations?size != 0>
      <#list study.populations as population>
        <#if showStudyPopulationFiles>
          makeFilesVue('#study-${population.id}-files-app', {
            type: '${type?lower_case}-study',
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
        <#if type == "Individual" && showStudyDCEFiles>
          <#if population.dataCollectionEvents?? && population.dataCollectionEvents?size != 0>
            <#list population.dataCollectionEventsSorted as dce>
              makeFilesVue('#study-${population.id}-${dce.id}-files-app', {
                type: '${type?lower_case}-study',
                id: '${study.id}',
                basePath: '/population/${population.id}/data-collection-event/${dce.id}',
                path: '/',
                folder: {},
                tr: filesTr,
                locale: '${.lang}',
                contextPath: '${contextPath}'
              });
            </#list>
          </#if>
        </#if>
      </#list>
    </#if>

    <!-- Variables classifications -->
    <#if studyVariablesClassificationsTaxonomies?? && studyVariablesClassificationsTaxonomies?size gt 0>
      const taxonomies = ['${networkVariablesClassificationsTaxonomies?join("', '")}'];
      $('#classificationsContainer').hide();
      StudyService.getVariablesCoverage('${study.id}', taxonomies, '${.lang}', function(data) {
        if (data && data.charts) {
          Mica.variablesCoverage = data.charts.map(chart => prepareStudyVariablesClassificationsData(chart));
        }
        initSelectBucket();
        renderVariablesClassifications('${study.id}', '_all');
      }, function(response) {

      });
    </#if>

    function ensurePopulationDceSelection() {
      const hash = new URL(window.location).hash;
      const regex = /population\/([^\/]*)|data-collection-event\/(.*)$/g;

      const matches = [...StringMatcher.matchAll(hash, regex)];
      if (matches.length > 0) {
        const populationId = matches[0][1].split(/:/).pop();
        let dceId = '';
        if (matches.length > 1) {
          dceId = matches[1][2].split(/:/).pop();
        }

        const navOffset = [...document.querySelectorAll('nav.main-header')].reduce((acc, element) => {
          acc += element.offsetHeight;
          return acc;
        }, 0)

        $([document.documentElement, document.body]).animate({
          scrollTop: $("#populations").offset().top - navOffset
        }, 250);

        setTimeout(() => {
          $('a[href="#population-'+populationId+'"]').tab('show');
          if (dceId) {
            $('#modal-'+populationId+'-'+dceId).modal();
          }
        }, 250);

      }
    }

    function createModalRowItems(row, title, value) {
      const dt = document.createElement('dt');
      dt.className = 'col-sm-4';
      dt.innerHTML = title;
      row.appendChild(dt);

      const dd = document.createElement('dd');
      dd.className = 'col-sm-8';
      dd.innerHTML = value;
      row.appendChild(dd);
    }

    function createMemberModal(member, modalId) {
      const modalTitleInnerHtml = [(member.title || ''), (member.firstName || ''), member.lastName];

      const modal = document.createElement('div');
      modal.className = 'modal fade';
      modal.id = modalId;

      const modalDialog = document.createElement('div');
      modalDialog.className = 'modal-dialog';

      const modalContent = document.createElement('div');
      modalContent.className = 'modal-content';

      const modalHeader = document.createElement('div');
      modalHeader.className = 'modal-header';

      const modalTitle = document.createElement('h4');
      modalTitle.className = 'modal-title';
      modalTitle.innerHTML = modalTitleInnerHtml.join(' ').trim();
      modalHeader.appendChild(modalTitle);

      const titleCloseButton = document.createElement('button');
      titleCloseButton.type = 'button';
      titleCloseButton.className = 'close';
      titleCloseButton.setAttribute('data-dismiss', 'modal');
      titleCloseButton.innerHTML = '&times;';
      modalHeader.appendChild(titleCloseButton);
      modalContent.appendChild(modalHeader);

      const modalBody = document.createElement('div');
      modalBody.className = 'modal-body';

      const row = document.createElement('dl');
      row.className = 'row';

      if (member.title) {
        createModalRowItems(row, '<@message "contact.title"/>', member.title);
      }

      createModalRowItems(row, '<@message "contact.name"/>', [(member.firstName || ''), member.lastName].join(' ').trim());

      if (member.email) {
        createModalRowItems(row, '<@message "contact.email"/>', member.email);
      }

      if (member.phone) {
        createModalRowItems(row, '<@message "contact.phone"/>', member.phone);
      }

      if (member.institution) {
        if (member.institution.name) {
          createModalRowItems(row, '<@message "contact.institution"/>', StringLocalizer.localize((member.institution || {}).name));
        }

        if (member.institution.department) {
          createModalRowItems(row, '<@message "contact.department"/>', StringLocalizer.localize((member.institution || {}).department));
        }

        if (member.institution.address && (member.institution.address.street || member.institution.address.city)) {
          let address = [StringLocalizer.localize(member.institution.address.street || ''), StringLocalizer.localize(member.institution.address.city || ''), (member.institution.address.countryIso || '')];

          createModalRowItems(row, '<@message "address.label"/>', address.join(' '));
        }
      }

      modalBody.appendChild(row);
      modalContent.appendChild(modalBody);

      const modalFooter = document.createElement('div');
      modalFooter.className = 'modal-footer';

      const modalFooterCloseButton = document.createElement('button');
      modalFooterCloseButton.type = 'button';
      modalFooterCloseButton.className = 'btn btn-info';
      modalFooterCloseButton.setAttribute('data-dismiss', 'modal');
      modalFooterCloseButton.innerHTML = '<@message "close"/>';
      modalFooter.appendChild(modalFooterCloseButton);
      modalContent.appendChild(modalFooter);

      modalDialog.appendChild(modalContent);

      modal.appendChild(modalDialog);
      return modal;
    }

    function createMembersList(members, role) {
      const list = document.createElement('ul');
      list.className = 'list-unstyled';
      list.style.columns = members.length === 1 ? 1 : 2;

      members.forEach((member, index) => {
        const anchorInnerHtml = [(member.title || ''), (member.firstName || ''), member.lastName];
        const modalId = 'modal-' + role + '-' + index;

        const listItem = document.createElement('li');
        listItem.className = 'mb-2';

        const anchor = document.createElement('a');
        anchor.className = 'text-info';
        anchor.href = '#';
        anchor.innerHTML = anchorInnerHtml.join(' ').trim();
        anchor.setAttribute('data-toggle', 'modal');
        anchor.setAttribute('data-target', '#' + modalId);
        listItem.appendChild(anchor);

        const br = document.createElement('br');
        listItem.appendChild(br);

        const span = document.createElement('span');
        span.className = 'text-muted';

        const small = document.createElement('small');
        small.innerHTML = StringLocalizer.localize((member.institution || {}).name);
        span.appendChild(small);
        listItem.appendChild(span);

        list.appendChild(listItem);
        list.appendChild(createMemberModal(member, modalId));
      });

      return list;
    }

    function ensureDraftModeStudyMemberships() {
      let url = '/ws/study/${study.id}';
      axios.get(MicaService.normalizeUrl(url))
        .then(response => {
          const memberships = response.data.memberships;

          const investigatorsContainer = document.querySelector('#study-investigators');
          const contactsContainer = document.querySelector('#study-contacts');

          const investigators = (memberships.filter(m => m.role === 'investigator')[0] || {}).members
          const contacts = (memberships.filter(m => m.role === 'contact')[0] || {}).members;

          <#if (study.memberships.investigator)?? && study.memberships.investigator?size == 0>
          if (Array.isArray(investigators)) {
            investigatorsContainer.appendChild(createMembersList(investigators, 'investigator'));
          }
          </#if>

          <#if (study.memberships.contacts)?? && study.memberships.contacts?size == 0>
          if (Array.isArray(contacts)) {
            contactsContainer.appendChild(createMembersList(contacts, 'contact'));
          }
          </#if>
        })
        .catch((response) => {
          console.error('Failed to retrieve ', url);
        });
    }

    <#if draft>
      ensureDraftModeStudyMemberships();
    </#if>

    ensurePopulationDceSelection();
  });
</script>
