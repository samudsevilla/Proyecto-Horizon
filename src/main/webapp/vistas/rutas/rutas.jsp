<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mis Rutas de Aprendizaje - Horizon</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

    <jsp:include page="../../componentes/header.jsp"/>

    <main class="container my-5">
        <div class="d-flex align-items-center mb-4">
            <i class="bi bi-compass-fill fs-2 text-primary me-3"></i>
            <div>
                <h1 class="h3 mb-0 fw-bold">Mis Rutas de Aprendizaje</h1>
                <p class="text-muted mb-0">Sigue tu progreso estructurado hacia tus metas profesionales.</p>
            </div>
        </div>

        <div class="row g-4">
            <c:choose>
                <c:when test="${not empty rutas}">
                    <c:forEach var="ruta" items="${rutas}">
                        <div class="col-md-6 col-lg-4">
                            <div class="card h-100 shadow-sm border-0 rounded-3">
                                <div class="card-body p-4 d-flex flex-column">
                                    <div class="d-flex align-items-center justify-content-between mb-3">
                                        <span class="badge bg-${ruta.colorClase}-subtle text-${ruta.colorClase} fw-semibold px-3 py-2 rounded-pill">${ruta.categoria}</span>
                                        <small class="text-muted"><i class="bi bi-journal-code me-1"></i>${ruta.totalCursos} Cursos</small>
                                    </div>
                                    <h5 class="card-title fw-bold"><c:out value="${ruta.nombre}" /></h5>
                                    <p class="card-text text-secondary small"><c:out value="${ruta.descripcion}" /></p>
                                    
                                    <div class="mt-auto pt-3">
                                        <div class="d-flex justify-content-between text-muted small mb-1">
                                            <span>Progreso</span>
                                            <span class="fw-bold">${ruta.progreso}%</span>
                                        </div>
                                        <div class="progress mb-3" style="height: 8px;">
                                            <div class="progress-bar bg-${ruta.colorClase}" role="progressbar" style="width: ${ruta.progreso}%;"></div>
                                        </div>
                                        <c:choose>
                                            <c:when test="${ruta.progreso == 100 && ruta.idCertificado > 0}">
                                                <a href="${pageContext.request.contextPath}/DescargarCertificadoServlet?id=${ruta.idCertificado}" class="btn btn-success w-100 fw-bold">
                                                    <i class="bi bi-patch-check-fill me-1"></i> Curso Completado
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="${pageContext.request.contextPath}/LeccionServlet?id=${ruta.idUltimaLeccion}" class="btn btn-outline-${ruta.colorClase} w-100 fw-medium">
                                                    Continuar Ruta
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
                    <div class="col-12">
                        <div class="alert alert-info text-center py-5 rounded-3">
                            <i class="bi bi-compass fs-1 text-primary d-block mb-2"></i>
                            <h4 class="fw-bold">No hay rutas de aprendizaje disponibles</h4>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/bootstrap.bundle.min.js"></script>
</body>
</html>