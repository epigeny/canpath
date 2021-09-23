<!-- Data access process page macros -->

<!-- Data access process model template -->
<#macro dataAccessProcessModel>
  <p class="text-height-2">
    Requests for access and information on the CanPath datasets are received by the <strong>CanPath Access Office</strong>. Access
    requests limited to <a href="/harmonization-studies">Harmonized (Core) Data</a>, including COVID-19 Questionnaire data, are eligible for an Expedited Access Review. All
    other requests, including, but not limited to, applications for <a href="/page/samples">Biosamples</a> and administrative health
    linkages, require a Full Access Committee Review. Submission deadlines for Full Access Committee Reviews are <a href="#review_process">listed here</a>.
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
            Researchers are encouraged to <strong>contact the Access Office</strong> to understand the requirements involved
            before submitting an application.
          </p>
          <p>
            <a href="${contextPath}/contact" class="btn btn-outline-primary"><@message "contact-menu"/> <i class="fas fa-info-circle"></i></a>
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
  <p style="text-align:center;"><img alt="" src="/assets/images/submission_process.png" style="width: 750px; height: 498px;"></p>

  <h6><a id="review_process" name="review_process">CanPath Review Processes</a></h6>

  <p>
    Requests for access to CanPath Data and Biosamples are accepted throughout the year. The requirements for the Expedited and Full Access Committee review processes are outlined below.
  </p>
  <p>
    Please note that timelines are contingent on the completeness of the application and the applicant’s responsiveness throughout
    the process.
  </p>

  <div class="row">
    <div class="col-12">
      <table class="table table-striped table-bordered">
        <thead>
        <tr>
          <th>&nbsp;</th>
          <th>Expedited Review</th>
          <th>Full Access Committee Review</th>
        </tr>
        </thead>
        <tbody>
        <tr>
          <td><strong>Request Type</strong></td>
          <td>Harmonized (Core) Datasets Only</td>
          <td>Requests for:
            <ul>
              <li>Non-Harmonized datasets</li>
              <li>Biosamples</li>
              <li>Linked administrative data</li>
            </ul>
          </td>
        </tr>
        <tr>
          <td><strong>Review Timeline</strong></td>
          <td>Accepted on a rolling basis. Reviews take a minimum of 3 weeks.</td>
          <td>Accepted on a rolling basis. Reviews take a minimum of 6 weeks.</td>
        </tr>
        </tbody>
      </table>

    </div>

    <div class="col-12">

      <p>* Please note that the review timeline refers to the approximate time you
        will be notified about the approval status of your project, and not to the time you will
        have access to the data.</p>

      <p>More information can be found in the <a href="#access_policies">CanPath Access Policy</a> section.</p>
    </div>
  </div>

  <p class="mt-3"><strong>Expedited COVID-19 Data Access</strong></p>

  <p>
    National harmonized data from the CanPath COVID-19 Questionnaire are now available to researchers. Given the immediate
    need for pandemic research, requests for access to the national COVID-19 Questionnaire dataset will be <strong>reviewed
      in as little as 9 business days</strong>. Please refer to the Expedited Review Criteria above for eligibility.
  </p>

  <h6><a id="access_criteria_requ" name="access_criteria_requ">Access Criteria &amp; Requirements</a></h6>
  <p>
    All access criteria and requirements are outlined in the <a href="/assets/files/Access_Policy_Approved_July_29_2020_final.pdf"
    target="_blank">CanPath Access Policy</a> document.
  </p>
  <h6><a id="access_cost" name="access_cost">Access Cost</a>
  </h6>
  <p>CanPath has a tiered pricing model suited to the different budgets of trainees, early-career
      researchers, and established researchers. Applicants are invited to complete a <a
        href="/assets/files/CanPath%20Request%20for%20LoS%20Form.docx">Cost
      Estimate Form</a> and submit to <a href="mailto:access@canpath.ca">access@canpath.ca</a>.
  </p>
  <h6><a id="access_committee" name="access_committee">Access Committee</a>
  </h6>
    <p>
      The Access Committee reviews and makes approval decisions on research applications submitted
      for CanPath Data and/or Biosamples. The committee is composed of independent members from
      across Canada who have expertise in such relevant fields as biostatistics, epidemiology, and
      genomics.
    </p>
    <p>
      The Access Committee meets formally 6 times per year to review projects requiring Full Access
      Committee Review.
    </p>

  <h5 class="mt-5 mb-3">Need Support?</h5>
  <div>All CanPath access questions can be directed to the Access Office.</div>
  <p>Email: <a href="mailto:access@canpath.ca">access@canpath.ca</a></p>

  <h5 class="mt-5 mb-3"><a id="access_policies" name="access_policies"></a>CanPath Policies &amp; Guidelines</h5>
  <p>We strongly recommend that you consult these prior to submitting an&nbsp;Access Application Form:</p>
  <ul>
    <li>
      <a href="/assets/files/Access_Policy_Approved_July_29_2020_final.pdf"
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