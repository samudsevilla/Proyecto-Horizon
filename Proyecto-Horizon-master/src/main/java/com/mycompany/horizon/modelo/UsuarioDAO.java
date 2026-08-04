package com.mycompany.horizon.modelo;

import com.mycompany.horizon.conexion.ConexionBD;
import com.mycompany.horizon.conexion.PasswordUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsuarioDAO {

    // RF01: Registro de Usuario con contraseña cifrada
    public boolean registrar(Usuario usr) {
        String sql = "INSERT INTO usuarios (nombre, email, password, rol) VALUES (?, ?, ?, ?)";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            // Ciframos la contraseña antes de guardar en la BD
            String passwordCifrada = PasswordUtil.hashPassword(usr.getPassword());

            ps.setString(1, usr.getNombre());
            ps.setString(2, usr.getEmail());
            ps.setString(3, passwordCifrada);
            ps.setString(4, usr.getRol() != null ? usr.getRol() : "ESTUDIANTE");

            int filas = ps.executeUpdate();
            return filas > 0;
        } catch (SQLException e) {
            System.err.println("Error en registrar usuario: " + e.getMessage());
            return false;
        }
    }

    // RF01: Autenticación / Login
    public Usuario autenticar(String email, String password) {
        String sql = "SELECT * FROM usuarios WHERE email = ? AND password = ?";
        Usuario usuario = null;

        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            // Ciframos la clave ingresada para compararla con el hash de la BD
            String passwordCifrada = PasswordUtil.hashPassword(password);

            ps.setString(1, email);
            ps.setString(2, passwordCifrada);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    usuario = new Usuario();
                    usuario.setIdUsuario(rs.getInt("id_usuario"));
                    usuario.setNombre(rs.getString("nombre"));
                    usuario.setEmail(rs.getString("email"));
                    usuario.setRol(rs.getString("rol"));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error en autenticar usuario: " + e.getMessage());
        }
        return usuario; // Retorna null si las credenciales son incorrectas
    }
    
    // RF01: Validar si el email ya existe en la BD
    public boolean existeCorreo(String email) {
        String sql = "SELECT id_usuario FROM usuarios WHERE email = ?";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // Retorna true si ya existe
            }
        } catch (SQLException e) {
            System.err.println("Error al verificar correo: " + e.getMessage());
            return false;
        }
    }
}