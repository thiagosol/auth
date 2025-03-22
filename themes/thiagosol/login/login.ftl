<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="login-container">
        <h1 id="service-title">Entrar</h1>
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
            <a href="${url.registrationUrl}" class="link">Criar conta</a>
            </#if>

            <#if realm.resetPasswordAllowed>
            <a href="${url.loginResetCredentialsUrl}" class="link">Esqueci a senha</a>
            </#if>
        </div>
    </div>
    <script>
        const params = new URLSearchParams(window.location.search);
        const serviceName = params.get("serviceName");
        const theme = params.get("theme") || "light";

        // Aplica o tema
        document.body.setAttribute("data-theme", theme);

        // Atualiza o título se houver um serviceName
        if (serviceName) {
            document.getElementById("service-title").innerText = serviceName;
        }
    </script>
</body>
</html>
