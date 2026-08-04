
package com.mycompany.horizon.controlador;
import com.mycompany.horizon.modelo.Usuario;
import com.mycompany.horizon.modelo.UsuarioDAO;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Windows
 */
@WebServlet(name = "RegistroServlet", urlPatterns = {"/RegistroServlet"})
public class RegistroServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegistroServlet</title>");
            out.println("</head>");
            out.println("<body>");
            //out.println("<h1>Servlet RegistroServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 1. Capturar campos
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        UsuarioDAO dao = new UsuarioDAO();

        // 2. Validaciones básicas
        if (nombre == null || email == null || password == null ||
            nombre.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty()) {

            request.setAttribute("error", "Por favor completa todos los campos.");
            request.getRequestDispatcher("vistas/auth/registro.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Las contraseñas no coinciden.");
            request.getRequestDispatcher("vistas/auth/registro.jsp").forward(request, response);
            return;
        }

        if (dao.existeCorreo(email)) {
            request.setAttribute("error", "El correo ingresado ya está registrado.");
            request.getRequestDispatcher("vistas/auth/registro.jsp").forward(request, response);
            return;
        }

        // 3. Generar código de verificación de 6 dígitos
        String codigo = String.format("%06d", new java.util.Random().nextInt(1000000));

        // 4. Crear objeto Usuario y registrar
        Usuario nuevo = new Usuario();
        nuevo.setNombre(nombre.trim());
        nuevo.setEmail(email.trim());
        nuevo.setPassword(password);
        nuevo.setRol("ESTUDIANTE");
        nuevo.setVerificado(false);
        nuevo.setCodigoVerificacion(codigo);

        boolean exito = dao.registrar(nuevo);

        if (exito) {
            // Enviar correo con código de verificación
            com.mycompany.horizon.conexion.EmailUtil.enviarCodigoVerificacion(email.trim(), codigo);
            
            // Redirige al flujo de verificación
            response.sendRedirect("vistas/auth/verificar.jsp?email=" + java.net.URLEncoder.encode(email.trim(), "UTF-8"));
        } else {
            request.setAttribute("error", "Ocurrió un error al registrar el usuario en la BD.");
            request.getRequestDispatcher("vistas/auth/registro.jsp").forward(request, response);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
