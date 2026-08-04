<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Certificado - ${certificado.nombreCurso}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        body { 
            background: #f4f6f9; 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
        }
        .certificate {
            width: 800px;
            padding: 50px;
            margin: 40px auto;
            background: #ffffff;
            border: 10px solid #0d6efd; /* Borde grueso sólido como el diseño original en verde */
            position: relative;
            box-shadow: 0 10px 25px rgba(13, 110, 253, 0.1);
        }
        .watermark {
            position: absolute;
            top: 50%; 
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 100px;
            color: rgba(13, 110, 253, 0.04); /* Ajustado para que se note igual que el anterior */
            z-index: 0;
            pointer-events: none;
            letter-spacing: 15px;
            font-weight: bold;
        }
        .content { 
            position: relative; 
            z-index: 1; 
            text-align: center; 
        }
        .header-org {
            color: #0d6efd;
            letter-spacing: 2px;
            font-weight: 800;
        }
        .nombre-usuario {
            color: #212529;
            border-bottom: 2px solid #0d6efd;
            display: inline-block;
            padding-bottom: 5px;
        }
        .titulo-curso {
            color: #0d6efd;
            font-weight: 700;
        }
        .codigo-verificacion {
            color: #0d6efd;
        }
        @media print {
            body { background: #fff; }
            .no-print { display: none; }
            .certificate { border: 5px solid #0d6efd; margin: 0; box-shadow: none; width: 100%; }
        }
    </style>
</head>
<body>

    <div class="container text-center my-3 no-print">
        <button onclick="window.print()" class="btn btn-primary btn-lg shadow-sm">
            <i class="bi bi-printer"></i> Guardar como PDF / Imprimir
        </button>
        <a href="${pageContext.request.contextPath}/CertificadoServlet" class="btn btn-secondary btn-lg ms-2">Volver</a>
    </div>

    <div class="certificate">
        <div class="watermark">HORIZON</div>
        <div class="content">
            <h3 class="text-uppercase header-org fw-bold tracking-wide">Horizon E-Learning</h3>
            <p class="text-muted small">Certificado de Finalización Aprobada</p>
            
            <hr class="w-25 mx-auto border-primary border-2">

            <p class="mt-4 mb-2 fs-5">Se otorga el presente reconocimiento a:</p>
            <h1 class="fw-bold text-dark display-6 my-3"><span class="nombre-usuario">${nombreAlumno}</span></h1>
            
            <p class="mt-3 fs-5">Por haber completado satisfactoriamente el plan de estudios del curso:</p>
            <h2 class="titulo-curso fs-3 my-3">${certificado.nombreCurso}</h2>

            <div class="row mt-5 text-start align-items-center">
                <div class="col-6">
                    <p class="mb-0 text-muted small">Código de Verificación:</p>
                    <code class="fw-bold codigo-verificacion">${certificado.codigoVerificacion}</code>
                </div>
                <div class="col-6 text-end">
                    <p class="mb-0 text-muted small">Fecha de Expedición:</p>
                    <span class="fw-bold"><fmt:formatDate value="${certificado.fechaExpedicion}" pattern="dd 'de' MMMM 'de' yyyy" /></span>
                </div>
            </div>
        </div>
    </div>

</body>
</html>