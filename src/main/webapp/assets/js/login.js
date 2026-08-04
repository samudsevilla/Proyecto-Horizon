document.addEventListener("DOMContentLoaded", () => {
    const loginForm = document.querySelector(".auth-form");
    const alertBox = document.getElementById("alert-message");

    if (!loginForm) return;

    // Mostrar alertas según parámetros de URL
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get("verificado") === "1") {
        alertBox.textContent = "✅ ¡Cuenta verificada con éxito! Inicia sesión.";
        alertBox.className = "alert alert-success";
        alertBox.style.display = "flex";
    } else if (urlParams.get("recuperado") === "1") {
        alertBox.textContent = "✅ ¡Contraseña restablecida con éxito! Inicia sesión.";
        alertBox.className = "alert alert-success";
        alertBox.style.display = "flex";
    }

    loginForm.addEventListener("submit", async (e) => {
        e.preventDefault(); // Detiene el envío tradicional/recarga de página

        // Ocultamos la alerta previa si existía
        alertBox.style.display = "none";
        alertBox.className = "alert";

        // Preparamos los datos del formulario
        const formData = new FormData(loginForm);
        const params = new URLSearchParams(formData);

        try {
            const response = await fetch(loginForm.action, {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"
                },
                body: params
            });

            if (!response.ok) {
                throw new Error("Error en la respuesta del servidor");
            }

            const data = await response.json();

            if (data.status === "error") {
                // Mostrar alerta de error
                alertBox.textContent = "⚠️ " + data.message;
                alertBox.classList.add("alert-error");
                alertBox.style.display = "flex";
            } else if (data.status === "success") {
                // Redirigir al dashboard/home tras login exitoso
                window.location.href = data.redirectUrl;
            } else if (data.status === "unverified") {
                // Mostrar alerta y redirigir a verificación
                alertBox.textContent = "⚠️ " + data.message;
                alertBox.className = "alert alert-warning";
                alertBox.style.display = "flex";
                setTimeout(() => {
                    window.location.href = data.redirectUrl;
                }, 2500);
            }
        } catch (error) {
            console.error("Error al procesar el login:", error);
            alertBox.textContent = "⚠️ Ocurrió un error de conexión con el servidor.";
            alertBox.classList.add("alert-error");
            alertBox.style.display = "flex";
        }
    });
});