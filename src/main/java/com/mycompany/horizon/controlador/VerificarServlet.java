package com.mycompany.horizon.controlador;

import com.mycompany.horizon.modelo.UsuarioDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "VerificarServlet", urlPatterns = {"/VerificarServlet"})
public class VerificarServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String email = request.getParameter("email");
        String codigo = request.getParameter("codigo");

        if (email == null || codigo == null || email.trim().isEmpty() || codigo.trim().isEmpty()) {
            request.setAttribute("error", "Datos de verificación incompletos.");
            request.getRequestDispatcher("/vistas/auth/verificar.jsp").forward(request, response);
            return;
        }

        UsuarioDAO dao = new UsuarioDAO();
        boolean verificado = dao.verificarUsuario(email.trim(), codigo.trim());

        if (verificado) {
            response.sendRedirect(request.getContextPath() + "/vistas/auth/login.jsp?verificado=1");
        } else {
            request.setAttribute("error", "El código ingresado es incorrecto o ha expirado.");
            request.getRequestDispatcher("/vistas/auth/verificar.jsp").forward(request, response);
        }
    }
}
