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
        <#if message?has_content>
            <div class="${message.type}-message">
                <p>${message.summary}</p>
            </div>
        </#if>
        <form action="${url.loginAction}" method="post">
            <input type="text" name="username" placeholder="Email ou usuário" autofocus required>
            <div class="password-container">
                <input type="password" name="password" placeholder="Senha" required>
                <button type="button" class="toggle-password" onclick="togglePassword(this)">👁️</button>
            </div>
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
        let theme = params.get("theme");

        if (theme) {
            localStorage.setItem('kc_theme', theme);
        } else {
            theme = localStorage.getItem('kc_theme');
        }

        theme = theme || "light";
        document.body.setAttribute("data-theme", theme);

        const registerLink = document.getElementById("register-link");
        const resetLink = document.getElementById("reset-link");

        if (registerLink) {
            registerLink.href = registerLink.href + "&theme=" + theme;
        }

        if (resetLink) {
            resetLink.href = resetLink.href + "&theme=" + theme;
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
