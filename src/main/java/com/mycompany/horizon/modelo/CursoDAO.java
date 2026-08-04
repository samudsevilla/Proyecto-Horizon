package com.mycompany.horizon.modelo;

import com.mycompany.horizon.conexion.ConexionBD; 
import com.mycompany.horizon.modelo.Curso;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CursoDAO {

    // Obtener todos los cursos con el total de módulos e inscripción real del usuario
    public List<Curso> listarCursos(int idUsuario) {
        List<Curso> lista = new ArrayList<>();
        
        // Consulta SQL con subconsultas para total_modulos y estado de inscripción
        String sql = "SELECT c.*, " +
                     "(SELECT COUNT(*) FROM modulos m WHERE m.id_curso = c.id_curso) AS total_modulos, " +
                     "(SELECT COUNT(*) FROM inscripciones i WHERE i.id_curso = c.id_curso AND i.id_usuario = ?) AS esta_inscrito " +
                     "FROM cursos c";

        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, idUsuario);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Curso c = new Curso();
                    c.setIdCurso(rs.getInt("id_curso"));
                    
                    String titulo = rs.getString("titulo");
                    c.setTitulo(titulo);
                    c.setDescripcion(rs.getString("descripcion"));
                    c.setImagenUrl(rs.getString("imagen_url"));

                    // --- CATEGORÍA CALCULADA SEGÚN EL TÍTULO ---
                    String tituloMinus = (titulo != null) ? titulo.toLowerCase() : "";
                    
                    if (tituloMinus.contains("ciberseguridad") || tituloMinus.contains("seguridad") || tituloMinus.contains("hacking")) {
                        c.setCategoria("Ciberseguridad");
                        c.setNivel("Principiante");
                    } else if (tituloMinus.contains("servidor") || tituloMinus.contains("red") || tituloMinus.contains("cloud") || tituloMinus.contains("infraestructura")) {
                        c.setCategoria("Infraestructura");
                        c.setNivel("Avanzado");
                    } else if (tituloMinus.contains("java") || tituloMinus.contains("programacion") || tituloMinus.contains("desarrollo") || tituloMinus.contains("code")) {
                        c.setCategoria("Programación");
                        c.setNivel("Principiante");
                    } else {
                        c.setCategoria("Tecnología");
                        c.setNivel("Todos los niveles");
                    }

                    // Valores dinámicos traídos desde la BD
                    c.setTotalModulos(rs.getInt("total_modulos"));
                    c.setInscrito(rs.getInt("esta_inscrito") > 0);

                    lista.add(c);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }   

    // Inscribir a un usuario en un curso
    public boolean inscribirUsuario(int idUsuario, int idCurso) {
        String sqlVerificar = "SELECT COUNT(*) FROM inscripciones WHERE id_usuario = ? AND id_curso = ?";
        String sqlInsert = "INSERT INTO inscripciones (id_usuario, id_curso) VALUES (?, ?)";

        try (Connection con = ConexionBD.obtenerConexion()) {
            
            // 1. Verificar si ya está inscrito
            try (PreparedStatement psVer = con.prepareStatement(sqlVerificar)) {
                psVer.setInt(1, idUsuario);
                psVer.setInt(2, idCurso);
                try (ResultSet rs = psVer.executeQuery()) {
                    if (rs.next() && rs.getInt(1) > 0) {
                        return true; // Ya estaba inscrito
                    }
                }
            }

            // 2. Si no lo está, insertamos
            try (PreparedStatement psIns = con.prepareStatement(sqlInsert)) {
                psIns.setInt(1, idUsuario);
                psIns.setInt(2, idCurso);
                return psIns.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Curso> obtenerCursosEnProgreso(int idUsuario) {
        List<Curso> lista = new ArrayList<>();
        String sql = "SELECT c.id_curso, c.titulo, " +
                     "(SELECT m.titulo FROM modulos m WHERE m.id_curso = c.id_curso ORDER BY m.orden ASC LIMIT 1) AS primer_modulo, " +
                     "(SELECT l.id_leccion FROM lecciones l INNER JOIN modulos m ON l.id_modulo = m.id_modulo WHERE m.id_curso = c.id_curso ORDER BY m.orden ASC, l.id_leccion ASC LIMIT 1) AS primera_leccion, " +
                     "(SELECT COUNT(*) FROM evaluaciones e INNER JOIN modulos m ON e.id_modulo = m.id_modulo WHERE m.id_curso = c.id_curso) AS total_eval, " +
                     "(SELECT COUNT(DISTINCT re.id_evaluacion) FROM resultados_evaluacion re INNER JOIN evaluaciones e ON re.id_evaluacion = e.id_evaluacion INNER JOIN modulos m ON e.id_modulo = m.id_modulo WHERE re.id_usuario = ? AND m.id_curso = c.id_curso AND re.aprobado = 1) AS aprobadas_eval " +
                     "FROM inscripciones i " +
                     "INNER JOIN cursos c ON i.id_curso = c.id_curso " +
                     "WHERE i.id_usuario = ?";
        
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, idUsuario);
            ps.setInt(2, idUsuario);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Curso c = new Curso();
                    c.setIdCurso(rs.getInt("id_curso"));
                    c.setTitulo(rs.getString("titulo"));
                    
                    int totalEval = rs.getInt("total_eval");
                    int aprobadasEval = rs.getInt("aprobadas_eval");
                    int progreso = (totalEval > 0) ? (aprobadasEval * 100 / totalEval) : 0;
                    c.setProgreso(progreso);
                    
                    String moduloActual = rs.getString("primer_modulo");
                    c.setModuloActual(moduloActual != null ? moduloActual : "Introducción");
                    
                    int idLeccion = rs.getInt("primera_leccion");
                    c.setIdUltimaLeccion(idLeccion);
                    
                    lista.add(c);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }
}