package com.mycompany.horizon.conexion; // Ajusta el nombre del paquete si usas uno diferente

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConexionBD {
    
    // Parámetros de conexión a MySQL en XAMPP
    // Si tu puerto MySQL es el estándar (3306), cámbialo aquí. Si usas 3307, déjalo así.
    private static final String URL = "jdbc:mysql://localhost:3307/horizon_db?useSSL=false&serverTimezone=UTC&useUnicode=true&characterEncoding=UTF-8";
    private static final String USER = "root";
    private static final String PASSWORD = ""; // Coloca tu clave de MySQL si la cambiaste en XAMPP

    public static Connection obtenerConexion() {
        Connection con = null;
        try {
            // Cargar el driver JDBC de MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Establecer la conexión
            con = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            System.err.println("Error: No se encontró el driver JDBC de MySQL. " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("Error al conectar a la base de datos horizon_db: " + e.getMessage());
        }
        return con;
    }

    // Método opcional para cerrar conexiones de forma segura
    public static void cerrarConexion(Connection con) {
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                System.err.println("Error al cerrar la conexión: " + e.getMessage());
            }
        }
    }

    public static Connection getConexion() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}