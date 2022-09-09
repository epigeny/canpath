<!-- Data access process page macros -->

<!-- Data access process model template -->
<#macro dataAccessProcessModel>
  <p class="text-height-2">
    Les demandes d'accès et d'informations sur les ensembles de données de CanPath sont reçues par le <strong>bureau d'accès de CanPath</strong>.
    Les demandes limitées aux <a href="/harmonization-studies">données harmonisées (de base)</a>, incluant les données du questionnaire COVID-19,  sont admissibles à un examen d'accès accéléré. Toutes
    autres demandes, incluant, mais sans s'y limiter, aux <a href="/page/samples">échantillons biologiques</a> et au couplage avec des données
    administratives de santé nécessite un examen détaillé par le comité d'accès.
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

  <h5 class="mt-5 mb-3"><a id="required" name="required"></a> Documentation requise pour l'accès à CanPath</h5>
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
  <p style="text-align:center;"><img alt="" src="/assets/images/CanPathPortalReviewInfographic.webp" style="width: 75%;"></p>

  <div class="card card-info card-outline mt-5 mb-5 p-0">
    <div class="accordion" id="accessProcessAccordion">
      <div class="card mb-0">
        <div class="card-header">
          <button type="button" class="btn btn-link btn-block text-navy text-left" data-toggle="collapse" data-target="#collapseOne">Critères &amp; exigences d'accès</button>
        </div>
        <div id="collapseOne" class="collapse" data-parent="#accessProcessAccordion">
          <div class="card-body">
            <p>
              ous les formulaires de demande d'accès remplis et soumis et la documentation connexe sont examinés par le comité d'accès indépendant selon les critères suivants :
            </p>

            <ul>
              <li>Le demandeur est un chercheur de bonne foi (c.-à-d. la preuve qu'il possède une expérience et des qualifications pertinentes);</li>
              <li>Le projet de recherche est conforme aux principes directeurs de CanPath et aux consentements éclairés signés par les participants à la recherche (voir les sections 2 et 4a de la <a href="#access_policies">Politique d'accès de CanPath</a>);</li>
              <li>Le Bureau d'accès a fourni la preuve de l'exhaustivité administrative et de la disponibilité des données CanPath et/ou des échantillons biologiques</li>
            </ul>

            <p>L'évaluation d'Access Office a établi que la demande répond aux exigences suivantes :</p>

            <ul>
              <li>L'étude de recherche a été jugée scientifiquement solide;</li>
              <li>L'existence de ressources adéquates pour mener à bien le projet de recherche a été établie (p. ex.le financement, les collaborateurs et le personnel);</li>
              <li>Une justification suffisante de la nécessité des données CanPath et/ou des échantillons biologiques demandés a été fournie;</li>
              <li>
                <span>
                  La fourniture des échantillons biologiques demandés est justifiée en fonction de l'évaluation de la valeur des données renvoyées, de la contribution scientifique du projet de recherche, de l'impact potentiel de la fourniture des échantillons sur les besoins futurs en échantillons biologiques et du risque d'épuisement des échantillons.
                </span>
                <span class="d-inline-block mt-3">
                  Tous les participants à CanPath ont rempli un questionnaire détaillé au moment du recrutement (baseline) et continuent de fournir des informations actualisées sur la santé et le mode de vie par le biais de questionnaires de suivi.
                </span>
              </li>
            </ul>
          </div>
        </div>
      </div>
      <div class="card mb-0">
        <div class="card-header">
          <button type="button" class="btn btn-link btn-block  text-navy text-left" data-toggle="collapse" data-target="#collapseTwo">Ensembles de données harmonisés</button>
        </div>
        <div id="collapseTwo" class="collapse" data-parent="#accessProcessAccordion">
          <div class="card-body">
            <p>
              Les ensembles de données harmonisés à l'échelle nationale comprennent les données recueillies par les cinq cohortes matures : BC Generations Project, Alberta's Tomorrow Project, Ontario Health Study, CARTaGENE et Atlantic PATH. Les données du Manitoba Tomorrow Project seront disponibles une fois le recrutement des participants terminé.
            </p>

            <p>
              Les ensembles de données harmonisés disponibles incluent :
            </p>

            <ul>
              <li>Questionnaire de base sur la santé et les facteurs de risque</li>
              <li>Questionnaire de base sur la santé et les facteurs de risque avec des maladies supplémentaires</li>
              <li>Questionnaire de base sur la santé mentale</li>
              <li>Mesures physiques de base</li>
              <li>Questionnaire de suivi sur la santé et les facteurs de risque</li>
              <li>Données pré-analytiques liées aux échantillons biologiques</li>
              <li>Données de génotypage</li>
              <li>Données CANUE sur l'exposition environnementale</li>
              <li>Questionnaire COVID-19 &mdash; Maintenant disponible</li>
            </ul>
          </div>
        </div>
      </div>
      <div class="card mb-0">
        <div class="card-header">
          <button type="button" class="btn btn-link btn-block  text-navy text-left" data-toggle="collapse" data-target="#collapseThree">Le comité d'accès</button>
        </div>
        <div id="collapseThree" class="collapse" data-parent="#accessProcessAccordion">
          <div class="card-body">
            <p>
              Le comité d'accès examine et prend des décisions d'approbation sur les demandes de recherche soumises pour les données CanPath et/ou les échantillons biologiques. Le comité est composé de membres indépendants de partout au Canada qui possèdent une expertise dans des domaines pertinents comme la biostatistique, l'épidémiologie et la génomique. Le comité d'accès se réunit tous les deux mois pour examiner les projets nécessitant un examen complet du comité d'accès.
            </p>
          </div>
        </div>
      </div>
      <div class="card mb-0">
        <div class="card-header">
          <button type="button" class="btn btn-link btn-block text-navy text-left" data-toggle="collapse" data-target="#collapseFour">Critères d'examen accéléré</button>
        </div>
        <div id="collapseFour" class="collapse" data-parent="#accessProcessAccordion">
          <div class="card-body">
            <p>
              Les demandes d'accès répondant aux critères d'un examen accéléré sont acceptées sur une base continue et seront traitées dans un délai d'environ 3 semaines. (Ce délai dépend de la réactivité du demandeur tout au long du processus).            
            </p>

            <p>
              Comme indiqué dans la <a href="#access_policies">Politique d'accès CanPath</a>, les critères suivants sont utilisés pour déterminer si les candidatures sont éligibles à un examen accéléré :
            </p>

            <ul>
              <li>Demander des ensembles de données harmonisés :</li>
              <li>Faible risque de réputation en fonction de la question de recherche abordée et de son mérite scientifique;</li>
              <li>Le projet a été évalué dans le cadre d'un examen scientifique reconnu ou d'un processus d'examen par les pairs;</li>
              <li>Il existe des preuves d'un soutien financier pour le projet; et</li>
              <li>L'équipe de recherche compte suffisamment de membres et d'expertise pour effectuer les analyses.</li>
            </ul>

            <p>
              <strong>Remarque : </strong>À l'exception des deux premiers points, les candidatures n'ont pas besoin de répondre à tous ces critères pour être prises en compte pour l'examen accéléré.
            </p>
          </div>
        </div>
      </div>
      <div class="card mb-0">
        <div class="card-header">
          <button type="button" class="btn btn-link btn-block text-navy text-left" data-toggle="collapse" data-target="#collapseFive">Critères d'évaluation de l'accès complet</button>
        </div>
        <div id="collapseFive" class="collapse" data-parent="#accessProcessAccordion">
          <div class="card-body">
            <p>
              Comme indiqué dans la <a href="#access_policies">politique d'accès de CanPath</a>, les demandes d'accès répondant à <strong>l'un des critères suivants</strong> nécessiteront un examen complet du comité d'accès :
            </p>

            <ul>
              <li>Les demandes de données <strong>autres</strong> que les ensembles de données répertoriés comme "<a href="/harmonization-studies">Données harmonisées</a>";</li>
              <li>L'accès aux échantillons biologiques est demandé;</li>
              <li>La question de recherche aborde une question de recherche potentiellement controversée (par exemple, compare les résultats par origine ethnique ou communauté, impact potentiellement négatif sur des sous-ensembles de participants) ou avec un risque élevé de réidentification; ou</li>
              <li>La demande comprend un lien avec les données administratives sur la santé.</li>
            </ul>

            <p>
              Les demandes d'accès nécessitant un examen complet du comité d'accès sont acceptées sur une base continue et peuvent être complétées en aussi peu que 6 semaines. (Ce délai dépend de la réactivité du demandeur tout au long du processus.)
            </p>
          </div>
        </div>
      </div>
      <div class="card mb-0">
        <div class="card-header">
          <button type="button" class="btn btn-link btn-block text-navy text-left" data-toggle="collapse" data-target="#collapseSix">Accès accéléré aux données COVID-19</button>
        </div>
        <div id="collapseSix" class="collapse" data-parent="#accessProcessAccordion">
          <div class="card-body">
            <p>
              Les données nationales harmonisées du questionnaire CanPath sur la COVID-19 sont maintenant à la disposition des chercheurs. Compte tenu du besoin immédiat de recherche sur la pandémie, CanPath a révisé son processus d'examen accéléré pour fournir aux chercheurs un accès rapide aux données sur la COVID-19. Les demandes d'accès à l'ensemble de données du questionnaire national sur la COVID-19 seront <strong>examinées sous 9 jours ouvrés seulement</strong>. Veuillez vous référer aux critères d'examen accéléré pour l'éligibilité.
            </p>
          </div>
        </div>
      </div>
      <div class="card mb-0">
        <div class="card-header">
          <button type="button" class="btn btn-link btn-block text-navy text-left" data-toggle="collapse" data-target="#collapseSeven">Coût d'accès</button>
        </div>
        <div id="collapseSeven" class="collapse" data-parent="#accessProcessAccordion">
          <div class="card-body">
            <p>
              CanPath a un modèle de tarification à plusieurs niveaux adapté aux différents budgets des stagiaires, des chercheurs en début de carrière et des chercheurs établis. Les candidats sont invités à remplir un <a href="/assets/files/CanPath%20Request%20for%20LoS%20Form.docx">formulaire d'estimation des coûts</a> et à le soumettre par e-mail à <a href="mailto:access@canpath.ca">access@canpath.ca</a>.
            </p>
          </div>
        </div>
      </div>
    </div>
  </div>

  <h5 class="mt-5 mb-3">Besoin d'aide?</h5>
  <div>Toute question sur l'accès à CanPath peut être adressée au bureau d'accès.</div>
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
         target="_blank">Lignes directrices pour l'accès aux échantillons biologiques</a></li>
    <li>
      <a href="/assets/files/CanPath%20Biosample%20Feasiblity%20Review_June2020.pdf"
         target="_blank">Revue de la faisabilité pour les échantillons biologiques</a></li>
    <li>
      <a href="/assets/files/CanPath%20Industry%20Research%20Policy_v1.0_2021-07-28-Fr.pdf"
         target="_blank">Politique de recherche industrielle</a></li>
  </ul>

</#macro>