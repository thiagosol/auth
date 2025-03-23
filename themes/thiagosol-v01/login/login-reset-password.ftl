<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${msg("emailForgotTitle")}</title>
    <link rel="stylesheet" href="${url.resourcesPath}/css/style.css">
</head>
<body>
    <div class="login-container">
        <h1 id="service-title">${msg("emailForgotTitle")}</h1>
        <#if message?has_content>
            <div class="${message.type}-message">
                <p>${message.summary}</p>
            </div>
        </#if>
        <form id="kc-reset-password-form" action="${url.loginAction}" method="post">
            <input type="text" id="username" name="username" placeholder="<#if !realm.loginWithEmailAllowed>${msg('username')}<#elseif !realm.registrationEmailAsUsername>${msg('usernameOrEmail')}<#else>${msg('email')}</#if>" 
                autofocus
                <#if messagesPerField.existsError('username')>aria-invalid="true"</#if>
            />
            <#if messagesPerField.existsError('username')>
                <span class="error-message" aria-live="polite">
                    ${kcSanitize(messagesPerField.get('username'))?no_esc}
                </span>
            </#if>
            <button type="submit">${msg("doSubmit")}</button>
        </form>
        <div class="links-container">
            <a href="${url.loginUrl}" class="link" id="login-link">${kcSanitize(msg("backToLogin"))}</a>
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

        const loginLink = document.getElementById("login-link");
        if (loginLink) {
            loginLink.href = loginLink.href + "&theme=" + theme;
        }

        const form = document.querySelector('form');
        if (form) {
            form.action = form.action + "&theme=" + theme;
            
            const themeInput = document.createElement('input');
            themeInput.type = 'hidden';
            themeInput.name = 'theme';
            themeInput.value = theme;
            form.appendChild(themeInput);
        }
    </script>
</body>
</html> 