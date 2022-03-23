<!-- Data access process page macros -->

<!-- Data access process model template -->
<#macro dataAccessProcessModel>
  <p class="text-height-2">
    Les demandes d'accès et d’informations sur les ensembles de données de CanPath sont reçues par le <strong>bureau d'accès de CanPath</strong>.
    Les demandes limitées aux <a href="/harmonization-studies">données harmonisées (de base)</a>, incluant les données du questionnaire COVID-19,  sont admissibles à un examen d’accès accéléré. Toutes
    autres demandes, incluant, mais sans s’y limiter, aux <a href="/page/samples">échantillons biologiques</a> et au couplage avec des données
    administratives de santé nécessite un examen détaillé par le comité d’accès.
  </p>

  <div class="card card-info card-outline mt-5 mb-5">
    <div class="card-header">
      <h3 class="card-title">Processus de demande d'accès à CanPath
      </h3>
    </div>
    <div class="card-body">
      <div class="row">
        <div class="col-md-4">
          <h5><span class="subheading">ÉTAPE 1. <br/></span>Créer un compte d'utilisateur</h5>
          <p>
            Avant de commencer une demande d'accès, tous les chercheurs doivent créer un <strong>compte d'utilisateur sur le Portail de CanPath</strong>.
          </p>
          <p class="mb-3">
            <a class="btn btn-outline-primary" href="${contextPath}/signup"><@message "sign-up"/> <i class="fas fa-user-plus"></i></a>
          </p>
        </div>
        <div class="col-md-4">
          <h5><span class="subheading">ÉTAPE 2. <br/></span>Compléter et soumettre votre formulaire de demande d'accès</h5>
          <p>
            Les chercheurs sont encouragés à <strong>consulter la fiche-conseil de la demande et communiquer avec le bureau d'accès</strong> pour comprendre les exigences
            impliquées avant d'envoyer une demande.
          </p>
          <p>
            <a href="${contextPath}/contact" class="btn btn-outline-primary"><@message "contact-menu"/> <i class="fas fa-info-circle"></i></a>

            <a href="${contextPath}/assets/files/CanPath_Data_and_Biosamples_Access_Application_Tip_Sheet_FINAL_2021-10-29-FR.pdf" target="_blank" class="btn btn-outline-primary"><@message "application-tips-button"/></a>
          </p>
          <p>
            Lorsque les chercheurs sont prêts à remplir et à envoyer une demande d'accès, ils doivent remplir et soumettre un
            formulaire de demande d'accès en ligne et joindre tous les documents d'accès à CanPath requis en se connectant
            à leur compte d'utilisateur de CanPath et en créant une <strong><@message "new-data-access-request"/></strong>.
          </p>
          <p class="mb-3">
            <a href="${contextPath}/data-accesses" class="btn btn-outline-primary"><@message "data-access"/> <i class="fas fa-arrow-circle-right"></i></a>
          </p>
        </div>
        <div class="col-md-4">
          <h5><span class="subheading">ÉTAPE 3. <br/></span>Suivre votre demande</h5>
          <p>
            Les chercheurs seront en mesure de suivre les progrès et l'historique de leur demande d'accès en ligne en se
            connectant à leur compte d'utilisateur du portail de CanPath et en consultant <strong><@message "my-data-access-requests"/></strong>.
          </p>
          <p>
            <a href="${contextPath}/data-accesses" class="btn btn-outline-primary"><@message "data-access"/> <i class="fas fa-arrow-circle-right"></i></a>
          </p>
        </div>
      </div>
    </div>
  </div>

  <h5 class="mt-5 mb-3"><a id="required" name="required"></a> Documentation requise pour l’accès à CanPath</h5>
  <p>Toutes les demandes d'accès doivent inclure les éléments suivants :</p>
  <ul>
    <li><p>Formulaire de demande d'accès rempli</p></li>
    <li>
      <p>
        Protocole de recherche détaillé contenant une question / objectif de recherche spécifique (ayant reçu l'approbation éthique)
      </p>
      <ul>
        <li>
          <p>Le protocole doit inclure la justification des variables demandées, une analyse statistique, etc.</p>
        </li>
      </ul>
    </li>
    <li><p>Preuve de l'examen scientifique ou de l'examen par les pairs du protocole de recherche, tel qu'un examen par une agence de financement, le cas échéant</p></li>
    <li><p>Lettre d'approbation d'un comité d'éthique de la recherche pour le protocole de recherche soumis</p></li>
    <li><p>Preuve de financement, le cas échéant</p></li>
    <li><p>CV de deux pages du demandeur principal</p></li>
  </ul>

  <h5 class="mt-5 mb-3">
    <a id="submission_process" name="submission_process"></a> Soumettez une de demande d'accès
  </h5>
  <p style="text-align:center;"><img alt="" src="/assets/images/submission_process_fr.png" style="width: 750px; height: 498px;"></p>

  <h6><a id="review_process" name="review_process">Processus d'examen CanPath</a></h6>

  <p>
    Les demandes d’accès aux données et aux échantillons biologiques de CanPath sont acceptées et examinées tout au long de l’année. Les exigences d’examen accéléré et examen détaillé par le comité d’accès sont décrites ci-dessous.
  </p>
  <p>
    Le délai dépend de la rapidité de réponse du demandeur tout au long du processus.
  </p>

  <div class="row">
    <div class="col-12">
      <table class="table table-striped table-bordered">
        <thead>
        <tr>
          <th>&nbsp;</th>
          <th>Examen accéléré</th>
          <th>Examen détaillé par le Comité d’accès</th>
        </tr>
        </thead>
        <tbody>
        <tr>
          <td><strong>Type de demande</strong></td>
          <td>Ensembles de données harmonisées (de base) seulement</td>
          <td>Demandes pour :
            <ul class="mb-0">
              <li>Ensembles de données non harmonisées</li>
              <li>Échantillons biologiques</li>
              <li>Données administratives couplées</li>
            </ul>
          </td>
        </tr>
        <tr>
          <td><strong>Chronologie de l’examen</strong></td>
          <td>Acceptées sur une base continue. Examen dans un délai d’environ trois semaines</td>
          <td>Acceptées sur une base continue. Examen dans un délai d’environ six semaines</td>
        </tr>
        </tbody>
      </table>

    </div>
    <div class="col-12">
      <p>
        * Veuillez noter que le délai d'examen signifie la date approximative à laquelle vous
        serez informé/e de l’état d’approbation de votre projet, et non la date à laquelle vous aurez accès aux données.
      </p>

      <p>Plus d'informations peuvent être trouvées dans la section <a href="#access_policies">Politique d'accès de CanPath</a>.</p>
    </div>
  </div>

  <p class="mt-3"><strong>Accès aux données COVID-19 accéléré</strong></p>

  <p>
    Les données nationales harmonisées du Questionnaire sur la COVID-19 de CanPath sont maintenant disponsibles aux chercheurs.
    Étant donné le besoin immédiat de faire des recherches sur la pandémie, les demandes d’accès à l’ensemble de données
    nationales du Questionnaire sur la COVID-19 seront <strong>examinées en aussi peu que neuf jours ouvrables</strong>.
    Veuillez vous référer aux critères de examen accélérée ci-dessous pour l'éligibilité.
  </p>

  <h6><a id="access_criteria_requ" name="access_criteria_requ">Critères et exigences d’accès</a></h6>
  <p>
    Tous les critères et exigences d'accès sont décrits dans le document sur
     <a href="/assets/files/Access_Policy_v2.0_Approved_16Mar2022.pdf" target="_blank">la Politique d'accès de CanPath</a>.
  </p>
  <h6><a id="access_cost" name="access_cost">Coût d’accès</a>
  </h6>
  <p>
    CanPath a un modèle de tarification à plusieurs niveaux adapté aux différents budgets des stagiaires, des chercheurs en
    début de carrière et des chercheurs établis. Les candidats sont invités à remplir un <a
            href="/assets/files/CanPath%20Request%20for%20LoS%20Form.docx">formulaire d’estimation des coûts</a> et
    à le soumettre via <a href="mailto:access@canpath.ca">access@canpath.ca</a>.
  </p>
  <h6><a id="access_committee" name="access_committee">Comité d’accès</a>
  </h6>
    <p>
      Le comité d’accès examine et prend les décisions relatives à l’approbation des demandes des projets de recherche visant
      à obtenir l’accès à des données et / ou à des échantillons biologiques de CanPath. Le comité est composé de membres
      indépendants au Canada possédant une expertise dans des domaines pertinents comme la biostatistique, l’épidémiologie
      et la génomique. Le comité d’accès se réunit formellement 6 fois par an.
    </p>

  <h5 class="mt-5 mb-3">Besoin d’aide?</h5>
  <div>Toute question sur l’accès à CanPath peut être adressée au bureau d'accès.</div>
  <p>Courriel : <a href="mailto:access@canpath.ca">access@canpath.ca</a></p>

  <h5 class="mt-5 mb-3"><a id="access_policies" name="access_policies"></a>Politiques &amp; lignes directrices de CanPath</h5>
  <p>Avant de soumettre un formulaire de demande d'accès, nous vous recommandons fortement de consulter les documents suivants (disponibles en anglais seulement) :</p>
  <ul>
    <li>
      <a href="/assets/files/Access_Policy_v2.0_Approved_16Mar2022.pdf"
         target="_blank">Politique d'accès de CanPath</a></li>
    <li>
      <a href="/assets/files/CanPath%20Publications%20Policy_Approved%202020-Sep-23.pdf"
         target="_blank">Politique des publications</a></li>
    <li>
      <a href="/assets/files/CanPath%20Intellectual%20Property%20Policy_v1.1_2020-07-22.pdf"
         target="_blank">Politique de propriété intellectuelle</a></li>
    <li>
      <a href="/assets/files/CanPath%20Guidelines%20For%20Biosample%20Access_June2020.pdf"
         target="_blank">Lignes directrices pour l’accès aux échantillons biologiques</a></li>
    <li>
      <a href="/assets/files/CanPath%20Biosample%20Feasiblity%20Review_June2020.pdf"
         target="_blank">Revue de la faisabilité pour les échantillons biologiques</a></li>
    <li>
      <a href="/assets/files/CanPath%20Industry%20Research%20Policy_v1.0_2021-07-28-Fr.pdf"
         target="_blank">Politique de recherche industrielle</a></li>
  </ul>

</#macro>