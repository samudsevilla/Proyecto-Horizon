<%-- 
    Document   : dashboard
    Created on : 23 jul. 2026
    Author     : Windows
--%>

<%@page import="com.mycompany.horizon.modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // 1. Deshabilitar caché para evitar retroceso tras logout
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // 2. Recuperar usuario del request o la sesión
    Usuario usuario = (Usuario) request.getAttribute("usuario");
    
    if (usuario == null) {
        HttpSession sesion = request.getSession(false);
        if (sesion != null) {
            usuario = (Usuario) sesion.getAttribute("usuario");
        }
    }

    // 3. Lógica para obtener las iniciales del Avatar
    String nombre = (usuario != null) ? usuario.getNombre() : "";
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
                <li><a href="${pageContext.request.contextPath}/HomeServlet" class="active">Inicio</a></li>
                <li><a class="nav-link" href="${pageContext.request.contextPath}/CursoServlet">Catálogo</a></li>
                <li><a class="nav-link" href="${pageContext.request.contextPath}/RutaServlet">Mis Rutas</a></li>
                <li><a class="nav-link" href="${pageContext.request.contextPath}/CertificadoServlet">Certificados</a></li>
            </ul>
        </nav>

        <!-- Perfil del usuario activo -->
        <div class="user-profile">
           <div class="avatar" title="<%= (usuario != null) ? usuario.getNombre() : "Usuario" %>"><%= iniciales %></div>
            <a href="${pageContext.request.contextPath}/LogoutServlet" class="btn-logout" title="Cerrar Sesión">Cerrar Sesión</a>
        </div>
    </header>

    <main class="dashboard">
        <!-- Sección Hero Personalizada -->
        <section class="hero-section">
            <div class="hero-content">
                <h1>¡Bienvenido de nuevo, ${sessionScope.usuario.nombre}!</h1>
                <p>Estás a solo un módulo de obtener tu próxima certificación en Ciberseguridad.</p>
                <a href="${pageContext.request.contextPath}/LeccionServlet?id=27" class="btn btn-primary" style="text-decoration: none; display: inline-block;">
                    Continuar Aprendiendo
                </a>
            </div>
        </section>

        <div class="content-grid">
            <!-- Cursos en Progreso -->
            <!-- Cursos en Progreso -->
            <section class="courses-section">
                <h2>Cursos en Progreso</h2>

                <c:choose>
                    <c:when test="${not empty cursosEnProgreso}">
                        <c:forEach var="curso" items="${cursosEnProgreso}">
                            <a href="${pageContext.request.contextPath}/LeccionServlet?id=${curso.idUltimaLeccion}" class="course-card" style="text-decoration: none; color: inherit; display: block;">
                                <div class="course-info">
                                    <h3><c:out value="${curso.titulo}" /></h3>
                                    <p><c:out value="${curso.moduloActual}" /></p>
                                </div>
                                <div class="progress-container">
                                    <div class="progress-bar">
                                        <div class="progress-fill" style="width: ${curso.progreso}%;"></div>
                                    </div>
                                    <span class="progress-text">${curso.progreso}% Completado</span>
                                </div>
                            </a>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-info text-center py-4 rounded-3" style="background-color: #f0fdf4; color: #16a34a; border: 1px solid #bbf7d0; font-size: 14px;">
                            <p class="mb-0 fw-semibold">No estás inscrito en ningún curso todavía.</p>
                            <a href="${pageContext.request.contextPath}/CursoServlet" class="btn btn-primary mt-3 btn-sm" style="text-decoration: none; display: inline-block; padding: 6px 12px; background-color: #2563eb; color: #ffffff; border-radius: 6px;">Ver Catálogo</a>
                        </div>
                    </c:otherwise>
                </c:choose>
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
                    <a href="${pageContext.request.contextPath}/DescargarCertificadoServlet?id=${cert.idCertificacion}" class="btn btn-outline" style="text-decoration: none;">
                        <i class="bi bi-download me-1"></i> Descargar PDF
                    </a>
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