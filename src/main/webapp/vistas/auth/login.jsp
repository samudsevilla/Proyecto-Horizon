<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Horizon - Iniciar Sesión</title>
    <!-- Importamos el CSS desde assets -->
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
            <p class="auth-subtitle">Plataforma de Aprendizaje & Certificaciones</p>
        </div>

        <h2>Iniciar Sesión</h2>

        <!-- Contenedor dinámico de alertas manejado por JavaScript -->
        <div id="alert-message" class="alert" style="display: none;"></div>

        <!-- Formulario enviado vía AJAX por JavaScript -->
        <form action="${pageContext.request.contextPath}/LoginServlet" method="POST" class="auth-form">
            
            <div class="form-group">
                <label for="email">Correo Electrónico</label>
                <input type="email" id="email" name="email" placeholder="ejemplo@microsoft.com" required>
            </div>

            <div class="form-group">
                <label for="password">Contraseña</label>
                <input type="password" id="password" name="password" placeholder="••••••••" required>
            </div>
            
            <div style="text-align: right; margin-top: -0.5rem; margin-bottom: 1.5rem;">
                <a href="${pageContext.request.contextPath}/vistas/auth/recuperar.jsp" style="color: #2563eb; font-size: 0.875rem; text-decoration: none; font-weight: 500;">¿Olvidaste tu contraseña?</a>
            </div>

            <button type="submit" class="btn-primary">Ingresar</button>
        </form>

        <div class="auth-footer">
            <p>¿No tienes una cuenta? <a href="registro.jsp">Regístrate aquí</a></p>
        </div>
    </div>

    <!-- Script de validación e interacción AJAX -->
    <script src="${pageContext.request.contextPath}/assets/js/login.js"></script>
</body>
</html>