<!-- Data access process page macros -->

<!-- Data access process model template -->
<#macro dataAccessProcessModel>
  <p class="text-height-2">
    Requests for access and information on the CanPath datasets are received by the <strong>CanPath Access Office</strong>. Access
    requests limited to <a href="/harmonization-studies">Harmonized (Core) Data</a>, including COVID-19 Questionnaire data, are eligible for an Expedited Access Review. All
    other requests, including, but not limited to, applications for <a href="/page/samples">Biosamples</a> and administrative health
    linkages, require a Full Access Committee Review.
  </p>

  <div class="card card-info card-outline mt-5 mb-5">
    <div class="card-header">
      <h3 class="card-title">CanPath Access Application Process</h3>
    </div>
    <div class="card-body">
      <div class="row">
        <div class="col-md-4">
          <h5><span class="subheading">Step 1. <br/></span>Create an account</h5>
          <p> Before initiating a request for access, all researchers must create a <strong>CanPath Portal User account</strong>.</p>
          <p class="mb-3">
            <a class="btn btn-outline-primary" href="${contextPath}/signup"><@message "sign-up"/> <i class="fas fa-user-plus"></i></a>
          </p>
        </div>
        <div class="col-md-4">
          <h5><span class="subheading">Step 2. <br/></span>Complete and submit your access request form</h5>
          <p>
            Researchers are encouraged to <strong>review the Application Tip Sheet and contact the Access Office</strong> to understand the requirements involved
            before submitting an application.
          </p>
          <p>
            <a href="${contextPath}/contact" class="btn btn-outline-primary"><@message "contact-menu"/> <i class="fas fa-info-circle"></i></a>

            <a href="${contextPath}/assets/files/CanPath_Data_and_Biosamples_Access_Application_Tip_Sheet_Revised_DRAFT_2022-01-30.pdf" target="_blank" class="btn btn-outline-primary"><@message "application-tips-button"/></a>
          </p>
          <p>
            When researchers are ready to submit an access request, they must complete and submit an
            application form online and attach all of the required documentation by logging
            into their CanPath Portal User account, and creating a <strong><@message "new-data-access-request"/></strong>.
          </p>
          <p class="mb-3">
            <a href="${contextPath}/data-accesses" class="btn btn-outline-primary"><@message "data-access"/> <i class="fas fa-arrow-circle-right"></i></a>
          </p>
        </div>
        <div class="col-md-4">
          <h5><span class="subheading">Step 3. <br/></span>Track your request</h5>
          <p>
            Researchers will be able to track the progress and history of their access request online, by
            logging into their CanPath Portal User account, and checking <strong><@message "my-data-access-requests"/></strong>.
          </p>
          <p>
            <a href="${contextPath}/data-accesses" class="btn btn-outline-primary"><@message "data-access"/> <i class="fas fa-arrow-circle-right"></i></a>
          </p>
        </div>
      </div>
    </div>
  </div>

  <h5 class="mt-5 mb-3"><a id="required" name="required"></a> Required CanPath Access Documentation</h5>
  <p>All applications for access must include the following:</p>
  <ul>
    <li><p>Completed Access Application Form</p></li>
    <li>
      <p>
        Detailed Research protocol containing one specific research question/aim (having received ethics approval)
      </p>
      <ul>
        <li>
          <p>Protocol should include justification of requested variables, statistical analysis, etc.</p>
        </li>
      </ul>
    </li>
    <li><p>Proof of scientific review or peer-review of Research protocol, such as a review by a funding agency (if available)</p></li>
    <li><p>Approval letter by a Research Ethics Board for submitted Research protocol</p></li>
    <li><p>Evidence of funding, if applicable</p></li>
    <li><p>2-Page CV of the principal applicant</p></li>
  </ul>

  <h5 class="mt-5 mb-3">
    <a id="submission_process" name="submission_process"></a> Submit an Access Request
  </h5>
  <p style="text-align:center;"><img alt="" src="/assets/images/CanPathPortalReviewInfographic.webp" style="width: 75%;"></p>

  <div class="accordion" id="accessProcessAccordion">
    <div class="card mb-0">
      <div class="card-header">
        <button type="button" class="btn btn-link btn-block text-left" data-toggle="collapse" data-target="#collapseOne">Access Criteria &amp; Requirements</button>
      </div>
      <div id="collapseOne" class="collapse" data-parent="#accessProcessAccordion">
        <div class="card-body">
          <p>
            All completed and submitted Access Application Forms and associated documentation are reviewed by the independent Access Committee according to the following criteria:
          </p>

          <ul>
            <li>The Applicant is a bona fide researcher (i.e. evidence that the researcher has relevant experience and qualifications);</li>
            <li>The research project is in conformity with both the Guiding Principles of CanPath and the informed consents signed by the Research Participants (see Sections 2 and 4a of the <a href="#access_policies">CanPath Access Policy</a>);</li>
            <li>The Access Office has provided proof of administrative completeness and availability of CanPath Data and/or Biosamples</li>
          </ul>

          <p>The Access Office assessment has established that the application meets the following requirements:</p>

          <ul>
            <li>The research study has been deemed scientifically sound;</li>
            <li>The existence of adequate resources to effectively complete the research project has been established (e.g. funding, collaborators and staff);</li>
            <li>Sufficient justification for the need for the CanPath Data and/or Biosamples requested has been provided;</li>
            <li>
              <span>
                The provision of the requested biosamples is justified based on the assessment of the value of returned data, the scientific contribution of the research project, the potential impact of providing the samples on future needs for the biosamples and the risk of sample depletion.
              </span>
              <span class="d-inline-block mt-3">
                All CanPath participants completed a detailed questionnaire at the time of recruitment (baseline) and continue to provide updated health and lifestyle information through follow-up questionnaires.
              </span>
            </li>
          </ul>
        </div>
      </div>
    </div>
    <div class="card mb-0">
      <div class="card-header">
        <button type="button" class="btn btn-link btn-block text-left" data-toggle="collapse" data-target="#collapseTwo">Harmonized Datasets</button>
      </div>
      <div id="collapseTwo" class="collapse" data-parent="#accessProcessAccordion">
        <div class="card-body">
          <p>
            Nationally harmonized datasets include data collected by the five mature cohorts: BC Generations Project, Alberta's Tomorrow Project, Ontario Health Study, CARTaGENE and the Atlantic PATH. Data from the Manitoba Tomorrow Project will be made available once participant recruitment is complete.
          </p>

          <p>
            Harmonized datasets available include:
          </p>

          <ul>
            <li>Baseline Health and Risk Factors Questionnaire</li>
            <li>Baseline Health and Risk Factors Questionnaire with Additional Diseases</li>
            <li>Baseline Mental Health Questionnaire</li>
            <li>Baseline Physical Measures</li>
            <li>Follow-up Health and Risk Factors Questionnaire</li>
            <li>Pre-analytical Data Related to Biological Samples</li>
            <li>Genotyping Data</li>
            <li>CANUE Environmental Exposure Data</li>
            <li>COVID-19 Questionnaire &mdash; Now Available</li>
          </ul>
        </div>
      </div>
    </div>
    <div class="card mb-0">
      <div class="card-header">
        <button type="button" class="btn btn-link btn-block text-left" data-toggle="collapse" data-target="#collapseThree">The Access Committe</button>
      </div>
      <div id="collapseThree" class="collapse" data-parent="#accessProcessAccordion">
        <div class="card-body">
          <p>
            The Access Committee reviews and makes approval decisions on research applications submitted for CanPath Data and/or Biosamples. The committee is composed of independent members from across Canada who have expertise in such relevant fields as biostatistics, epidemiology, and genomics. The Access Committee meets bi-monthly to review projects requiring Full Access Committee Review.
          </p>
        </div>
      </div>
    </div>
    <div class="card mb-0">
      <div class="card-header">
        <button type="button" class="btn btn-link btn-block text-left" data-toggle="collapse" data-target="#collapseFour">Expedited Review Criteria</button>
      </div>
      <div id="collapseFour" class="collapse" data-parent="#accessProcessAccordion">
        <div class="card-body">
          <p>
            Access Applications meeting the criteria for an Expedited Review are accepted on an ongoing basis and will be completed within approximately 3 weeks. (This timeline is contingent on the applicant's responsiveness throughout the process).            
          </p>

          <p>
            As noted in the <a href="#access_policies">CanPath Access Policy</a>, the following criteria are used to determine if applications qualify for an Expedited Review:
          </p>

          <ul>
            <li>Requesting Harmonized Datasets:</li>
            <li>Low reputational risk based on the research question being addressed and its scientific merit;</li>
            <li>The project has been evaluated through a recognized scientific review or peer review process;</li>
            <li>There is evidence of financial support for the project; and</li>
            <li>The Research Team has sufficient membership and expertise to complete the analyses.</li>
          </ul>

          <p>
            <strong>Note: </strong>With the exception of the first two points, applications do not need to meet all of these criteria to be considered for Expedited Review.
          </p>
        </div>
      </div>
    </div>
    <div class="card mb-0">
      <div class="card-header">
        <button type="button" class="btn btn-link btn-block text-left" data-toggle="collapse" data-target="#collapseFive">Full Access Review Criteria</button>
      </div>
      <div id="collapseFive" class="collapse" data-parent="#accessProcessAccordion">
        <div class="card-body">
          <p>
            As noted in the <a href="#access_policies">CanPath Access Policy</a>, Access Applications meeting <strong>any of the following criteria</strong> will require a Full Access Committee Review:
          </p>

          <ul>
            <li>Requests for data <strong>other</strong> than datasets listed as '<a href="/harmonization-studies">Harmonized Data</a>';</li>
            <li>Access to biosamples are requested;</li>
            <li>Research question addresses a potentially contentious research question (e.g., compares outcomes by ethnicity or community, potentially negative impact on subsets of participants) or with a high risk of reidentification; or</li>
            <li>Request includes linkage to administrative health data.</li>
          </ul>

          <p>
            Access Applications requiring a Full Access Committee Review are accepted on an ongoing basis and can be completed in as little as 6 weeks. (This timeline is contingent on the applicant's responsiveness throughout the process.)
          </p>
        </div>
      </div>
    </div>
    <div class="card mb-0">
      <div class="card-header">
        <button type="button" class="btn btn-link btn-block text-left" data-toggle="collapse" data-target="#collapseSix">Expedited COVID-19 Data Access</button>
      </div>
      <div id="collapseSix" class="collapse" data-parent="#accessProcessAccordion">
        <div class="card-body">
          <p>
            National harmonized data from the CanPath COVID-19 Questionnaire is now available to researchers. Given the immediate need for pandemic research, CanPath has revised its expedited review process to provide researchers timely access to the COVID-19 data. Requests for access to the national COVID-19 Questionnaire dataset will be <strong>reviewed in as little as 9 business days</strong>. Please refer to the Expedited Review Criteria for eligibility.
          </p>
        </div>
      </div>
    </div>
    <div class="card mb-0">
      <div class="card-header">
        <button type="button" class="btn btn-link btn-block text-left" data-toggle="collapse" data-target="#collapseSeven">Access Cost</button>
      </div>
      <div id="collapseSeven" class="collapse" data-parent="#accessProcessAccordion">
        <div class="card-body">
          <p>
            CanPath has a tiered pricing model suited to the different budgets of trainees, early-career researchers, and established researchers. Applicants are invited to complete a <a href="/assets/files/CanPath%20Request%20for%20LoS%20Form.docx">Cost Estimate Form</a> and submit by email to <a href="mailto:access@canpath.ca">access@canpath.ca</a>.
          </p>
        </div>
      </div>
    </div>
  </div>

  <h5 class="mt-5 mb-3">Need Support?</h5>
  <div>All CanPath access questions can be directed to the Access Office.</div>
  <p>Email: <a href="mailto:access@canpath.ca">access@canpath.ca</a></p>

  <h5 class="mt-5 mb-3"><a id="access_policies" name="access_policies"></a>CanPath Policies &amp; Guidelines</h5>
  <p>We strongly recommend that you consult these prior to submitting an&nbsp;Access Application Form:</p>
  <ul>
    <li>
      <a href="/assets/files/Access_Policy_v2.0_Approved_16Mar2022.pdf"
         target="_blank">CanPath Access Policy</a></li>
    <li>
      <a href="/assets/files/CanPath%20Publications%20Policy_Approved%202020-Sep-23.pdf"
         target="_blank">Publications Policy</a></li>
    <li>
      <a href="/assets/files/CanPath%20Intellectual%20Property%20Policy_v1.1_2020-07-22.pdf"
         target="_blank">Intellectual Property Policy</a></li>
    <li>
      <a href="/assets/files/CanPath%20Guidelines%20For%20Biosample%20Access_June2020.pdf"
         target="_blank">Guidelines for Biosample Access</a></li>
    <li>
      <a href="/assets/files/CanPath%20Biosample%20Feasiblity%20Review_June2020.pdf"
         target="_blank">Biosample Feasibility Review</a></li>
    <li>
      <a href="/assets/files/CanPath%20Industry%20Research%20Policy_v1.0_2021-07-28.pdf"
         target="_blank">Industry Research Policy</a></li>
  </ul>

</#macro>