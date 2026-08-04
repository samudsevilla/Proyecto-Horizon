<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Horizon - Crear Cuenta</title>
    <!-- Mismo CSS dedicado para autenticación -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/auth.css">
</head>
<body class="auth-body">
    

    <div class="auth-card">
        <!-- Botón Volver al Inicio -->
        <div class="auth-back" style="text-align: left; margin-bottom: 1rem;">
            <a href="${pageContext.request.contextPath}/index.jsp" style="text-decoration: none; color: #64748b; font-size: 0.875rem; display: inline-flex; align-items: center; gap: 0.3rem;">
                &#8592; Volver al inicio
            </a>
        </div>
        <!-- Logo de Horizon -->
        <div class="auth-header">
            <h1 class="logo-text">Horizon<span>.</span></h1>
            <p class="auth-subtitle">Unete a la plataforma de aprendizaje</p>
        </div>

        <h2>Crear una Cuenta</h2>

        <!-- Mensajes de error -->
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <!-- Formulario que envía los datos al RegistroServlet -->
        <form action="${pageContext.request.contextPath}/RegistroServlet" method="POST" class="auth-form">
            
            <div class="form-group">
                <label for="nombre">Nombre Completo</label>
                <input type="text" id="nombre" name="nombre" placeholder="Ej. Carlos Albornoz" required>
            </div>

            <div class="form-group">
                <label for="email">Correo Electrónico</label>
                <input type="email" id="email" name="email" placeholder="ejemplo@microsoft.com" required>
            </div>

            <div class="form-group">
                <label for="password">Contraseña</label>
                <input type="password" id="password" name="password" placeholder="••••••••" required>
            </div>
            <!-- ¡CAMPO AGREGADO AQUÍ! -->
            <div class="form-group">
                <label for="confirmPassword">Confirmar Contraseña</label>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="••••••••" required>
            </div>

            <button type="submit" class="btn-primary">Registrarse</button>
        </form>

        <div class="auth-footer">
            <p>¿Ya tienes una cuenta? <a href="login.jsp">Inicia sesión aquí</a></p>
        </div>
    </div>

</body>
</html>