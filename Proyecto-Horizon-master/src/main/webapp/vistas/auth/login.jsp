<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Horizon - Iniciar Sesión</title>
    <!-- Importamos el CSS desde assets -->
    <link rel="stylesheet" type="text/css" href="../../assets/css/auth.css">
</head>
<body class="auth-body">

    <div class="auth-card">
        <!-- Logo de Horizon -->
        <div class="auth-header">
            <h1 class="logo-text">Horizon<span>.</span></h1>
            <p class="auth-subtitle">Plataforma de Aprendizaje & Certificaciones</p>
        </div>

        <h2>Iniciar Sesión</h2>

        <!-- Mensajes de alerta (Error / Éxito) -->
        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error">
                <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <% if (request.getAttribute("mensajeExito") != null) { %>
            <div class="alert alert-success">
                <%= request.getAttribute("mensajeExito") %>
            </div>
        <% } %>

        <!-- Formulario que envía los datos al LoginServlet -->
        <form action="${pageContext.request.contextPath}/LoginServlet" method="POST" class="auth-form">
            
            <div class="form-group">
                <label for="email">Correo Electrónico</label>
                <input type="email" id="email" name="email" placeholder="ejemplo@microsoft.com" required>
            </div>

            <div class="form-group">
                <label for="password">Contraseña</label>
                <input type="password" id="password" name="password" placeholder="••••••••" required>
            </div>

            <button type="submit" class="btn-primary">Ingresar</button>
        </form>

        <div class="auth-footer">
            <p>¿No tienes una cuenta? <a href="registro.jsp">Regístrate aquí</a></p>
        </div>
    </div>

</body>
</html>