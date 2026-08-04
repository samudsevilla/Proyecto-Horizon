package com.mycompany.horizon.modelo;

import com.mycompany.horizon.conexion.ConexionBD;
import com.mycompany.horizon.conexion.PasswordUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsuarioDAO {

    // RF01: Registro de Usuario con contraseña cifrada y código de verificación
    public boolean registrar(Usuario usr) {
        String sql = "INSERT INTO usuarios (nombre, email, password, rol, verificado, codigo_verificacion) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            // Ciframos la contraseña antes de guardar en la BD
            String passwordCifrada = PasswordUtil.hashPassword(usr.getPassword());

            ps.setString(1, usr.getNombre());
            ps.setString(2, usr.getEmail());
            ps.setString(3, passwordCifrada);
            ps.setString(4, usr.getRol() != null ? usr.getRol() : "ESTUDIANTE");
            ps.setBoolean(5, usr.isVerificado());
            ps.setString(6, usr.getCodigoVerificacion());

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
                    usuario.setVerificado(rs.getBoolean("verificado"));
                    usuario.setCodigoVerificacion(rs.getString("codigo_verificacion"));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error en autenticar usuario: " + e.getMessage());
        }
        return usuario; // Retorna null si las credenciales son incorrectas
    }

    public Usuario obtenerPorEmail(String email) {
        String sql = "SELECT * FROM usuarios WHERE email = ?";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Usuario usuario = new Usuario();
                    usuario.setIdUsuario(rs.getInt("id_usuario"));
                    usuario.setNombre(rs.getString("nombre"));
                    usuario.setEmail(rs.getString("email"));
                    usuario.setRol(rs.getString("rol"));
                    usuario.setVerificado(rs.getBoolean("verificado"));
                    usuario.setCodigoVerificacion(rs.getString("codigo_verificacion"));
                    return usuario;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error en obtenerPorEmail: " + e.getMessage());
        }
        return null;
    }

    public boolean verificarUsuario(String email, String codigo) {
        String sql = "UPDATE usuarios SET verificado = 1, codigo_verificacion = NULL WHERE email = ? AND codigo_verificacion = ?";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, email);
            ps.setString(2, codigo);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error en verificarUsuario: " + e.getMessage());
            return false;
        }
    }

    public boolean actualizarCodigoVerificacion(String email, String nuevoCodigo) {
        String sql = "UPDATE usuarios SET codigo_verificacion = ? WHERE email = ?";
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, nuevoCodigo);
            ps.setString(2, email);
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error en actualizarCodigoVerificacion: " + e.getMessage());
            return false;
        }
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
        }
        return false;
    }

    public boolean restablecerPassword(String email, String codigo, String nuevoPassword) {
        String sqlVerificar = "SELECT COUNT(*) FROM usuarios WHERE email = ? AND codigo_verificacion = ?";
        String sqlUpdate = "UPDATE usuarios SET password = ?, codigo_verificacion = NULL WHERE email = ?";
        
        try (Connection con = ConexionBD.obtenerConexion();
             PreparedStatement psVer = con.prepareStatement(sqlVerificar)) {
            
            psVer.setString(1, email);
            psVer.setString(2, codigo);
            
            try (ResultSet rs = psVer.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    try (PreparedStatement psUpd = con.prepareStatement(sqlUpdate)) {
                        String passwordCifrada = com.mycompany.horizon.conexion.PasswordUtil.hashPassword(nuevoPassword);
                        psUpd.setString(1, passwordCifrada);
                        psUpd.setString(2, email);
                        return psUpd.executeUpdate() > 0;
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Error en restablecerPassword: " + e.getMessage());
        }
        return false;
    }
}