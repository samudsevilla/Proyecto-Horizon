<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Horizon - Cambiar Contraseña</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/assets/css/auth.css">
    <style>
        .code-input-container {
            display: flex;
            justify-content: center;
            gap: 0.5rem;
            margin: 1rem 0 1.5rem 0;
        }
        .code-digit {
            width: 42px;
            height: 50px;
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
    </style>
</head>
<body class="auth-body">
    <div class="auth-card" style="max-width: 440px;">
        <!-- Botón Volver -->
        <div class="auth-back" style="text-align: left; margin-bottom: 1rem;">
            <a href="${pageContext.request.contextPath}/vistas/auth/recuperar.jsp" style="text-decoration: none; color: #64748b; font-size: 0.875rem; display: inline-flex; align-items: center; gap: 0.3rem;">
                &#8592; Regresar
            </a>
        </div>

        <!-- Logo -->
        <div class="auth-header">
            <h1 class="logo-text">Horizon<span>.</span></h1>
            <p class="auth-subtitle">Restablecer Contraseña</p>
        </div>

        <h2>Nueva Contraseña</h2>
        <p style="color: #64748b; font-size: 0.875rem; text-align: center; margin-bottom: 1.5rem;">
            Ingresa el código enviado a tu correo y escribe tu nueva contraseña.
        </p>

        <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-error">
                ⚠️ <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <form action="${pageContext.request.contextPath}/CambiarPasswordServlet" method="POST" class="auth-form">
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
                <input type="hidden" id="codigoCompleto" name="codigo" value="">
            </div>

            <div class="form-group">
                <label for="password">Nueva Contraseña</label>
                <input type="password" id="password" name="password" placeholder="Mínimo 6 caracteres" required minlength="6">
            </div>

            <div class="form-group">
                <label for="confirmPassword">Confirmar Nueva Contraseña</label>
                <input type="password" id="confirmPassword" name="confirmPassword" placeholder="••••••••" required>
            </div>

            <button type="submit" class="btn-primary" style="margin-top: 1rem;">Guardar Contraseña</button>
        </form>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const digits = document.querySelectorAll('.code-digit');
            const form = document.querySelector('form');
            const hiddenCode = document.getElementById('codigoCompleto');
            const pass = document.getElementById('password');
            const confirmPass = document.getElementById('confirmPassword');

            // Navegación inteligente
            digits.forEach((digit, idx) => {
                digit.addEventListener('input', (e) => {
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
                    return;
                }
                if (pass.value !== confirmPass.value) {
                    e.preventDefault();
                    alert('Las contraseñas no coinciden.');
                }
            });
        });
    </script>
</body>
</html>
