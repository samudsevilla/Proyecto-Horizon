package com.mycompany.horizon.modelo;

import com.mycompany.horizon.conexion.ConexionBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PreguntaDAO {

    public List<Pregunta> obtenerPreguntasPorEvaluacion(int idEvaluacion) {
        List<Pregunta> lista = new ArrayList<>();
        String sql = "SELECT * FROM preguntas WHERE id_evaluacion = ?";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, idEvaluacion);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Pregunta p = new Pregunta();
                    p.setIdPregunta(rs.getInt("id_pregunta"));
                    p.setIdEvaluacion(rs.getInt("id_evaluacion"));
                    p.setEnunciado(rs.getString("enunciado"));
                    p.setOpcionA(rs.getString("opcion_a"));
                    p.setOpcionB(rs.getString("opcion_b"));
                    p.setOpcionC(rs.getString("opcion_c"));
                    p.setOpcionD(rs.getString("opcion_d"));
                    p.setRespuestaCorrecta(rs.getString("respuesta_correcta").charAt(0));
                    lista.add(p);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error en obtenerPreguntasPorEvaluacion: " + e.getMessage());
        }
        return lista;
    }
}
