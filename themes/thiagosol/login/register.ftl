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
        <#if message?has_content>
            <div class="error-message">
                <p>${message.summary}</p>
            </div>
        </#if>
        <form action="${url.registrationAction}" method="post">
            <input type="text" name="username" placeholder="Email ou usuário" autofocus required>
            <input type="text" name="firstName" placeholder="Nome" required>
            <input type="text" name="lastName" placeholder="Sobrenome" required>
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Senha" required>
            <input type="password" name="password-confirm" placeholder="Confirmar senha" required>
            <#if recaptchaRequired??>
                <div class="g-recaptcha" data-sitekey="${recaptchaSiteKey}"></div>
            </#if>
            <button type="submit">Criar conta</button>
        </form>
        <div class="links-container">
            <a href="${url.loginUrl}" class="link" id="login-link">Voltar para login</a>
        </div>
    </div>
    <script>
        const params = new URLSearchParams(window.location.search);
        let theme = params.get("theme");
        let serviceName = params.get("serviceName");

        // Se não veio na URL, tenta pegar do form data (POST)
        if (!theme) {
            const formData = new FormData(document.querySelector('form'));
            theme = formData.get('theme');
        }
        if (!serviceName) {
            const formData = new FormData(document.querySelector('form'));
            serviceName = formData.get('serviceName');
        }

        // Fallback para light se não encontrou em nenhum lugar
        theme = theme || "light";

        document.body.setAttribute("data-theme", theme);

        if (serviceName) {
            document.getElementById("service-title").innerText = "Criar Conta - " + serviceName;
        }

        const loginLink = document.getElementById("login-link");
        if (loginLink) {
            loginLink.href = loginLink.href + "&theme=" + theme + "&serviceName=" + serviceName;
        }

        const form = document.querySelector('form');
        if (form) {
            form.action = form.action + "&theme=" + theme + "&serviceName=" + serviceName;
            
            const themeInput = document.createElement('input');
            themeInput.type = 'hidden';
            themeInput.name = 'theme';
            themeInput.value = theme;
            form.appendChild(themeInput);

            if (serviceName) {
                const serviceNameInput = document.createElement('input');
                serviceNameInput.type = 'hidden';
                serviceNameInput.name = 'serviceName';
                serviceNameInput.value = serviceName;
                form.appendChild(serviceNameInput);
            }
        }

        <#if recaptchaRequired??>
            const script = document.createElement('script');
            script.src = 'https://www.google.com/recaptcha/api.js';
            document.head.appendChild(script);
        </#if>
    </script>
</body>
</html> 