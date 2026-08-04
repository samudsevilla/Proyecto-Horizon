package com.mycompany.horizon.modelo;


import com.mycompany.horizon.conexion.ConexionBD;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CertificadoDAO {

    // Obtener las certificaciones de un usuario con los nombres exactos de tu BD
    public List<Certificado> obtenerPorUsuario(int idUsuario) {
        List<Certificado> lista = new ArrayList<>();

        // --- ESTO TE DIRÁ EXACTAMENTE QUÉ ID ESTÁ CONSULTANDO ---
        System.out.println(">>> EJECUTANDO obtenerPorUsuario PARA EL ID: " + idUsuario);

        String sql = "SELECT c.id_certificacion, c.id_usuario, c.id_curso, cur.titulo AS nombre_curso, " +
                     "c.codigo_verificacion, COALESCE(c.fecha_expedicion, NOW()) AS fecha_expedicion " +
                     "FROM certificaciones c " +
                     "INNER JOIN cursos cur ON c.id_curso = cur.id_curso " +
                     "WHERE c.id_usuario = ? ORDER BY c.fecha_expedicion DESC";

        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Certificado cert = new Certificado();
                    cert.setIdCertificacion(rs.getInt("id_certificacion"));
                    cert.setIdUsuario(rs.getInt("id_usuario"));
                    cert.setIdCurso(rs.getInt("id_curso"));
                    cert.setNombreCurso(rs.getString("nombre_curso"));
                    cert.setCodigoVerificacion(rs.getString("codigo_verificacion"));
                    cert.setFechaExpedicion(rs.getTimestamp("fecha_expedicion"));
                    lista.add(cert);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Si hay error SQL, saldrá aquí en la consola
        }

        System.out.println(">>> TOTAL DE CERTIFICADOS ENCONTRADOS: " + lista.size());
        return lista;
    }

    // Generar un registro en 'certificaciones' si el curso fue completado
    public boolean generarCertificadoSiNoExiste(int idUsuario, int idCurso) {
        String checkSql = "SELECT COUNT(*) FROM certificaciones WHERE id_usuario = ? AND id_curso = ?";
        String insertSql = "INSERT INTO certificaciones (id_usuario, id_curso, codigo_verificacion) VALUES (?, ?, ?)";

        try (Connection con = ConexionBD.obtenerConexion()) {
            try (PreparedStatement psCheck = con.prepareStatement(checkSql)) {
                psCheck.setInt(1, idUsuario);
                psCheck.setInt(2, idCurso);
                ResultSet rs = psCheck.executeQuery();
                if (rs.next() && rs.getInt(1) > 0) {
                    return false; // Ya tiene certificado para este curso
                }
            }

            String codigo = "HZ-" + (int)(Math.random() * 900000 + 100000); // Ej: HZ-584932

            try (PreparedStatement psInsert = con.prepareStatement(insertSql)) {
                psInsert.setInt(1, idUsuario);
                psInsert.setInt(2, idCurso);
                psInsert.setString(3, codigo);
                return psInsert.executeUpdate() > 0;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean verificarYGenerarCertificado(int idUsuario, int idEvaluacion) {
        String sqlCurso = "SELECT m.id_curso FROM modulos m " +
                          "INNER JOIN evaluaciones e ON m.id_modulo = e.id_modulo " +
                          "WHERE e.id_evaluacion = ?";
        
        String sqlTotalEval = "SELECT COUNT(*) FROM evaluaciones e " +
                              "INNER JOIN modulos m ON e.id_modulo = m.id_modulo " +
                              "WHERE m.id_curso = ?";
        
        String sqlAprobadas = "SELECT COUNT(DISTINCT re.id_evaluacion) FROM resultados_evaluacion re " +
                              "INNER JOIN evaluaciones e ON re.id_evaluacion = e.id_evaluacion " +
                              "INNER JOIN modulos m ON e.id_modulo = m.id_modulo " +
                              "WHERE re.id_usuario = ? AND m.id_curso = ? AND re.aprobado = 1";
        
        try (Connection con = ConexionBD.obtenerConexion()) {
            int idCurso = 0;
            try (PreparedStatement ps = con.prepareStatement(sqlCurso)) {
                ps.setInt(1, idEvaluacion);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        idCurso = rs.getInt("id_curso");
                    }
                }
            }
            
            if (idCurso == 0) return false;
            
            int totalEval = 0;
            try (PreparedStatement ps = con.prepareStatement(sqlTotalEval)) {
                ps.setInt(1, idCurso);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        totalEval = rs.getInt(1);
                    }
                }
            }
            
            int aprobadas = 0;
            try (PreparedStatement ps = con.prepareStatement(sqlAprobadas)) {
                ps.setInt(1, idUsuario);
                ps.setInt(2, idCurso);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        aprobadas = rs.getInt(1);
                    }
                }
            }
            
            if (totalEval > 0 && aprobadas == totalEval) {
                // Generar el certificado si no existe
                return generarCertificadoSiNoExiste(idUsuario, idCurso);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}