<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Evaluación: <c:out value="${evaluacion.titulo}" /> - Horizon</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/evaluacion.css">
</head>
<body class="eval-body">

    <jsp:include page="../../componentes/header.jsp"/>

    <main class="container py-5">
        <div class="row justify-content-center">
            <div class="col-lg-8 col-md-10">
                
                <!-- Encabezado de la evaluación -->
                <div class="eval-header-card p-4 mb-4 text-white rounded-4 shadow-sm">
                    <div class="d-flex align-items-center gap-2 mb-2 text-white-50">
                        <i class="bi bi-journal-check"></i>
                        <span>Evaluación de Módulo</span>
                    </div>
                    <h1 class="h3 fw-bold mb-0"><c:out value="${evaluacion.titulo}" /></h1>
                    <p class="mb-0 mt-2 text-white-50 small">
                        Responde todas las preguntas seleccionando la opción correcta. Nota mínima para aprobar: 10/20.
                    </p>
                </div>

                <c:choose>
                    <c:when test="${not empty preguntas}">
                        <!-- Formulario de Evaluación -->
                        <form action="${pageContext.request.contextPath}/EvaluacionServlet" method="POST" id="evalForm">
                            <input type="hidden" name="idEvaluacion" value="${evaluacion.idEvaluacion}">
                            <input type="hidden" name="evaluacionTitulo" value="${evaluacion.titulo}">

                            <c:forEach var="pregunta" items="${preguntas}" varStatus="status">
                                <div class="question-card p-4 mb-4 bg-white rounded-4 border shadow-sm">
                                    <div class="d-flex align-items-start gap-3">
                                        <span class="question-number d-flex align-items-center justify-content-center rounded-circle fw-bold text-primary">
                                            ${status.index + 1}
                                        </span>
                                        <div class="flex-grow-1">
                                            <h2 class="h5 fw-semibold text-dark mb-3"><c:out value="${pregunta.enunciado}" /></h2>
                                            
                                            <div class="options-container d-flex flex-column gap-2">
                                                 <!-- Opción A -->
                                                 <label class="option-label p-3 rounded-3 border d-flex align-items-center gap-3 cursor-pointer">
                                                     <input type="radio" name="respuesta_${pregunta.idPregunta}" value="A" required class="form-check-input m-0">
                                                     <span class="fw-bold text-secondary me-1">A.</span>
                                                     <span class="option-text"><c:out value="${pregunta.opcionA}" /></span>
                                                 </label>
 
                                                 <!-- Opción B -->
                                                 <label class="option-label p-3 rounded-3 border d-flex align-items-center gap-3 cursor-pointer">
                                                     <input type="radio" name="respuesta_${pregunta.idPregunta}" value="B" class="form-check-input m-0">
                                                     <span class="fw-bold text-secondary me-1">B.</span>
                                                     <span class="option-text"><c:out value="${pregunta.opcionB}" /></span>
                                                 </label>
 
                                                 <!-- Opción C -->
                                                 <label class="option-label p-3 rounded-3 border d-flex align-items-center gap-3 cursor-pointer">
                                                     <input type="radio" name="respuesta_${pregunta.idPregunta}" value="C" class="form-check-input m-0">
                                                     <span class="fw-bold text-secondary me-1">C.</span>
                                                     <span class="option-text"><c:out value="${pregunta.opcionC}" /></span>
                                                 </label>
 
                                                 <!-- Opción D -->
                                                 <label class="option-label p-3 rounded-3 border d-flex align-items-center gap-3 cursor-pointer">
                                                     <input type="radio" name="respuesta_${pregunta.idPregunta}" value="D" class="form-check-input m-0">
                                                     <span class="fw-bold text-secondary me-1">D.</span>
                                                     <span class="option-text"><c:out value="${pregunta.opcionD}" /></span>
                                                 </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>

                            <!-- Acciones del Formulario -->
                            <div class="d-flex justify-content-between align-items-center mt-5">
                                <a href="${pageContext.request.contextPath}/HomeServlet" class="btn btn-outline-secondary px-4 py-2 rounded-3">
                                    <i class="bi bi-x-circle me-1"></i> Cancelar
                                </a>
                                <button type="submit" class="btn btn-primary px-5 py-2 rounded-3 fw-bold" id="btnSubmit">
                                    <i class="bi bi-check2-circle me-1"></i> Enviar Evaluación
                                </button>
                            </div>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-warning text-center rounded-4 p-5" role="alert">
                            <i class="bi bi-clipboard-x fs-1 d-block mb-3 text-warning"></i>
                            <h2 class="h4 fw-bold">Sin preguntas</h2>
                            <p class="mb-0 text-muted">Esta evaluación aún no tiene preguntas cargadas. Vuelve más tarde.</p>
                            <a href="${pageContext.request.contextPath}/HomeServlet" class="btn btn-primary mt-4 px-4 py-2 rounded-3">
                                Volver al Panel
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>
    </main>

    <jsp:include page="../../componentes/footer.jsp"/>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const form = document.getElementById('evalForm');
            const submitBtn = document.getElementById('btnSubmit');

            if (form) {
                form.addEventListener('submit', () => {
                    // Deshabilitar botón para evitar dobles envíos
                    submitBtn.disabled = true;
                    submitBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-1" role="status" aria-hidden="true"></span> Calificando...';
                });
            }

            // Restablecer el botón si el usuario regresa con el botón Atrás del navegador
            window.addEventListener('pageshow', (event) => {
                if (submitBtn) {
                    submitBtn.disabled = false;
                    submitBtn.innerHTML = '<i class="bi bi-check2-circle me-1"></i> Enviar Evaluación';
                }
            });
        });
    </script>
</body>
</html>
