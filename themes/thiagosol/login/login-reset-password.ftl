<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Redefinir Senha</title>
    <link rel="stylesheet" href="${url.resourcesPath}/css/style.css">
</head>
<body>
    <div class="login-container">
        <h1 id="service-title">Redefinir Senha</h1>
        <#if message?has_content>
            <div class="error-message">
                <p>${message.summary}</p>
            </div>
        </#if>
        <form action="${url.loginResetCredentialsUrl}" method="post">
            <input type="text" name="username" placeholder="Email ou usuário" autofocus required>
            <button type="submit">Enviar instruções</button>
        </form>
        <div class="links-container">
            <a href="${url.loginUrl}" class="link" id="login-link">Voltar para login</a>
        </div>
    </div>
    <script>
        const params = new URLSearchParams(window.location.search);
        const serviceName = params.get("serviceName");
        const theme = params.get("theme") || "light";

        document.body.setAttribute("data-theme", theme);

        if (serviceName) {
            document.getElementById("service-title").innerText = `Redefinir Senha - ${serviceName}`;
        }

        const loginLink = document.getElementById("login-link");
        if (loginLink) {
            loginLink.href = loginLink.href + "&theme=" + theme + "&serviceName=" + serviceName;
        }

        // Adiciona os parâmetros na action do form
        const form = document.querySelector('form');
        if (form) {
            form.action = form.action + "&theme=" + theme + "&serviceName=" + serviceName;
        }
    </script>
</body>
</html> 