<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Criar Conta</title>
    <link rel="stylesheet" href="${url.resourcesPath}/css/style.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
</head>
<body>
    <div class="login-container">
        <h1 id="service-title">Criar Conta</h1>
        <#if message?has_content>
            <div class="${message.type}-message">
                <p>${message.summary}</p>
            </div>
        </#if>
        <form action="${url.registrationAction}" method="post">
            <div class="form-group">
                <input type="text" name="username" placeholder="Email ou usuário" autofocus required>
            </div>
            <div class="form-group">
                <input type="text" name="firstName" placeholder="Nome" required>
            </div>
            <div class="form-group">
                <input type="text" name="lastName" placeholder="Sobrenome" required>
            </div>
            <div class="form-group">
                <input type="email" name="email" placeholder="Email" required>
            </div>
            <div class="form-group">
                <div class="password-container">
                    <input type="password" name="password" placeholder="Senha" required>
                    <button type="button" class="toggle-password" onclick="togglePassword(this)">
                        <span class="material-icons">visibility</span>
                    </button>
                </div>
            </div>
            <div class="form-group">
                <div class="password-container">
                    <input type="password" name="password-confirm" placeholder="Confirmar senha" required>
                    <button type="button" class="toggle-password" onclick="togglePassword(this)">
                        <span class="material-icons">visibility</span>
                    </button>
                </div>
            </div>
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
        }

        <#if recaptchaRequired??>
            const script = document.createElement('script');
            script.src = 'https://www.google.com/recaptcha/api.js';
            document.head.appendChild(script);
        </#if>

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