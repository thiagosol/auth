<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true displayMessage=!messagesPerField.existsError('username'); section>
  <div class="row">
    <div class="col-sm-12 col-md-4 offset-md-4">
      <#if section = "header">
        <h5>${msg("emailForgotTitle")}</h5>
      <#elseif section = "form">
        <form id="kc-reset-password-form" class="${properties.kcFormClass!}" action="${url.loginAction}" method="post">
          <div class="${properties.kcFormGroupClass!}">
            <div class="${properties.kcLabelWrapperClass!}">
              <label for="username" class="${properties.kcLabelClass!} form-label">
                <#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}
                </#if>
              </label>
            </div>
            <div class="${properties.kcInputWrapperClass!}">
              <input type="text" id="username" name="username" class="${properties.kcInputClass!} form-control" autofocus="autofocus" value="${(auth.attemptedUsername!'')}" aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"/>
              <#if messagesPerField.existsError('username')>
                <span id="input-error-username" class="${properties.kcInputErrorMessageClass!} input-error" aria-live="polite">
                  ${kcSanitize(messagesPerField.get('username'))?no_esc}
                </span>
              </#if>
            </div>
          </div>
          <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
            <div id="kc-form-options" class="${properties.kcFormOptionsClass!}">
              <div class="${properties.kcFormOptionsWrapperClass!} cs-back-to-login">
                <span>
                  <a href="${url.loginUrl}">${kcSanitize(msg("backToLogin"))?no_esc}</a>
                </span>
              </div>
            </div>

            <div id="kc-form-buttons" class="${properties.kcFormButtonsClass!}">
               <input class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} btn btn-primary col-12" type="submit" value="${msg("doSubmit")}"/>
            </div>
          </div>
        </form>
      <#elseif section = "info">
        <#if realm.duplicateEmailsAllowed>
          <p class="cs-email-instruction">${msg("emailInstructionUsername")}</p>
        <#else>
          <p class="cs-email-instruction">${msg("emailInstruction")}</p>
        </#if>
      </#if>
    </div>
  </div>
</@layout.registrationLayout>
