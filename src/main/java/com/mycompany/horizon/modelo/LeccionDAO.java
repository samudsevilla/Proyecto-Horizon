package com.mycompany.horizon.modelo;

import com.mycompany.horizon.conexion.ConexionBD; 
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class LeccionDAO {

    // Obtener lección por su ID (incluye id_curso obtenido mediante JOIN)
    public Leccion obtenerPorId(int idLeccion) {
        Leccion lec = null;
        final String sql = "SELECT l.*, m.id_curso " +
                           "FROM lecciones l " +
                           "INNER JOIN modulos m ON l.id_modulo = m.id_modulo " +
                           "WHERE l.id_leccion = ?";

        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, idLeccion);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    lec = new Leccion();
                    lec.setIdLeccion(rs.getInt("id_leccion"));
                    lec.setIdModulo(rs.getInt("id_modulo"));
                    lec.setTitulo(rs.getString("titulo"));
                    lec.setContenidoTexto(rs.getString("contenido_texto"));
                    lec.setVideoUrl(rs.getString("url_video"));
                    lec.setOrden(rs.getInt("orden"));
                    
                    // Si tu clase Modulo o Leccion maneja el idCurso:
                    // lec.setIdCurso(rs.getInt("id_curso"));
                }
            }
        } catch (Exception e) {
            Logger.getLogger(LeccionDAO.class.getName()).log(Level.SEVERE, "Error al obtener lección por ID", e);
            e.printStackTrace();
        }
        return lec;
    }

    // Obtener el id_curso al que pertenece una lección
    public int obtenerIdCursoPorLeccion(int idLeccion) {
        int idCurso = 0;
        final String sql = "SELECT m.id_curso FROM lecciones l " +
                           "INNER JOIN modulos m ON l.id_modulo = m.id_modulo " +
                           "WHERE l.id_leccion = ?";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idLeccion);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    idCurso = rs.getInt("id_curso");
                }
            }
        } catch (Exception e) {
            Logger.getLogger(LeccionDAO.class.getName()).log(Level.SEVERE, "Error al obtener id_curso por lección", e);
        }
        return idCurso;
    }

    // Obtener módulos con sus lecciones por ID de Curso
    public List<Modulo> obtenerModulosPorCurso(int idCurso) {
        List<Modulo> modulos = new ArrayList<>();
        final String sqlMod = "SELECT * FROM modulos WHERE id_curso = ? ORDER BY id_modulo ASC";

        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement psMod = con.prepareStatement(sqlMod)) {
            
            psMod.setInt(1, idCurso);
            try (ResultSet rsMod = psMod.executeQuery()) {
                while (rsMod.next()) {
                    Modulo mod = new Modulo();
                    mod.setIdModulo(rsMod.getInt("id_modulo"));
                    mod.setIdCurso(rsMod.getInt("id_curso"));
                    mod.setTitulo(rsMod.getString("titulo"));

                    // Cargar lecciones correspondientes
                    mod.setLecciones(obtenerLeccionesPorModulo(mod.getIdModulo()));
                    modulos.add(mod);
                }
            }
        } catch (Exception e) {
            Logger.getLogger(LeccionDAO.class.getName()).log(Level.SEVERE, "Error al obtener módulos del curso ID: " + idCurso, e);
            e.printStackTrace();
        }
        return modulos;
    }

    // Obtener lecciones de un módulo
    public List<Leccion> obtenerLeccionesPorModulo(int idModulo) {
        List<Leccion> lecciones = new ArrayList<>();
        final String sqlLec = "SELECT * FROM lecciones WHERE id_modulo = ? ORDER BY orden ASC";

        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement psLec = con.prepareStatement(sqlLec)) {
            
            psLec.setInt(1, idModulo);
            try (ResultSet rsLec = psLec.executeQuery()) {
                while (rsLec.next()) {
                    Leccion lec = new Leccion();
                    lec.setIdLeccion(rsLec.getInt("id_leccion"));
                    lec.setIdModulo(rsLec.getInt("id_modulo"));
                    lec.setTitulo(rsLec.getString("titulo"));
                    lec.setContenidoTexto(rsLec.getString("contenido_texto"));
                    lec.setVideoUrl(rsLec.getString("url_video"));
                    lec.setOrden(rsLec.getInt("orden"));
                    lecciones.add(lec);
                }
            }
        } catch (Exception e) {
            Logger.getLogger(LeccionDAO.class.getName()).log(Level.SEVERE, "Error al obtener las lecciones del módulo ID: " + idModulo, e);
            e.printStackTrace();
        }
        return lecciones;
    }
    
    /**
     * Obtiene el ID de la primera lección correspondiente a un curso específico.
     * @param idCurso El ID del curso a consultar.
     * @return El id_leccion de la primera lección, o 1 si no se encuentra.
     */
    public int obtenerPrimeraLeccionPorCurso(int idCurso) {
        String sql = "SELECT l.id_leccion " +
                     "FROM lecciones l " +
                     "INNER JOIN modulos m ON l.id_modulo = m.id_modulo " +
                     "WHERE m.id_curso = ? " +
                     "ORDER BY m.orden ASC, l.orden ASC LIMIT 1";

        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idCurso);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("id_leccion");
                }
            }
        } catch (Exception e) {
            System.out.println("❌ Error al obtener la primera lección del curso: " + e.getMessage());
            e.printStackTrace();
        }
        return 1; // Retorno por defecto si ocurre algún error o no hay lecciones
    }
    
}