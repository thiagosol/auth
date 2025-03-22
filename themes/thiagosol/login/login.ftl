<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="${url.resourcesPath}/css/style.css">
</head>
<body>
    <div class="login-container">
        <h1 id="service-title">Entrar</h1>
        <div class="error-message">
            <#if message?has_content>
                <p>${message.summary}</p>
            </#if>
        </div>
        <form action="${url.loginAction}" method="post">
            <input type="text" name="username" placeholder="Email ou usuário" autofocus required>
            <input type="password" name="password" placeholder="Senha" required>
            <input type="hidden" name="credentialId" value="${auth.credentialId!}">
            <#if realm.rememberMe>
            <div class="remember-me">
                <label class="checkbox-container">
                    <input type="checkbox" name="rememberMe" <#if auth.rememberMe??>checked</#if>>
                    <span class="checkbox-label">Lembrar-me</span>
                </label>
            </div>
            </#if>
            <button type="submit">Entrar</button>
        </form>
        <div class="links-container">
            <#if realm.registrationAllowed>
            <a href="${url.registrationUrl}" class="link" id="register-link">Criar conta</a>
            </#if>

            <#if realm.resetPasswordAllowed>
            <a href="${url.loginResetCredentialsUrl}" class="link" id="reset-link">Esqueci a senha</a>
            </#if>
        </div>
    </div>
    <script>
        const params = new URLSearchParams(window.location.search);
        const serviceName = params.get("serviceName");
        const theme = params.get("theme") || "light";

        document.body.setAttribute("data-theme", theme);

        if (serviceName) {
            document.getElementById("service-title").innerText = serviceName;
        }

        const registerLink = document.getElementById("register-link");
        const resetLink = document.getElementById("reset-link");

        if (registerLink) {
            registerLink.href = registerLink.href + "&theme=" + theme + "&serviceName=" + serviceName;
        }

        if (resetLink) {
            resetLink.href = resetLink.href + "&theme=" + theme + "&serviceName=" + serviceName;
        }

        // Adiciona os parâmetros na action do form
        const form = document.querySelector('form');
        if (form) {
            form.action = form.action + "&theme=" + theme + "&serviceName=" + serviceName;
        }
    </script>
</body>
</html>
