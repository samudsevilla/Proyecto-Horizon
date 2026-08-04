package com.mycompany.horizon.controlador;

import com.mycompany.horizon.modelo.UsuarioDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "CambiarPasswordServlet", urlPatterns = {"/CambiarPasswordServlet"})
public class CambiarPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String email = request.getParameter("email");
        String codigo = request.getParameter("codigo");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (email == null || codigo == null || password == null || confirmPassword == null ||
            email.trim().isEmpty() || codigo.trim().isEmpty() || password.trim().isEmpty() || confirmPassword.trim().isEmpty()) {
            
            request.setAttribute("error", "Por favor completa todos los campos.");
            request.getRequestDispatcher("/vistas/auth/recuperar_verificar.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Las contraseñas no coinciden.");
            request.getRequestDispatcher("/vistas/auth/recuperar_verificar.jsp").forward(request, response);
            return;
        }

        UsuarioDAO dao = new UsuarioDAO();
        boolean exito = dao.restablecerPassword(email.trim(), codigo.trim(), password);

        if (exito) {
            response.sendRedirect(request.getContextPath() + "/vistas/auth/login.jsp?recuperado=1");
        } else {
            request.setAttribute("error", "El código ingresado es incorrecto o ha expirado.");
            request.getRequestDispatcher("/vistas/auth/recuperar_verificar.jsp").forward(request, response);
        }
    }
}
