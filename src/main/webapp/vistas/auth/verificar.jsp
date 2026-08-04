<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Horizon - Verificar Cuenta</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/auth.css">
    <style>
        .code-input-container {
            display: flex;
            justify-content: center;
            gap: 0.5rem;
            margin: 1.5rem 0;
        }
        .code-digit {
            width: 45px;
            height: 55px;
            font-size: 1.5rem;
            text-align: center;
            border: 2px solid #cbd5e1;
            border-radius: 8px;
            outline: none;
            transition: all 0.2s ease-in-out;
            font-weight: bold;
        }
        .code-digit:focus {
            border-color: #2563eb;
            box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.15);
        }
        .alert-error {
            background-color: #fef2f2;
            border: 1px solid #fee2e2;
            color: #991b1b;
            padding: 0.75rem 1rem;
            border-radius: 8px;
            font-size: 0.875rem;
            display: flex;
            align-items: center;
        }
        .alert-success {
            background-color: #f0fdf4;
            border: 1px solid #dcfce7;
            color: #166534;
            padding: 0.75rem 1rem;
            border-radius: 8px;
            font-size: 0.875rem;
            display: flex;
            align-items: center;
        }
    </style>
</head>
<body class="auth-body">
    <div class="auth-card">
        <!-- Logo -->
        <div class="auth-header">
            <h1 class="logo-text">Horizon<span>.</span></h1>
            <p class="auth-subtitle">Verificación de Cuenta</p>
        </div>

        <h2>Ingresa tu código</h2>
        <p style="color: #64748b; font-size: 0.875rem; text-align: center; margin-bottom: 1.5rem;">
            Hemos enviado un código de verificación de 6 dígitos al correo:<br>
            <strong style="color: #1e293b;"><%= request.getParameter("email") != null ? request.getParameter("email") : "" %></strong>
        </p>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert-error" style="margin-bottom: 1rem;">
                ⚠️ <%= request.getAttribute("error") %>
            </div>
        <% } %>
        <% if (request.getParameter("reenviado") != null) { %>
            <div class="alert-success" style="margin-bottom: 1rem;">
                📧 Código reenviado con éxito. Revisa tu buzón.
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/VerificarServlet" method="POST" class="auth-form">
            <input type="hidden" name="email" value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
            
            <div class="form-group">
                <label style="text-align: center; display: block; font-weight: 500;">Código de 6 dígitos</label>
                <div class="code-input-container">
                    <input type="text" class="code-digit" maxlength="1" required autocomplete="off">
                    <input type="text" class="code-digit" maxlength="1" required autocomplete="off">
                    <input type="text" class="code-digit" maxlength="1" required autocomplete="off">
                    <input type="text" class="code-digit" maxlength="1" required autocomplete="off">
                    <input type="text" class="code-digit" maxlength="1" required autocomplete="off">
                    <input type="text" class="code-digit" maxlength="1" required autocomplete="off">
                </div>
                <!-- Campo oculto para mandar el código completo -->
                <input type="hidden" id="codigoCompleto" name="codigo" value="">
            </div>

            <button type="submit" class="btn-primary" style="margin-top: 1rem;">Verificar Cuenta</button>
        </form>

        <div class="auth-footer" style="margin-top: 1.5rem;">
            <p>¿No recibiste el código? <a href="${pageContext.request.contextPath}/ReenviarServlet?email=<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">Reenviar código</a></p>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const digits = document.querySelectorAll('.code-digit');
            const form = document.querySelector('form');
            const hiddenCode = document.getElementById('codigoCompleto');

            // Auto-focus y movimiento inteligente entre inputs de dígitos
            digits.forEach((digit, idx) => {
                digit.addEventListener('input', (e) => {
                    // Permitir solo números
                    digit.value = digit.value.replace(/[^0-9]/g, '');

                    if (digit.value.length === 1 && idx < digits.length - 1) {
                        digits[idx + 1].focus();
                    }
                    actualizarCodigo();
                });

                digit.addEventListener('keydown', (e) => {
                    if (e.key === 'Backspace' && digit.value.length === 0 && idx > 0) {
                        digits[idx - 1].focus();
                    }
                });

                digit.addEventListener('paste', (e) => {
                    e.preventDefault();
                    const pasteData = e.clipboardData.getData('text').trim();
                    if (/^\d{6}$/.test(pasteData)) {
                        for (let i = 0; i < digits.length; i++) {
                            digits[i].value = pasteData[i];
                        }
                        hiddenCode.value = pasteData;
                        digits[digits.length - 1].focus();
                    }
                });
            });

            function actualizarCodigo() {
                let code = '';
                digits.forEach(d => code += d.value);
                hiddenCode.value = code;
            }

            form.addEventListener('submit', (e) => {
                actualizarCodigo();
                if (hiddenCode.value.length !== 6) {
                    e.preventDefault();
                    alert('Por favor ingresa los 6 dígitos del código.');
                }
            });
        });
    </script>
</body>
</html>
