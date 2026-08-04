<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catálogo de Cursos - Horizon</title>
    
    <!-- Bootstrap 5 CSS & Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    
    <!-- CSS Propio del Catálogo -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/catalogo.css">
</head>
<body>

    <!-- Header / Navbar de la app -->
    <jsp:include page="../../componentes/header.jsp"/>

    <!-- Encabezado del Catálogo -->
    <header class="catalog-header text-center">
        <div class="container">
            <h1 class="fw-bold mb-2">Explora nuestro Catálogo</h1>
            <p class="lead opacity-90 mb-4">Descubre cursos de Ciberseguridad, Desarrollo y Tecnología para impulsar tu carrera.</p>
            
            <!-- Buscador en Tiempo Real -->
            <div class="row justify-content-center">
                <div class="col-md-8 col-lg-6">
                    <div class="search-box d-flex align-items-center">
                        <i class="bi bi-search text-muted fs-5 me-2"></i>
                        <input type="text" id="searchInput" class="form-control" placeholder="Buscar por título, tecnología o palabras clave...">
                    </div>
                </div>
            </div>
        </div>
    </header>

    <div class="container mb-5">
        
        <!-- Filtros de Categorías -->
        <div class="d-flex flex-wrap justify-content-center gap-2 mb-4" id="categoryFilters">
            <button class="btn btn-primary filter-btn active" data-filter="todos">Todos</button>
            <button class="btn btn-outline-secondary filter-btn" data-filter="Ciberseguridad">Ciberseguridad</button>
            <button class="btn btn-outline-secondary filter-btn" data-filter="Programación">Programación</button>
            <button class="btn btn-outline-secondary filter-btn" data-filter="Infraestructura">Infraestructura</button>
        </div>

        <!-- Grid de Cursos -->
        <div class="row g-4" id="coursesGrid">
            <c:choose>
                <c:when test="${not empty cursos}">
                    <c:forEach var="curso" items="${cursos}">
                        <div class="col-md-6 col-lg-4 course-item" 
                             data-category="${curso.categoria}" 
                             data-title="${curso.titulo.toLowerCase()}">
                            
                            <div class="card course-card">
                                <%-- Imagen del Curso --%>
                                <img src="${not empty curso.imagenUrl ? curso.imagenUrl : 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=600&auto=format&fit=crop&q=60'}" 
                                     class="card-img-top" 
                                     alt="${curso.titulo}" 
                                     style="height: 180px; object-fit: cover;">
                                
                                <div class="card-body d-flex flex-column p-4">
                                    <div class="d-flex justify-content-between align-items-center mb-2">
                                        <span class="badge bg-primary-subtle text-primary course-badge">
                                            <c:out value="${curso.categoria}" default="General" />
                                        </span>
                                        <small class="text-muted fw-semibold">
                                            <i class="bi bi-bar-chart me-1"></i><c:out value="${curso.nivel}" default="Todos los niveles" />
                                        </small>
                                    </div>

                                    <h5 class="card-title fw-bold text-dark mb-2">
                                        <c:out value="${curso.titulo}" />
                                    </h5>

                                    <p class="card-text text-muted small flex-grow-1 mb-3">
                                        <c:out value="${curso.descripcion}" />
                                    </p>

                                    <div class="pt-3 border-top d-flex align-items-center justify-content-between">
                                        <span class="small text-muted">
                                            <i class="bi bi-journal-text me-1"></i>
                                            <c:out value="${curso.totalModulos}" default="0" /> Módulos
                                        </span>

                                        <%-- Acción dinámicamente según si está inscrito o no --%>
                                        <c:choose>
                                            <%-- Botón para continuar --%>
                                                <c:when test="${curso.inscrito}">
                                                    <a href="${pageContext.request.contextPath}/LeccionServlet?idCurso=${curso.idCurso}" 
                                                       class="btn btn-success btn-sm px-3 rounded-pill fw-medium">
                                                        <i class="bi bi-play-circle me-1"></i> Continuar
                                                    </a>
                                                </c:when>

                                                <%-- Botón para inscribirse --%>
                                                <c:otherwise>
                                                    <a href="${pageContext.request.contextPath}/CursoServlet?accion=inscribir&idCurso=${curso.idCurso}" 
                                                       class="btn btn-primary btn-sm px-3 rounded-pill fw-medium">
                                                        Unirme al curso
                                                    </a>
                                                </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <%-- Estado de fallback si la lista viene vacía --%>
                    <div class="col-12 text-center py-5">
                        <i class="bi bi-journal-x fs-1 text-muted d-block mb-3"></i>
                        <h4 class="fw-semibold">No hay cursos disponibles</h4>
                        <p class="text-muted">Pronto agregaremos nuevo contenido a la plataforma.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <%-- Mensaje dinámico si la búsqueda JS no encuentra coincidencias --%>
        <div id="noResults" class="text-center py-5 d-none">
            <i class="bi bi-search fs-1 text-muted d-block mb-2"></i>
            <h5 class="fw-semibold text-secondary">No se encontraron cursos coincidentes</h5>
            <p class="text-muted">Prueba buscando con otros términos o seleccionando otra categoría.</p>
        </div>

    </div>

    <!-- Bootstrap 5 Bundle JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/bootstrap.bundle.min.js"></script>

    <!-- JS Propio del Catálogo -->
    <script src="${pageContext.request.contextPath}/assets/js/catalogo.js"></script>
</body>
</html>