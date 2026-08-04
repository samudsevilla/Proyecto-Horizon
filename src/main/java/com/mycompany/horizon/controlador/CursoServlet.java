/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.horizon.controlador;

import com.mycompany.horizon.modelo.Usuario;
import com.mycompany.horizon.modelo.CursoDAO;
import com.mycompany.horizon.modelo.Curso;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Windows
 */
@WebServlet(name = "CursoServlet", urlPatterns = {"/CursoServlet"})
public class CursoServlet extends HttpServlet {
    // Instancia del DAO
    private CursoDAO cursoDAO = new CursoDAO();

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
            out.println("<title>Servlet CursoServlet</title>");
            out.println("</head>");
            out.println("<body>");
            //out.println("<h1>Servlet CursoServlet at " + request.getContextPath() + "</h1>");
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
        HttpSession session = request.getSession(false);
        Usuario usuario = (Usuario) session.getAttribute("usuario");

        int idUsuario = (usuario != null) ? usuario.getIdUsuario() : 0;
        String accion = request.getParameter("accion");

        // Manejo de la acción inscribir
        if ("inscribir".equals(accion)) {
            String idCursoParam = request.getParameter("idCurso");
            System.out.println("=== INTENTO DE INSCRIPCIÓN ===");
            System.out.println("ID Usuario recibido en sesión: " + idUsuario);
            System.out.println("ID Curso recibido por parámetro: " + idCursoParam);

            if (idCursoParam != null) {
                int idCurso = Integer.parseInt(idCursoParam);

                // Si idUsuario es 0 durante las pruebas, puedes forzar un ID provisional de prueba (ejemplo: 1)
                if (idUsuario == 0) {
                    idUsuario = 1; // ID de usuario por defecto para pruebas si no te has logueado
                }

                boolean exito = cursoDAO.inscribirUsuario(idUsuario, idCurso);
                System.out.println("=== RESULTADO INSCRIPCIÓN BD: " + exito);

                response.sendRedirect(request.getContextPath() + "/LeccionServlet?idCurso=" + idCurso);
                return;
            }
        }

        // Obtener la lista actualizada de cursos y enviarla a la vista
        List<Curso> cursos = cursoDAO.listarCursos(idUsuario);
        System.out.println("=== CURSOS ENCONTRADOS EN BD: " + cursos.size()); // Imprime en la consola
        request.setAttribute("cursos", cursos);

        // Redirigir a catalogo.jsp dentro de vistas/cursos/
        request.getRequestDispatcher("/vistas/cursos/catalogo.jsp").forward(request, response);
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
        processRequest(request, response);
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
