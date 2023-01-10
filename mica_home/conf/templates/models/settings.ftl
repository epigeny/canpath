<!-- Favicon -->
<#assign faviconPath = "/assets/favicon.ico"/>

<!-- Branding -->
<#assign brandImageSrc = "/assets/images/CanPath_logo_neg.png"/>
<#assign brandImageClass = ""/>
<#assign brandTextClass = "CanPath"/>
<#assign brandTextEnabled = true/>

<!-- Theme -->
<!--#assign adminLTEPath = "/assets/theme"/-->

<!-- Cart -->
<#assign cartEnabled = (config?? && config.cartEnabled && (config.studyDatasetEnabled || config.harmonizationDatasetEnabled))/>
<!-- To download the list of variable IDs (and the Opal views, if enabled) -->
<#assign showCartDownload = cartEnabled/>
<!-- To reinstate the cart as views in Opal -->
<#assign showCartViewDownload = (isAdministrator || isReviewer || isEditor || isDAO)/>

<#assign showPaginationInListingPages = false />

<#assign maxItemsPerSet = config.maxItemsPerSet/>

<!-- Repository list pages -->
<#assign listDisplays = ["lines"]/>
<#assign listDefaultDisplay = "lines"/>
<#assign studyListDisplays = listDisplays/>
<#assign studyListDefaultDisplay = listDefaultDisplay/>
<#assign datasetListDisplays = ["cards"]/>
<#assign datasetListDefaultDisplay = "cards"/>

<!-- Search -->
<#assign defaultSearchState = "#lists?type=variables&query=study(in(Mica_study.className,HarmonizationStudy))"/>
<#assign searchVariableColumns = ["label+description", "valueType", "annotations", "study", "dataset"]/>
<#assign searchDatasetColumns = ["name", "type", "variables"]/>
<#assign searchStudyListDisplay = false/>
<#assign searchNetworkListDisplay = false/>
<#assign searchGraphicsDisplay = false/>
<#assign searchCriteriaMenus = ["variable"]/>
<#assign searchVariableSortFields = ["-studyId","datasetId","index","name"]/>
<#assign searchDatasetSortFields = ["-harmonizationTable.studyId","harmonizationTable.populationWeight","acronym"]/>

<!-- Variable -->
<#assign showHarmonizedVariableSummarySelector = false/>

<!-- Variables classifications charts -->
<#assign studyVariablesClassificationsTaxonomies = []/>

<!-- Studies -->
<#assign individualStudyOrder = ["atp", "atlantic-path", "bcgp", "cag", "ohs"]/>
<#assign harmonizationStudyOrder = ["core", "genotype", "canue"]/>

<!-- Harmonization Study -->
<#assign harmonizationStudyStudyTableShowVariables = false/>

<!-- Harmonization Dataset -->
<#assign harmonizationDatasetStudyTableShowVariables = false/>

<!-- Data Access pages -->
<#assign dataAccessInstructionsEnabled = false/>

<#assign studyDesignColors = ["#4c722a","#73a432","#ffe637","#fcb814","#d9461d","#940c12"]/>

<#assign portalNavOverviewUrl = {"en" :"https://www.youtube.com/watch?v=cA-9SBqcAiQ&t=0", "fr": "https://www.youtube.com/watch?v=cA-9SBqcAiQ&t=0"}/>

