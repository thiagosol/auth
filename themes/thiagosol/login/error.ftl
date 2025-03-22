<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Erro</title>
    <link rel="stylesheet" href="${url.resourcesPath}/css/style.css">
</head>
<body>
    <div class="login-container">
        <h1 id="service-title">Erro</h1>
        <div class="error-message">
            <#if message?has_content>
                <p>${message.summary}</p>
            </#if>
            <#if skipLink??>
            <#else>
                <#if client?? && client.baseUrl?has_content>
                    <p><a href="${client.baseUrl}" class="link" id="client-link">Voltar para ${client.name}</a></p>
                </#if>
            </#if>
        </div>
        <div class="links-container">
            <a href="${url.loginUrl}" class="link" id="login-link">Tentar novamente</a>
        </div>
    </div>
    <script>
        const params = new URLSearchParams(window.location.search);
        const serviceName = params.get("serviceName");
        const theme = params.get("theme") || "light";

        document.body.setAttribute("data-theme", theme);

        if (serviceName) {
            document.getElementById("service-title").innerText = "Erro - " + serviceName;
        }

        const clientLink = document.getElementById("client-link");
        const loginLink = document.getElementById("login-link");

        if (clientLink) {
            clientLink.href = clientLink.href + "&theme=" + theme;
        }

        if (loginLink) {
            loginLink.href = loginLink.href + "&theme=" + theme;
        }
    </script>
</body>
</html> 
