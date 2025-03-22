<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Erro</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="login-container">
        <h1>Erro</h1>
        <div class="error-message">
            <#if message?has_content>
                <p>${message.summary}</p>
            </#if>
            <#if skipLink??>
            <#else>
                <#if client?? && client.baseUrl?has_content>
                    <p><a href="${client.baseUrl}" class="link">Voltar para ${client.name}</a></p>
                </#if>
            </#if>
        </div>
        <div class="links-container">
            <a href="${url.loginUrl}" class="link">Tentar novamente</a>
        </div>
    </div>
    <script>
        const params = new URLSearchParams(window.location.search);
        const theme = params.get("theme") || "light";
        document.body.setAttribute("data-theme", theme);
    </script>
</body>
</html>
