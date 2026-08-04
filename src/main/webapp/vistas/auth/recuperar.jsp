<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Horizon - Recuperar Contraseña</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/auth.css">
</head>
<body class="auth-body">
    <div class="auth-card">
        <!-- Botón Volver -->
        <div class="auth-back" style="text-align: left; margin-bottom: 1rem;">
            <a href="${pageContext.request.contextPath}/vistas/auth/login.jsp" style="text-decoration: none; color: #64748b; font-size: 0.875rem; display: inline-flex; align-items: center; gap: 0.3rem;">
                &#8592; Volver al Login
            </a>
        </div>

        <!-- Logo -->
        <div class="auth-header">
            <h1 class="logo-text">Horizon<span>.</span></h1>
            <p class="auth-subtitle">Recuperación de Contraseña</p>
        </div>

        <h2>Restablecer Contraseña</h2>
        <p style="color: #64748b; font-size: 0.875rem; text-align: center; margin-bottom: 1.5rem;">
            Ingresa el correo electrónico asociado a tu cuenta y te enviaremos un código de 6 dígitos para restablecer tu contraseña.
        </p>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error">
                ⚠️ <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/RecuperarPasswordServlet" method="POST" class="auth-form">
            <div class="form-group">
                <label for="email">Correo Electrónico</label>
                <input type="email" id="email" name="email" placeholder="ejemplo@microsoft.com" required>
            </div>

            <button type="submit" class="btn-primary" style="margin-top: 1rem;">Enviar Código</button>
        </form>
    </div>
</body>
</html>
