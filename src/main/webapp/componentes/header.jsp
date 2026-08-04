<%-- 
    Document   : header
    Created on : 23 jul. 2026, 11:12:13 a. m.
    Author     : Windows
--%>

<%@page import="com.mycompany.horizon.modelo.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/header.css">
        <title>JSP Page</title>
    </head>
    <body>
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

    </body>
</html>
