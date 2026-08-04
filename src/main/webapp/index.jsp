<%-- 
    Document   : index
    Created on : 23 jul. 2026, 10:36:17 a. m.
    Author     : Windows
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Horizon - Plataforma de Aprendizaje y Certificaciones</title>
    <link rel="stylesheet" href="assets/css/style.css">
</head>
<body>

    <!-- Barra de Navegación para Visitante -->
    <header class="navbar">
        <div class="logo">Horizon<span>.</span></div>
        <nav>
            <ul>
                <li><a href="index.jsp" class="active">Inicio</a></li>
                <li><a href="vistas/auth/login.jsp">Catálogo</a></li>
                <li><a href="vistas/auth/login.jsp">Certificaciones</a></li>
            </ul>
        </nav>
        <!-- En lugar de Avatar, mostramos botones de acceso -->
        <div class="auth-buttons">
            <a href="vistas/auth/login.jsp" class="btn-link">Iniciar Sesión</a>
            <a href="vistas/auth/registro.jsp" class="btn btn-primary-sm">Registrarse</a>
        </div>
    </header>

    <main class="dashboard">
        <!-- Sección Hero Promocional -->
        <section class="hero-section">
            <div class="hero-content">
                <h1>Impulsa tu carrera tecnológica</h1>
                <p>Aprende las habilidades más demandadas en desarrollo, seguridad y la nube con certificaciones oficiales.</p>
                <a href="vistas/auth/registro.jsp" class="btn btn-primary">Empieza Gratis Hoy</a>
            </div>
        </section>

        <div class="content-grid">
            <!-- Cursos Destacados del Catálogo -->
            <section class="courses-section">
                <h2>Cursos Destacados</h2>
                
                <div class="course-card">
                    <div class="course-info">
                        <h3>Curso de Ciberseguridad desde 0</h3>
                        <p>¿Quieres aprender ciberseguridad pero no sabes por dónde empezar?</p>
                    </div>
                    <div class="course-action">
                        <a href="vistas/auth/login.jsp" class="btn btn-outline">Ver Detalles</a>
                    </div>
                </div>

                <div class="course-card">
                    <div class="course-info">
                        <h3>Arquitectura de Servidores</h3>
                        <p>Domina despliegues modernos con Docker, Kubernetes y Microservicios.</p>
                    </div>
                    <div class="course-action">
                        <a href="vistas/auth/login.jsp" class="btn btn-outline">Ver Detalles</a>
                    </div>
                </div>
            </section>

            <!-- Sección Informativa sobre Certificados -->
            <section class="certification-section">
                <h2>Certificaciones Validadas</h2>
                
                <div class="cert-card success">
                    <div class="cert-icon">🎓</div>
                    <div class="cert-details">
                        <h3>Certificados Oficiales</h3>
                        <p>Obtén acreditaciones digitales verificables con firma criptográfica al completar tus rutas.</p>
                    </div>
                </div>

                <div class="cert-card pending">
                    <div class="cert-icon">⚡</div>
                    <div class="cert-details">
                        <h3>Evaluación Continua</h3>
                        <p>Pon a prueba tus conocimientos con exámenes prácticos y automatizados.</p>
                    </div>
                </div>
            </section>
        </div>
    </main>

</body>
</html>