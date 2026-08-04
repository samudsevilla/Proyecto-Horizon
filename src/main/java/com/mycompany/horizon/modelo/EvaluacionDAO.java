package com.mycompany.horizon.modelo;

import com.mycompany.horizon.conexion.ConexionBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class EvaluacionDAO {

    public Evaluacion obtenerPorModulo(int idModulo) {
        String sql = "SELECT * FROM evaluaciones WHERE id_modulo = ?";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, idModulo);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Evaluacion eval = new Evaluacion();
                    eval.setIdEvaluacion(rs.getInt("id_evaluacion"));
                    eval.setIdModulo(rs.getInt("id_modulo"));
                    eval.setTitulo(rs.getString("titulo"));
                    return eval;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error en obtenerPorModulo: " + e.getMessage());
        }
        return null;
    }

    public boolean guardarResultado(int idUsuario, int idEvaluacion, double nota, boolean aprobado) {
        String sql = "INSERT INTO resultados_evaluacion (id_usuario, id_evaluacion, nota, aprobado) VALUES (?, ?, ?, ?)";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, idUsuario);
            ps.setInt(2, idEvaluacion);
            ps.setDouble(3, nota);
            ps.setBoolean(4, aprobado);
            
            int filas = ps.executeUpdate();
            return filas > 0;
        } catch (SQLException e) {
            System.err.println("Error en guardarResultado: " + e.getMessage());
            return false;
        }
    }
}
