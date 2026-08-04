/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.horizon.controlador;

import com.mycompany.horizon.modelo.Certificado;
import com.mycompany.horizon.modelo.Usuario;
import com.mycompany.horizon.conexion.ConexionBD;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
@WebServlet(name = "DescargarCertificadoServlet", urlPatterns = {"/DescargarCertificadoServlet"})
public class DescargarCertificadoServlet extends HttpServlet {

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
            out.println("<title>Servlet DescargarCertificadoServlet</title>");
            out.println("</head>");
            out.println("<body>");
            //out.println("<h1>Servlet DescargarCertificadoServlet at " + request.getContextPath() + "</h1>");
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

        String idCertStr = request.getParameter("id");
        if (idCertStr == null || idCertStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/CertificadoServlet");
            return;
        }

        int idCertificacion = Integer.parseInt(idCertStr.trim());
        Certificado cert = null;

        // Consultar detalles del certificado y del curso
        String sql = "SELECT c.id_certificacion, c.id_usuario, c.id_curso, cur.titulo AS nombre_curso, " +
                     "c.codigo_verificacion, c.fecha_expedicion, u.nombre AS nombre_usuario " +
                     "FROM certificaciones c " +
                     "INNER JOIN cursos cur ON c.id_curso = cur.id_curso " +
                     "INNER JOIN usuarios u ON c.id_usuario = u.id_usuario " +
                     "WHERE c.id_certificacion = ? AND c.id_usuario = ?";

        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, idCertificacion);
            ps.setInt(2, usuario.getIdUsuario());
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    cert = new Certificado();
                    cert.setIdCertificacion(rs.getInt("id_certificacion"));
                    cert.setNombreCurso(rs.getString("nombre_curso"));
                    cert.setCodigoVerificacion(rs.getString("codigo_verificacion"));
                    cert.setFechaExpedicion(rs.getTimestamp("fecha_expedicion"));
                    // Guardamos temporalmente el nombre del alumno para mostrarlo en el diploma
                    request.setAttribute("nombreAlumno", rs.getString("nombre_usuario"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (cert == null) {
            response.sendRedirect(request.getContextPath() + "/CertificadoServlet");
            return;
        }

        request.setAttribute("certificado", cert);
        // Redirige a una vista bonita diseñada exclusivamente para imprimirse o guardarse como PDF
        request.getRequestDispatcher("/vistas/certificados/plantilla_certificado.jsp").forward(request, response);
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
