<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${msg("updatePasswordTitle")}</title>
    <link rel="stylesheet" href="${url.resourcesPath}/css/style.css">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
</head>
<body>
    <div class="login-container">
        <h1 id="service-title">${msg("updatePasswordTitle")}</h1>
        <#if message?has_content>
            <div class="${message.type}-message">
                <p>${message.summary}</p>
            </div>
        </#if>
        <form action="${url.loginAction}" method="post">
            <div class="form-group">
                <div class="password-container">
                    <input type="password" name="password-new" placeholder="${msg('passwordNew')}" autofocus required>
                    <button type="button" class="toggle-password" onclick="togglePassword(this)">
                        <span class="material-icons">visibility</span>
                    </button>
                </div>
            </div>
            <div class="form-group">
                <div class="password-container">
                    <input type="password" name="password-confirm" placeholder="${msg('passwordConfirm')}" required>
                    <button type="button" class="toggle-password" onclick="togglePassword(this)">
                        <span class="material-icons">visibility</span>
                    </button>
                </div>
            </div>
            <button type="submit">${msg("doSubmit")}</button>
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
