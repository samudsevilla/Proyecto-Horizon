package com.mycompany.horizon.modelo;

public class Ruta {
    private String nombre;
    private String descripcion;
    private String categoria;
    private int totalCursos;
    private int progreso;
    private int idUltimaLeccion;
    private String colorClase; // "primary", "danger"
    private int idCertificado; // ID del certificado generado (0 si no existe)

    public Ruta() {}

    public Ruta(String nombre, String descripcion, String categoria, int totalCursos, int progreso, int idUltimaLeccion, String colorClase) {
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.categoria = categoria;
        this.totalCursos = totalCursos;
        this.progreso = progreso;
        this.idUltimaLeccion = idUltimaLeccion;
        this.colorClase = colorClase;
        this.idCertificado = 0;
    }

    public Ruta(String nombre, String descripcion, String categoria, int totalCursos, int progreso, int idUltimaLeccion, String colorClase, int idCertificado) {
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.categoria = categoria;
        this.totalCursos = totalCursos;
        this.progreso = progreso;
        this.idUltimaLeccion = idUltimaLeccion;
        this.colorClase = colorClase;
        this.idCertificado = idCertificado;
    }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public String getCategoria() { return categoria; }
    public void setCategoria(String categoria) { this.categoria = categoria; }

    public int getTotalCursos() { return totalCursos; }
    public void setTotalCursos(int totalCursos) { this.totalCursos = totalCursos; }

    public int getProgreso() { return progreso; }
    public void setProgreso(int progreso) { this.progreso = progreso; }

    public int getIdUltimaLeccion() { return idUltimaLeccion; }
    public void setIdUltimaLeccion(int idUltimaLeccion) { this.idUltimaLeccion = idUltimaLeccion; }

    public String getColorClase() { return colorClase; }
    public void setColorClase(String colorClase) { this.colorClase = colorClase; }

    public int getIdCertificado() { return idCertificado; }
    public void setIdCertificado(int idCertificado) { this.idCertificado = idCertificado; }
}
