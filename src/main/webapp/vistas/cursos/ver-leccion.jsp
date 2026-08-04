<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><c:out value="${leccion.titulo}" default="Lección" /> - Horizon</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/ver-leccion.css">
</head>
<body>

    <jsp:include page="../../componentes/header.jsp"/>

    <div class="container-fluid my-4 px-lg-5">
        <div class="row g-4">
            
            <!-- MAIN: Contenido de la Lección -->
            <main class="col-lg-8">
                <c:choose>
                    <c:when test="${not empty leccion}">
                        <div class="content-card mb-4">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item">
                                        <a href="${pageContext.request.contextPath}/HomeServlet" class="text-decoration-none">Inicio</a>
                                    </li>
                                    <li class="breadcrumb-item active" aria-current="page">
                                        <c:out value="${leccion.titulo}" />
                                    </li>
                                </ol>
                            </nav>

                            <h1 class="fw-semibold mb-3">
                                <c:out value="${leccion.titulo}" />
                            </h1>
                            <hr class="text-muted mb-4">

                           <c:if test="${not empty leccion.videoUrl}">
                                <div class="video-container mb-4 ratio ratio-16x9 rounded overflow-hidden shadow-sm">
                                    <iframe src="${leccion.videoUrl}" title="Video de la lección" allowfullscreen></iframe>
                                </div>
                            </c:if>

                            <%-- Mensaje alternativo si la lección NO tiene video --%>
                            <c:if test="${empty leccion.videoUrl}">
                                <div class="alert alert-info d-flex align-items-center mb-4" role="alert">
                                    <i class="bi bi-info-circle-fill me-2 fs-5"></i>
                                    <div>Esta lección no contiene video. Lee la teoría a continuación.</div>
                                </div>
                            </c:if>

                            <div class="lesson-body text-break lh-lg">
                                <c:out value="${leccion.contenidoTexto}" escapeXml="false" />
                            </div>
                        </div>

                        <div class="d-flex justify-content-between mb-4">
                            <a href="${pageContext.request.contextPath}/HomeServlet" class="btn btn-outline-secondary">
                                <i class="bi bi-arrow-left me-1"></i> Volver al Panel
                            </a>

                            <%-- Botón adicional para finalizar curso / obtener certificado --%>
                            <c:if test="${esUltimaLeccion == true}">
                                <form action="${pageContext.request.contextPath}/GenerarCertificadoServlet" method="POST" class="m-0">
                                    <input type="hidden" name="idCurso" value="${idCursoActual}">
                                    <button type="submit" class="btn btn-success">
                                        <i class="bi bi-trophy-fill me-1"></i> ¡Finalizar Curso y Obtener Certificado!
                                    </button>
                                </form>
                            </c:if>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-warning text-center" role="alert">
                            <i class="bi bi-exclamation-triangle-fill fs-3 d-block mb-2"></i>
                            <strong>Lección no encontrada</strong>
                            <p class="mb-0">No se pudo cargar el contenido de la lección solicitada.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </main>

            <!-- ASIDE: Contenido del Curso (Módulos y Lecciones) -->
            <aside class="col-lg-4">
                <div class="sidebar-modules">
                    <h5 class="fw-semibold mb-3 px-2">
                        <i class="bi bi-journal-text me-2 text-primary"></i>Contenido del Curso
                    </h5>

                    <c:choose>
                        <c:when test="${not empty modulos}">
                            <div class="accordion" id="accordionModulos">
                                <c:forEach var="modulo" items="${modulos}" varStatus="status">

                                    <c:set var="modId" value="${modulo.idModulo}" />
                                    
                                    <%-- Saber si este módulo contiene la lección actual para dejarlo abierto --%>
                                    <c:set var="containsActiveLesson" value="false" />
                                    <c:forEach var="checkLec" items="${modulo.lecciones}">
                                        <c:if test="${not empty leccion and checkLec.idLeccion == leccion.idLeccion}">
                                            <c:set var="containsActiveLesson" value="true" />
                                        </c:if>
                                    </c:forEach>

                                    <div class="accordion-item mb-2">
                                        <h2 class="accordion-header" id="heading-${modId}">
                                            <button class="accordion-button <c:if test='${!containsActiveLesson}'>collapsed</c:if>" 
                                                    type="button" 
                                                    data-bs-toggle="collapse" 
                                                    data-bs-target="#collapse-${modId}"
                                                    aria-expanded="${containsActiveLesson}"
                                                    aria-controls="collapse-${modId}">
                                                <c:out value="${modulo.titulo}" />
                                            </button>
                                        </h2>

                                         <div id="collapse-${modId}" 
                                              class="accordion-collapse collapse <c:if test='${containsActiveLesson}'>show</c:if>" 
                                              aria-labelledby="heading-${modId}">
                                            <div class="accordion-body p-2">
                                                <ul class="list-unstyled mb-0">
                                                    <c:forEach var="lec" items="${modulo.lecciones}">
                                                        <c:set var="lecId" value="${lec.idLeccion}" />
                                                        <c:set var="isActive" value="${not empty leccion and lecId == leccion.idLeccion}" />

                                                        <li>
                                                            <a href="${pageContext.request.contextPath}/LeccionServlet?id=${lecId}" class="lesson-item <c:if test='${isActive}'>active</c:if>">
                                                                <i class="bi <c:choose><c:when test='${isActive}'>bi-play-circle-fill text-white</c:when><c:otherwise>bi-circle text-primary</c:otherwise></c:choose> me-2"></i>
                                                                <c:out value="${lec.titulo}" />
                                                            </a>
                                                        </li>
                                                    </c:forEach>
                                                    
                                                    <li class="mt-2 pt-2 border-top border-light">
                                                        <a href="${pageContext.request.contextPath}/EvaluacionServlet?idModulo=${modId}" class="btn btn-sm btn-outline-primary w-100 py-1 d-flex align-items-center justify-content-center gap-1">
                                                            <i class="bi bi-patch-question-fill"></i>
                                                            Realizar Evaluación
                                                        </a>
                                                    </li>
                                                </ul>
                                            </div>
                                         </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <p class="text-muted px-2 small">No hay contenido disponible para este curso.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </aside>

        </div>
    </div>
    
    

    <!-- Script de Bootstrap 5 -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            // Seleccionar todos los botones de los módulos
            const buttons = document.querySelectorAll('.accordion-button');

            buttons.forEach(button => {
                button.addEventListener('click', (e) => {
                    const targetId = button.getAttribute('data-bs-target');
                    const targetContent = document.querySelector(targetId);

                    if (targetContent) {
                        // Alternar la clase 'show' para abrir/cerrar
                        targetContent.classList.toggle('show');
                        button.classList.toggle('collapsed');

                        const isExpanded = !button.classList.contains('collapsed');
                        button.setAttribute('aria-expanded', isExpanded);
                    }
                });
            });
        });
    </script>
</body>
</html>