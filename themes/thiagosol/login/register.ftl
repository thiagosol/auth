<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Criar Conta</title>
    <link rel="stylesheet" href="${url.resourcesPath}/css/style.css">
</head>
<body>
    <div class="login-container">
        <h1 id="service-title">Criar Conta</h1>
        <form action="${url.registrationAction}" method="post">
            <#if !(register.formData.singleUsername??)>
                <input type="text" name="username" placeholder="Nome de usuário" autofocus required>
            </#if>
            <input type="text" name="firstName" placeholder="Nome" required>
            <input type="text" name="lastName" placeholder="Sobrenome" required>
            <input type="email" name="email" placeholder="Email" required>
            <#if !(register.formData.password??)>
                <input type="password" name="password" placeholder="Senha" required>
                <input type="password" name="password-confirm" placeholder="Confirmar senha" required>
            </#if>

            <#if recaptchaRequired??>
                <div class="form-group">
                    <div class="g-recaptcha" data-size="compact" data-sitekey="${recaptchaSiteKey}"></div>
                </div>
            </#if>

            <button type="submit">Criar Conta</button>
        </form>
        <div class="links-container">
            <a href="${url.loginUrl}" class="link">Já tem uma conta? Faça login</a>
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
            document.getElementById("service-title").innerText = "Criar Conta - " + serviceName;
        }
    </script>
    <#if recaptchaRequired??>
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    </#if>
</body>
</html> 