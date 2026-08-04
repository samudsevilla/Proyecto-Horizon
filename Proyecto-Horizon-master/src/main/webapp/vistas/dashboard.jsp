<%-- 
    Document   : dashboard
    Created on : 23 jul. 2026
    Author     : Windows
--%>

<%@page import="com.mycompany.horizon.modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Recuperar el usuario enviado desde el HomeServlet o la sesión
    Usuario usuario = (Usuario) request.getAttribute("usuario");
    
    if (usuario == null) {
        HttpSession sesion = request.getSession(false);
        if (sesion != null) {
            usuario = (Usuario) sesion.getAttribute("usuarioLogueado");
        }
    }
    
    // Protección: Si no hay usuario logueado, redirigir al login
    if (usuario == null) {
        response.sendRedirect("auth/login.jsp");
        return;
    }

    // Obtener las iniciales del usuario para el Avatar
    String nombre = usuario.getNombre();
    String iniciales = "US";
    if (nombre != null && !nombre.trim().isEmpty()) {
        String[] partes = nombre.trim().split("\\s+");
        if (partes.length >= 2) {
            iniciales = ("" + partes[0].charAt(0) + partes[1].charAt(0)).toUpperCase();
        } else {
            iniciales = nombre.substring(0, Math.min(2, nombre.length())).toUpperCase();
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Horizon - Panel Principal</title>
    <!-- Ojo con la ruta relativa del CSS al estar dentro de la carpeta /vistas/ -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

    <!-- Barra de Navegación del Usuario Autenticado -->
    <header class="navbar">
        <div class="logo">Horizon<span>.</span></div>
        <nav>
            <ul>
                <li><a href="dashboard.jsp" class="active">Inicio</a></li>
                <li><a href="#">Catálogo</a></li>
                <li><a href="#">Mis Rutas</a></li>
                <li><a href="#">Certificados</a></li>
            </ul>
        </nav>

        <!-- Perfil del usuario activo -->
        <div class="user-profile">
            <div class="avatar" title="<%= usuario.getNombre() %>"><%= iniciales %></div>
            <a href="${pageContext.request.contextPath}/LogoutServlet" class="btn-logout" title="Cerrar Sesión">Cerrar Sesión</a>
        </div>
    </header>

    <main class="dashboard">
        <!-- Sección Hero Personalizada -->
        <section class="hero-section">
            <div class="hero-content">
                <h1>¡Bienvenido de nuevo, <%= usuario.getNombre() %>!</h1>
                <p>Estás a solo un módulo de obtener tu próxima certificación en Desarrollo Backend.</p>
                <button class="btn btn-primary">Continuar Aprendiendo</button>
            </div>
        </section>

        <div class="content-grid">
            <!-- Cursos en Progreso -->
            <section class="courses-section">
                <h2>Cursos en Progreso</h2>
                
                <div class="course-card">
                    <div class="course-info">
                        <h3>Seguridad en Redes y Sistemas</h3>
                        <p>Módulo 4: Criptografía aplicada</p>
                    </div>
                    <div class="progress-container">
                        <div class="progress-bar">
                            <div class="progress-fill" style="width: 75%;"></div>
                        </div>
                        <span class="progress-text">75% Completado</span>
                    </div>
                </div>

                <div class="course-card">
                    <div class="course-info">
                        <h3>Arquitectura de Servidores</h3>
                        <p>Módulo 2: Contenedores y Docker</p>
                    </div>
                    <div class="progress-container">
                        <div class="progress-bar">
                            <div class="progress-fill" style="width: 30%;"></div>
                        </div>
                        <span class="progress-text">30% Completado</span>
                    </div>
                </div>
            </section>

            <!-- Sección de Certificaciones del Usuario -->
            <section class="certification-section">
                <h2>Mis Certificaciones</h2>
                
                <!-- Certificado Obtenido -->
                <div class="cert-card success">
                    <div class="cert-icon">🏆</div>
                    <div class="cert-details">
                        <h3>Fundamentos de Programación</h3>
                        <p>Aprobado con excelencia</p>
                        <span class="date">Expedido: 15 May 2026</span>
                    </div>
                    <button class="btn btn-outline">Descargar PDF</button>
                </div>

                <!-- Certificado Pendiente -->
                <div class="cert-card pending">
                    <div class="cert-icon">🔒</div>
                    <div class="cert-details">
                        <h3>Especialista en Automatización</h3>
                        <p>Requiere examen final</p>
                    </div>
                    <button class="btn btn-disabled" disabled>Bloqueado</button>
                </div>
            </section>
        </div>
    </main>

</body>
</html>