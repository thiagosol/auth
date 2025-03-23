<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username') displayInfo=(realm.password && realm.registrationAllowed && !registrationDisabled??); section>
    <#if section = "header">
        ${msg("loginAccountTitle")}
    <#elseif section = "form">
        <div id="kc-form">
            <div id="kc-form-wrapper">
                <#if realm.password>
                    <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}"
                          method="post">
                        <#if !usernameHidden??>
                            <div class="${properties.kcFormGroupClass!}">

                                <input tabindex="1" id="username"
                                       aria-invalid="<#if messagesPerField.existsError('username')>true</#if>"
                                       class="${properties.kcInputClass!}" name="username"
                                       value="${(login.username!'')}"
                                       type="text" autofocus autocomplete="username"
                                       placeholder="Username"
                                       dir="ltr"/>

                                <#if messagesPerField.existsError('username')>
                                    <span id="input-error-username" class="${properties.kcInputErrorMessageClass!}" aria-live="polite">
                                        ${kcSanitize(messagesPerField.get('username'))?no_esc}
                                    </span>
                                </#if>
                            </div>
                        </#if>

                        <div class="${properties.kcFormGroupClass!} ${properties.kcFormSettingClass!}">
                            <div id="kc-form-options">
                                <#if realm.rememberMe && !usernameHidden??>
                                    <br>
                                    <div class="checkbox">
                                        <label>
                                            <#if login.rememberMe??>
                                                <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox"
                                                       checked> ${msg("rememberMe")}
                                            <#else>
                                                <input tabindex="3" id="rememberMe" name="rememberMe"
                                                       type="checkbox"> ${msg("rememberMe")}
                                            </#if>
                                        </label>
                                    </div>
                                </#if>
                            </div>
                        </div>

                        <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
                            <input tabindex="4"
                                   class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}"
                                   name="login" id="kc-login" type="submit" value="Continue"/> <!-- ${msg("doLogIn")} -->
                        </div>
                    </form>
                </#if>
            </div>
        </div>

    <#elseif section = "info" >
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div id="kc-registration">
                <span>${msg("noAccount")} <a tabindex="6" href="${url.registrationUrl}">${msg("doRegister")}</a></span>
            </div>
        </#if>

        <#elseif section = "socialProviders" >
        <#if realm.password && social?? && social.providers?has_content>
            <div id="kc-social-providers" class="container${properties.kcFormSocialAccountSectionClass!}">

                <#list social.providers as p>
                     <a id="social-${p.alias}" class="btn ${properties.kcFormSocialAccountListButtonClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountGridItem!}</#if>"
                                    type="button" href="${p.loginUrl}">
                                <span>Log In with </span>
                                <#if p.iconClasses?has_content>
                                    <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                                    <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">${p.displayName!}</span>
                                <#else>
                                    <span class="${properties.kcFormSocialAccountNameClass!}">G Suite</span>
                                </#if>
                            </a>
                </#list>
            </div>
        </#if>
    </#if>

</@layout.registrationLayout>
