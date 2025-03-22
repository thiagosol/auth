<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recuperar Senha</title>
    <link rel="stylesheet" href="${url.resourcesPath}/css/style.css">
</head>
<body>
    <div class="login-container">
        <h1 id="service-title">Recuperar Senha</h1>
        <div class="info-message">
            <#if message?has_content>
                <p>${message.summary}</p>
            </#if>
        </div>
        <form action="${url.loginAction}" method="post">
            <input type="text" name="username" placeholder="Email ou usuário" autofocus required>
            <button type="submit">Enviar instruções</button>
        </form>
        <div class="links-container">
            <a href="${url.loginUrl}" class="link">Voltar para login</a>
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
            document.getElementById("service-title").innerText = "Recuperar Senha - " + serviceName;
        }
    </script>
</body>
</html> 