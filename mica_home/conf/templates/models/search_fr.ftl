<#include "../libs/search.ftl">

<#macro searchInfo>
  <div id="search-info" class="alert alert-info bg-callout alert-dismissible mb-4 fade show" style="display: none">
    <div>
      <p>
        Pour consulter des données filtrées selon plusieurs variables, veuillez <a href="/contact">contacter le Bureau d'accès</a> pour obtenir de l'aide.
      </p>
      <div>
        Débuter la recherche en sélectionnant un attribut.
        <#if !user??>
          Pour enregistrer vos résultats de recherche, veuillez vous <a href="/signin?redirect=/search">connecter</a> ou vous <a href="signup">enregistrer</a>.
        </#if>
      </div>
    </div>
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
      <span aria-hidden="true">&times;</span>
    </button>
  </div>
</#macro>
