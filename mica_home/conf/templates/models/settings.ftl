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
<#assign defaultSearchMode = "HarmonizationStudy"/>

<#assign searchVariableColumns = ["label+description", "valueType", "annotations", "study", "dataset"]/>
<#assign searchVariableColumnsHarmonization = ["label+description", "valueType", "annotations", "protocol"]/>
<#assign searchDatasetColumns = ["name", "type", "variables"]/>
<#assign searchDatasetColumnsHarmonization = ["name", "variables"]/>

<#assign searchStudyListDisplay = false/>
<#assign searchNetworkListDisplay = false/>
<#assign searchGraphicsDisplay = false/>

<#assign searchCriteriaMenus = ["variable"]/>

<#assign searchVariableSortFields = ["-studyId","datasetId","index","name"]/>
<#--  <#assign searchDatasetSortFields = ["-harmonizationTable.studyId","harmonizationTable.populationWeight","acronym"]/>  -->
<#assign searchDatasetSortFields = ["weight"]/>


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

<#assign useColorsArrayForClassificationsChart = false/>

<!-- Data Access pages -->
<#assign dataAccessInstructionsEnabled = false/>

<!-- Based on the 4 main colors: #c5dc6e, #da291c, #ffcd00, #4698cb -->
<#assign colors = ["4698cb","ed7b0e","7F53A7","a3b366","ffcd00","6ec5dc","d55631","d1c033","da291c","c5dc6e","d08345","75a699"]/>

<#assign barChartBackgroundColor = "rgb(70, 152, 203)"/>
<#assign barChartBorderColor = "#4698cb"/>

<#assign studyDesignColors = colors/>

<#assign portalNavOverviewUrl = {"en" :"https://www.youtube.com/watch?v=cA-9SBqcAiQ&t=0", "fr": "https://www.youtube.com/watch?v=cA-9SBqcAiQ&t=0"}/>

<#assign showMaintenance = true/>
