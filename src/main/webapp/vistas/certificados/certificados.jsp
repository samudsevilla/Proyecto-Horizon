<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mis Certificados - Horizon</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>

    <%-- 1. Ruta corregida desde la raíz web --%>
    <jsp:include page="../../componentes/header.jsp"/>

    <main class="container my-5">
        <div class="d-flex align-items-center mb-4">
            <i class="bi bi-award-fill fs-2 text-warning me-3"></i>
            <div>
                <h1 class="h3 mb-0 fw-bold">Mis Certificaciones y Logros</h1>
                <p class="text-muted mb-0">Revisa los certificados obtenidos al completar tus cursos.</p>
            </div>
        </div>

        <div class="row g-4">
            <%-- 2. Renderizado dinámico desde la lista enviada por el Servlet --%>
            <c:choose>
                <c:when test="${not empty certificados}">
                    <c:forEach var="cert" items="${certificados}">
                        <div class="col-md-6 col-lg-4">
                            <div class="card h-100 shadow-sm border-0 rounded-3 border-start border-4 border-success">
                                <div class="card-body p-4 d-flex flex-column">
                                    <div class="d-flex align-items-center justify-content-between mb-3">
                                        <span class="fs-2">🏆</span>
                                        <span class="badge bg-success-subtle text-success fw-semibold px-3 py-1 rounded-pill">Completado</span>
                                    </div>
                                    <h5 class="card-title fw-bold mb-1"><c:out value="${cert.nombreCurso}" /></h5>
                                    <p class="text-muted small mb-2">Código: <code><c:out value="${cert.codigoVerificacion}" /></code></p>
                                    <small class="text-secondary d-block mb-3">
                                        <i class="bi bi-calendar-check me-1"></i> Expedido: 
                                        <fmt:formatDate value="${cert.fechaExpedicion}" pattern="dd MMM yyyy" />
                                    </small>
                                    
                                    <div class="mt-auto pt-2 d-grid">
                                        <a href="${pageContext.request.contextPath}/DescargarCertificadoServlet?id=${cert.idCertificacion}" class="btn btn-outline-primary fw-medium">
                                            <i class="bi bi-download me-1"></i> Descargar PDF
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>

                <%-- Mensaje alternativo si el usuario no tiene certificados aún --%>
                <c:otherwise>
                    <div class="col-12">
                        <div class="alert alert-info text-center py-5 rounded-3">
                            <i class="bi bi-journal-check fs-1 text-primary d-block mb-2"></i>
                            <h4 class="fw-bold">Aún no tienes certificados expedidos</h4>
                            <p class="mb-0 text-muted">Completa el 100% de las lecciones de tus cursos para desbloquear tus diplomas automáticamente.</p>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/bootstrap.bundle.min.js"></script>
</body>
</html>