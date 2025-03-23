<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${msg("loginTitle")}</title>
    <link rel="stylesheet" href="${url.resourcesPath}/css/style.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="login-container">
        <h1 id="service-title">${msg("loginTitle")}</h1>
        <#if message?has_content>
            <div class="${message.type}-message">
                <p>${message.summary}</p>
            </div>
        </#if>

        <#if realm.password>
            <form action="${url.loginAction}" method="post">
                <div class="form-group">
                    <input type="text" 
                           name="username" 
                           placeholder="<#if !realm.loginWithEmailAllowed>${msg('username')}<#elseif !realm.registrationEmailAsUsername>${msg('usernameOrEmail')}<#else>${msg('email')}</#if>"
                           autofocus 
                           required>
                </div>
                <div class="form-group">
                    <div class="password-container">
                        <input type="password" 
                               name="password" 
                               placeholder="${msg('password')}"
                               required>
                        <button type="button" class="toggle-password" onclick="togglePassword(this)">
                            <span class="material-icons">visibility</span>
                        </button>
                    </div>
                </div>
                <input type="hidden" name="credentialId" value="${auth.credentialId!}">
                <#if realm.rememberMe>
                <div class="remember-me">
                    <label class="checkbox-container">
                        <input type="checkbox" name="rememberMe" <#if auth.rememberMe??>checked</#if>>
                        <span class="checkbox-label">${msg("rememberMe")}</span>
                    </label>
                </div>
                </#if>
                <button type="submit">${msg("doLogIn")}</button>
            </form>
        </#if>

        <#if social.providers??>
            <div class="social-providers">
                <div class="separator">
                    <span>${msg("identity-provider-login-label")}</span>
                </div>
                <div class="providers-list">
                    <#list social.providers as p>
                        <a href="${p.loginUrl}" class="social-button ${p.alias}">
                            <i class="fab fa-${p.alias}"></i>
                            <span>${p.displayName!}</span>
                        </a>
                    </#list>
                </div>
            </div>
        </#if>

        <div class="links-container">
            <#if realm.registrationAllowed>
                <a href="${url.registrationUrl}" class="link">${msg("doRegister")}</a>
            </#if>
            <#if realm.resetPasswordAllowed>
                <a href="${url.loginResetCredentialsUrl}" class="link">${msg("doForgotPassword")}</a>
            </#if>
        </div>
    </div>
    <script>
        const params = new URLSearchParams(window.location.search);
        let theme = params.get("theme");

        if (theme) {
            localStorage.setItem('kc_theme', theme);
        } else {
            theme = localStorage.getItem('kc_theme');
        }

        theme = theme || "light";
        document.body.setAttribute("data-theme", theme);

        const form = document.querySelector('form');
        if (form) {
            form.action = form.action + "&theme=" + theme;
        }

        document.querySelectorAll('a[href]').forEach(link => {
            if (link.href.includes(window.location.origin)) {
                link.href = link.href + (link.href.includes('?') ? '&' : '?') + "theme=" + theme;
            }
        });

        function togglePassword(button) {
            const input = button.previousElementSibling;
            const icon = button.querySelector('.material-icons');
            if (input.type === "password") {
                input.type = "text";
                icon.textContent = "visibility_off";
            } else {
                input.type = "password";
                icon.textContent = "visibility";
            }
        }
    </script>
</body>
</html>
