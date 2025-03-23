<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section= "form">
      <div id="kc-form container">
        <div id="kc-form-wrapper row">
          <div class="col-sm-12 col-md-4 offset-md-4 cs-forms">
            <h5 class="cs-title">${msg("loginAccountTitle")}</h5>

            <#if realm.password>
              <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                <div class="${properties.kcFormGroupClass!}">
                  <div class="mb-3">
                    <label for="username" class="${properties.kcLabelClass!} form-label">
                      <#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}
                      </#if>
                    </label>

                    <#if usernameEditDisabled??>
                      <input tabindex="1" id="username" class="${properties.kcInputClass!} form-control <#if messagesPerField.existsError('username','password')>is-invalid</#if>" name="username" value="${(login.username!'')}" type="text" disabled="disabled"/>
                    <#else>
                      <input tabindex="1" id="username" class="${properties.kcInputClass!} form-control <#if messagesPerField.existsError('username','password')>is-invalid</#if>" name="username" value="${(login.username!'')}" type="text" autofocus="autofocus" autocomplete="off" aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"/>

                      <#if messagesPerField.existsError('username','password')>
                        <span id="input-error" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                          ${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
                        </span>
                      </#if>
                    </#if>
                  </div>
                </div>

                <div class="${properties.kcFormGroupClass!}">
                  <div class="mb-3">
                    <label for="password" class="${properties.kcLabelClass!} form-label">${msg("password")}</label>

                    <input tabindex="2" id="password" class="${properties.kcInputClass!} form-control <#if messagesPerField.existsError('username','password')>is-invalid</#if>" name="password" type="password" autocomplete="off" aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"/>
                  </div>
                </div>

                <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                  <div id="kc-form-options">
                    <#if realm.rememberMe&&!usernameEditDisabled??>
                      <#if login.rememberMe??>
                        <div class="form-check">
                          <input class="form-check-input" tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" checked="checked">
                            <label class="form-check-label" for="rememberMe">
                              ${msg("rememberMe")}
                            </label>
                          </div>
                          <#--  <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" checked> ${msg("rememberMe")}  -->
                        <#else>
                          <div class="form-check">
                            <input class="form-check-input" tabindex="3" id="rememberMe" name="rememberMe" type="checkbox">
                              <label class="form-check-label" for="rememberMe">
                                ${msg("rememberMe")}
                              </label>
                            </div>
                            <#--  <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox"> <label>${msg("rememberMe")}</label>  -->
                          </#if>
                        </#if>
                        <div class="${properties.kcFormOptionsWrapperClass!}">
                          <#if realm.resetPasswordAllowed>
                            <span>
                              <a tabindex="5" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a>
                            </span>
                          </#if>
                        </div>
                      </div>

                      <div id="kc-form-buttons" class="${properties.kcFormGroupClass!} d-grid gap-2">
                        <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                        <input tabindex="4" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!} btn btn-primary" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
                        </div>
                      </div>
                    </form>
                  </#if>
                </div>

                <#if realm.password && social.providers??>
                  <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!} row">
                    <div class="col-sm-12 col-md-4 offset-md-4 cs-forms">
                      <hr/>
                      <h5 class="cs-idp-title">${msg("identity-provider-login-label")}</h5>

                      <ul class="${properties.kcFormSocialAccountListClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountListGridClass!}</#if> cs-idp-list">
                        <#list social.providers as p>
                          <a id="social-${p.alias}" class="${properties.kcFormSocialAccountListButtonClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountGridItem!}</#if> btn btn-outline-secondary col-12" type="button" href="${p.loginUrl}">
                            <#if p.iconClasses?has_content>
                              <span class="btn-label">
                                <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!} fa fa-${p.alias}" aria-hidden="true"></i>
                              </span>
                              <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">${p.displayName!}</span>
                            <#else>
                              <span class="btn-label">
                                <i class="fa fa-${p.alias}" aria-hidden="true"></i>
                              </span>
                              <span class="${properties.kcFormSocialAccountNameClass!}">${p.displayName!}</span>
                            </#if>
                          </a>
                        </#list>
                      </ul>
                    </div>
                  </div>
                </#if>
              </div>
            </div>
          <#elseif section="info">
            <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
              <div id="kc-registration-container">
                <div id="kc-registration">
                  <span>${msg("noAccount")}
                    <a tabindex="6" href="${url.registrationUrl}">${msg("doRegister")}</a>
                  </span>
                </div>
              </div>
            </#if>
          </#if>
        </@layout.registrationLayout>
