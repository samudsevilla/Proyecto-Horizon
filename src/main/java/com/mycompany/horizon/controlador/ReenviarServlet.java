package com.mycompany.horizon.controlador;

import com.mycompany.horizon.conexion.EmailUtil;
import com.mycompany.horizon.modelo.UsuarioDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ReenviarServlet", urlPatterns = {"/ReenviarServlet"})
public class ReenviarServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/vistas/auth/login.jsp");
            return;
        }

        String nuevoCodigo = String.format("%06d", new java.util.Random().nextInt(1000000));
        UsuarioDAO dao = new UsuarioDAO();

        boolean exito = dao.actualizarCodigoVerificacion(email.trim(), nuevoCodigo);

        if (exito) {
            EmailUtil.enviarCodigoVerificacion(email.trim(), nuevoCodigo);
            response.sendRedirect(request.getContextPath() + "/vistas/auth/verificar.jsp?email=" + java.net.URLEncoder.encode(email.trim(), "UTF-8") + "&reenviado=1");
        } else {
            response.sendRedirect(request.getContextPath() + "/vistas/auth/verificar.jsp?email=" + java.net.URLEncoder.encode(email.trim(), "UTF-8") + "&error=No+se+pudo+generar+un+nuevo+codigo");
        }
    }
}
