/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.horizon.controlador;

import com.mycompany.horizon.modelo.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Windows
 */
public class RutaServlet extends HttpServlet {

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
            out.println("<title>Servlet RutaServlet</title>");
            out.println("</head>");
            out.println("<body>");
            //out.println("<h1>Servlet RutaServlet at " + request.getContextPath() + "</h1>");
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
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/vistas/auth/login.jsp");
            return;
        }

        com.mycompany.horizon.modelo.CursoDAO cursoDAO = new com.mycompany.horizon.modelo.CursoDAO();
        java.util.List<com.mycompany.horizon.modelo.Curso> cursos = cursoDAO.obtenerCursosEnProgreso(usuario.getIdUsuario());

        int pJava = 0;
        int idLecJava = 107;
        boolean inscritoJava = false;

        int pCiber = 0;
        int pServ = 0;
        int idLecCiber = 23;
        int idLecServ = 1;
        boolean inscritoCiber = false;
        boolean inscritoServ = false;

        for (com.mycompany.horizon.modelo.Curso c : cursos) {
            if (c.getIdCurso() == 3) {
                pJava = c.getProgreso();
                idLecJava = c.getIdUltimaLeccion();
                inscritoJava = true;
            } else if (c.getIdCurso() == 2) {
                pCiber = c.getProgreso();
                idLecCiber = c.getIdUltimaLeccion();
                inscritoCiber = true;
            } else if (c.getIdCurso() == 1) {
                pServ = c.getProgreso();
                idLecServ = c.getIdUltimaLeccion();
                inscritoServ = true;
            }
        }

        // Promedio de Ciberseguridad e Infraestructura (Cursos 1 y 2)
        int progresoCiberSeg = 0;
        if (inscritoCiber || inscritoServ) {
            progresoCiberSeg = (pCiber + pServ) / 2;
        }

        // Consultar certificados asociados
        int idCertJava = obtenerIdCertificacion(usuario.getIdUsuario(), 3);
        int idCertCiber = obtenerIdCertificacion(usuario.getIdUsuario(), 2);
        int idCertServ = obtenerIdCertificacion(usuario.getIdUsuario(), 1);

        java.util.List<com.mycompany.horizon.modelo.Ruta> rutas = new java.util.ArrayList<>();
        
        // Ruta 1: Java
        rutas.add(new com.mycompany.horizon.modelo.Ruta(
            "Ruta Developer Java",
            "Domina la sintaxis de Java, POO, bases de datos SQL y arquitectura web MVC.",
            "Backend",
            1, // Cursos en la ruta
            pJava,
            idLecJava,
            "primary",
            idCertJava
        ));

        // Ruta 2: Ciberseguridad
        rutas.add(new com.mycompany.horizon.modelo.Ruta(
            "Especialista en Ciberseguridad",
            "Fundamentos de redes, prevención de amenazas y aseguramiento de servidores.",
            "Seguridad",
            2, // Cursos en la ruta
            progresoCiberSeg,
            idLecCiber,
            "danger",
            idCertCiber
        ));

        // Ruta 3: Arquitectura de Servidores e Infraestructura
        rutas.add(new com.mycompany.horizon.modelo.Ruta(
            "Arquitectura de Servidores e Infraestructura",
            "Diseño de topologías de red, balanceo de carga y administración de servidores web.",
            "Infraestructura",
            1, // Cursos en la ruta
            pServ,
            idLecServ,
            "success",
            idCertServ
        ));

        request.setAttribute("rutas", rutas);
        request.setAttribute("usuario", usuario);
        request.getRequestDispatcher("/vistas/rutas/rutas.jsp").forward(request, response);
    }

    private int obtenerIdCertificacion(int idUsuario, int idCurso) {
        String sql = "SELECT id_certificacion FROM certificaciones WHERE id_usuario = ? AND id_curso = ?";
        try (java.sql.Connection con = com.mycompany.horizon.conexion.ConexionBD.obtenerConexion();
             java.sql.PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            ps.setInt(2, idCurso);
            try (java.sql.ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("id_certificacion");
                }
            }
        } catch (java.sql.SQLException e) {
            e.printStackTrace();
        }
        return 0;
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
