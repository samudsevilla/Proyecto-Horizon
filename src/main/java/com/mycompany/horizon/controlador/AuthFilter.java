package com.mycompany.horizon.controlador;

import java.io.IOException;
import javax.servlet.DispatcherType;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(
    filterName = "AuthFilter", 
    urlPatterns = {
        "/HomeServlet",
        "/vistas/dashboard.jsp",
        "/vistas/cursos/*",
        "/vistas/rutas/*",
        "/vistas/certificados/*",
        "/LeccionServlet",
        "/EvaluacionServlet",
        "/vistas/cursos/ver-leccion.jsp"
    },
    dispatcherTypes = {DispatcherType.REQUEST, DispatcherType.FORWARD}
)
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Inicialización si es necesaria
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        // 🔴 AGREGA ESTA LÍNEA DE DIAGNÓSTICO:
        System.out.println(">>> EJECUTANDO AUTH FILTER PARA LA RUTA: " + httpRequest.getRequestURI());

        // Evitar caché en el navegador...
        httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

        // Evitar caché en el navegador para que al presionar "Atrás" tras cerrar sesión no muestre la vista guardada
        httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
        httpResponse.setHeader("Pragma", "no-cache"); // HTTP 1.0
        httpResponse.setDateHeader("Expires", 0); // Proxies

        HttpSession session = httpRequest.getSession(false);

        // Verificar si la sesión existe y si hay un usuario logueado
        boolean isLoggedIn = (session != null && session.getAttribute("usuario") != null);

        if (isLoggedIn) {
            // Usuario autenticado, continuar con la petición normal
            chain.doFilter(request, response);
        } else {
            // No está logueado, redirigir al login
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/vistas/auth/login.jsp?error=sesion_requerida");
        }
    }

    @Override
    public void destroy() {
        // Limpieza si es necesaria
    }
}