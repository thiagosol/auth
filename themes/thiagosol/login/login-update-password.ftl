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
            <div class="${message.type}-message">
                <p>${message.summary}</p>
            </div>
        </#if>
        <form action="${url.loginAction}" method="post">
            <div class="password-container">
                <input type="password" name="password-new" placeholder="Nova senha" autofocus required>
                <button type="button" class="toggle-password" onclick="togglePassword(this)">👁️</button>
            </div>
            <div class="password-container">
                <input type="password" name="password-confirm" placeholder="Confirmar nova senha" required>
                <button type="button" class="toggle-password" onclick="togglePassword(this)">👁️</button>
            </div>
            <button type="submit">Alterar senha</button>
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

        function togglePassword(button) {
            const input = button.previousElementSibling;
            if (input.type === "password") {
                input.type = "text";
                button.textContent = "🔒";
            } else {
                input.type = "password";
                button.textContent = "👁️";
            }
        }
    </script>
</body>
</html> 
