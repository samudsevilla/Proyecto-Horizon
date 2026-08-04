package com.mycompany.horizon.controlador;

import com.mycompany.horizon.conexion.EmailUtil;
import com.mycompany.horizon.modelo.UsuarioDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "RecuperarPasswordServlet", urlPatterns = {"/RecuperarPasswordServlet"})
public class RecuperarPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Por favor ingresa tu correo electrónico.");
            request.getRequestDispatcher("/vistas/auth/recuperar.jsp").forward(request, response);
            return;
        }

        UsuarioDAO dao = new UsuarioDAO();
        if (!dao.existeCorreo(email.trim())) {
            request.setAttribute("error", "El correo ingresado no está registrado en Horizon.");
            request.getRequestDispatcher("/vistas/auth/recuperar.jsp").forward(request, response);
            return;
        }

        // Generar código de 6 dígitos
        String codigo = String.format("%06d", new java.util.Random().nextInt(1000000));
        
        // Guardar código en la base de datos
        boolean guardado = dao.actualizarCodigoVerificacion(email.trim(), codigo);

        if (guardado) {
            // Enviar correo
            EmailUtil.enviarCodigoVerificacion(email.trim(), codigo);
            // Redirigir a verificar y cambiar clave
            response.sendRedirect(request.getContextPath() + "/vistas/auth/recuperar_verificar.jsp?email=" + java.net.URLEncoder.encode(email.trim(), "UTF-8"));
        } else {
            request.setAttribute("error", "Ocurrió un error al procesar tu solicitud.");
            request.getRequestDispatcher("/vistas/auth/recuperar.jsp").forward(request, response);
        }
    }
}
