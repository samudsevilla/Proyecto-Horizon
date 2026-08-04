package com.mycompany.horizon.modelo;

public class Usuario {
    private int idUsuario;
    private String nombre;
    private String email;
    private String password;
    private String rol;
    private boolean verificado;
    private String codigoVerificacion;

    public Usuario() {}

    public Usuario(int idUsuario, String nombre, String email, String password, String rol) {
        this.idUsuario = idUsuario;
        this.nombre = nombre;
        this.email = email;
        this.password = password;
        this.rol = rol;
        this.verificado = false;
    }

    public Usuario(int idUsuario, String nombre, String email, String password, String rol, boolean verificado, String codigoVerificacion) {
        this.idUsuario = idUsuario;
        this.nombre = nombre;
        this.email = email;
        this.password = password;
        this.rol = rol;
        this.verificado = verificado;
        this.codigoVerificacion = codigoVerificacion;
    }

    // Getters y Setters
    public int getIdUsuario() { return idUsuario; }
    public void setIdUsuario(int idUsuario) { this.idUsuario = idUsuario; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getRol() { return rol; }
    public void setRol(String rol) { this.rol = rol; }

    public boolean isVerificado() { return verificado; }
    public void setVerificado(boolean verificado) { this.verificado = verificado; }

    public String getCodigoVerificacion() { return codigoVerificacion; }
    public void setCodigoVerificacion(String codigoVerificacion) { this.codigoVerificacion = codigoVerificacion; }
}