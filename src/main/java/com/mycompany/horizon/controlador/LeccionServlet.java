/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.horizon.controlador;

import com.mycompany.horizon.modelo.Leccion;
import com.mycompany.horizon.modelo.LeccionDAO;
import com.mycompany.horizon.modelo.Modulo;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author Windows
 */
@WebServlet(name = "LeccionServlet", urlPatterns = {"/LeccionServlet"})
public class LeccionServlet extends HttpServlet {

    private LeccionDAO leccionDAO = new LeccionDAO();
    
    
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
            out.println("<title>Servlet LeccionServlet</title>");
            out.println("</head>");
            out.println("<body>");
            //out.println("<h1>Servlet LeccionServlet at " + request.getContextPath() + "</h1>");
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

        if (leccionDAO == null) {
            try {
                leccionDAO = new LeccionDAO();
            } catch (Exception e) {
                System.out.println("❌ Error al instanciar LeccionDAO: " + e.getMessage());
                e.printStackTrace();
            }
        }

        // 1. Capturar ambos parámetros posibles de la URL
        String idLeccionStr = request.getParameter("id");      // Viene desde el Dashboard
        String idCursoStr = request.getParameter("idCurso");  // Viene desde el Catálogo o CursoServlet

        int idLeccion = 0;
        int idCurso = 0;

        // Escenario A: Si nos están enviando el idCurso (ej. /LeccionServlet?idCurso=2)
        if (idCursoStr != null && !idCursoStr.trim().isEmpty()) {
            try {
                idCurso = Integer.parseInt(idCursoStr);
                // Buscamos dinámicamente cuál es la primera lección de ese curso
                idLeccion = leccionDAO.obtenerPrimeraLeccionPorCurso(idCurso);
            } catch (NumberFormatException e) {
                System.out.println("❌ Error de formato en idCurso: " + idCursoStr);
            }
        }

        // Escenario B: Si no vino idCurso o viene un ID de lección explícito (ej. /LeccionServlet?id=27)
        if (idLeccion == 0 && idLeccionStr != null && !idLeccionStr.trim().isEmpty()) {
            try {
                idLeccion = Integer.parseInt(idLeccionStr);
            } catch (NumberFormatException e) {
                System.out.println("❌ Error de formato en idLeccion: " + idLeccionStr);
            }
        }

        // Fallback de seguridad por si ambos parámetros fallaron o venían vacíos
        if (idLeccion == 0) {
            idLeccion = 1;
        }

        // 2. Obtener la lección activa de la BD
        Leccion leccion = null;
        if (leccionDAO != null) {
            leccion = leccionDAO.obtenerPorId(idLeccion);
        }

        System.out.println("=== LECCION SERVLET ===");
        System.out.println("Parametro idCurso recibido: " + idCursoStr);
        System.out.println("Parametro id (leccion) recibido: " + idLeccionStr);
        System.out.println("ID Leccion final cargada: " + idLeccion);

        if (leccion != null) {
            try {
                // 3. Si aún no sabemos el idCurso, lo deducimos a partir de la lección cargada
                if (idCurso == 0) {
                    idCurso = leccionDAO.obtenerIdCursoPorLeccion(idLeccion);
                }

                // Si la lección no estaba asociada a ningún módulo válido
                if (idCurso == 0) {
                    idCurso = 1;
                }

                // 4. Cargar módulos y lecciones para el temario lateral
                List<Modulo> modulos = leccionDAO.obtenerModulosPorCurso(idCurso);
                request.setAttribute("modulos", modulos);
            } catch (Exception e) {
                System.out.println("❌ Error al cargar módulos: " + e.getMessage());
                e.printStackTrace();
            }

            request.setAttribute("leccion", leccion);
            request.getRequestDispatcher("/vistas/cursos/ver-leccion.jsp").forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/HomeServlet");
        }
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
