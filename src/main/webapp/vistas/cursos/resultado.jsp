<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resultado: <c:out value="${evaluacionTitulo}" /> - Horizon</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/evaluacion.css">
</head>
<body class="eval-body">

    <jsp:include page="../../componentes/header.jsp"/>

    <main class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-6 col-md-8 text-center">
                
                <div class="card p-5 rounded-4 shadow-sm border-0 bg-white">
                    <c:choose>
                        <c:when test="${aprobado}">
                            <div class="result-icon-container mb-4 mx-auto rounded-circle d-flex align-items-center justify-content-center bg-success bg-opacity-10 text-success" style="width: 100px; height: 100px;">
                                <i class="bi bi-patch-check-fill fs-1"></i>
                            </div>
                            
                            <h1 class="h2 fw-bold text-success mb-2">¡Felicitaciones, Aprobaste!</h1>
                            <p class="text-muted mb-4">Has superado satisfactoriamente la evaluación del módulo.</p>

                            <div class="score-display p-4 rounded-4 bg-light mb-4 border d-flex flex-column gap-1">
                                <span class="score-title text-secondary uppercase small fw-semibold tracking-wider">Nota Obtenida</span>
                                <span class="score-value display-4 fw-bold text-success">${nota} <span class="fs-4 text-muted">/ 20</span></span>
                                <span class="score-detail text-muted small mt-2">
                                    Aciertos: <strong>${aciertos}</strong> de <strong>${totalPreguntas}</strong> preguntas
                                </span>
                            </div>

                            <c:if test="${certificadoGenerado}">
                                <div class="alert alert-success border-success-subtle rounded-4 p-4 mb-4 text-start d-flex align-items-center gap-3 animate-pulse">
                                    <span class="fs-1">🎓</span>
                                    <div>
                                        <h5 class="fw-bold mb-1 text-success">¡Curso Completado al 100%!</h5>
                                        <p class="mb-0 text-secondary small">Hemos generado tu certificado oficial para descargar.</p>
                                    </div>
                                </div>
                            </c:if>

                            <div class="d-flex flex-column gap-3 justify-content-center align-items-center mt-4">
                                <c:if test="${certificadoGenerado}">
                                    <a href="${pageContext.request.contextPath}/CertificadoServlet" class="btn btn-success btn-lg w-100 py-3 rounded-3 fw-bold shadow-sm">
                                        <i class="bi bi-award-fill me-1"></i> Ver Mis Certificados
                                    </a>
                                </c:if>
                                <a href="${pageContext.request.contextPath}/HomeServlet" class="btn btn-primary btn-lg w-100 py-3 rounded-3 fw-bold">
                                    Volver al Panel de Control
                                </a>
                            </div>
                        </c:when>
                        
                        <c:otherwise>
                            <div class="result-icon-container mb-4 mx-auto rounded-circle d-flex align-items-center justify-content-center bg-danger bg-opacity-10 text-danger" style="width: 100px; height: 100px;">
                                <i class="bi bi-exclamation-octagon-fill fs-1"></i>
                            </div>

                            <h1 class="h2 fw-bold text-danger mb-2">No Aprobado</h1>
                            <p class="text-muted mb-4">No has alcanzado la nota mínima aprobatoria de 10/20.</p>

                            <div class="score-display p-4 rounded-4 bg-light mb-4 border d-flex flex-column gap-1">
                                <span class="score-title text-secondary uppercase small fw-semibold tracking-wider">Nota Obtenida</span>
                                <span class="score-value display-4 fw-bold text-danger">${nota} <span class="fs-4 text-muted">/ 20</span></span>
                                <span class="score-detail text-muted small mt-2">
                                    Aciertos: <strong>${aciertos}</strong> de <strong>${totalPreguntas}</strong> preguntas
                                </span>
                            </div>

                            <div class="d-flex flex-column gap-3 justify-content-center align-items-center mt-4">
                                <a href="javascript:history.back()" class="btn btn-danger btn-lg w-100 py-3 rounded-3 fw-bold">
                                    <i class="bi bi-arrow-clockwise me-1"></i> Reintentar Evaluación
                                </a>
                                <a href="${pageContext.request.contextPath}/HomeServlet" class="btn btn-outline-secondary btn-lg w-100 py-3 rounded-3">
                                    Volver al Panel
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

            </div>
        </div>
    </main>

    <jsp:include page="../../componentes/footer.jsp"/>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/bootstrap.bundle.min.js"></script>
</body>
</html>
