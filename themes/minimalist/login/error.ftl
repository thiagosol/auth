<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
  <div class="row">
    <div class="col-sm-12 col-md-4 offset-md-4">
      <#if section = "header">
        ${msg("errorTitle")}
      <#elseif section = "form">
        <div id="kc-error-message">
          <p class="instruction">${message.summary?no_esc}</p>
          <#if client?? && client.baseUrl?has_content>
            <p><a id="backToApplication" href="${client.baseUrl}">${kcSanitize(msg("backToApplication"))?no_esc}</a></p>
          </#if>
        </div>
      </#if>
    </div>
  </div>
</@layout.registrationLayout>
