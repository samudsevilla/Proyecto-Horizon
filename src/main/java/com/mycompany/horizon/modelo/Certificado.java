package com.mycompany.horizon.modelo;

import java.sql.Timestamp;

public class Certificado {
    private int idCertificacion;
    private int idUsuario;
    private int idCurso;
    private String nombreCurso;
    private String codigoVerificacion;
    private Timestamp fechaExpedicion;

    public Certificado() {}

    // Getters y Setters alineados a la tabla 'certificaciones'
    public int getIdCertificacion() { return idCertificacion; }
    public void setIdCertificacion(int idCertificacion) { this.idCertificacion = idCertificacion; }

    public int getIdUsuario() { return idUsuario; }
    public void setIdUsuario(int idUsuario) { this.idUsuario = idUsuario; }

    public int getIdCurso() { return idCurso; }
    public void setIdCurso(int idCurso) { this.idCurso = idCurso; }

    public String getNombreCurso() { return nombreCurso; }
    public void setNombreCurso(String nombreCurso) { this.nombreCurso = nombreCurso; }

    public String getCodigoVerificacion() { return codigoVerificacion; }
    public void setCodigoVerificacion(String codigoVerificacion) { this.codigoVerificacion = codigoVerificacion; }

    public Timestamp getFechaExpedicion() { return fechaExpedicion; }
    public void setFechaExpedicion(Timestamp fechaExpedicion) { this.fechaExpedicion = fechaExpedicion; }
}