<!-- Custom CSS rules -->
<link rel="stylesheet" href="/assets/css/custom.css"/>
<link rel="stylesheet" href="/assets/css/mica-custom.css"/>

<#macro messageArgs code args>
    <@spring.messageArgsText code args code/>
</#macro>

<#function arrayNotEmpty array=[]>
    <#assign notEmpty = true>
    <#if array?? && array?size gt 0>
        <#list array as element>
            <#assign notEmpty = notEmpty && element?? && element?has_content>
        </#list>
    <#else>
        <#return false>
    </#if>
    <#return notEmpty>
</#function>

<#function localizedStringNotEmpty txt={}>
    <#assign notEmpty = true>
    <#if txt?? && txt?keys??>
        <#assign notEmpty = txt[.lang]?? && txt[.lang]?has_content && txt[.lang]?trim?has_content>
    <#else>
        <#return false>
    </#if>
    <#return notEmpty>
</#function>
