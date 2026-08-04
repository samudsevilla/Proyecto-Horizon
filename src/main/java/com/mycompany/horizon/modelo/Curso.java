package com.mycompany.horizon.modelo;

public class Curso {
    private int idCurso;
    private String titulo;
    private String descripcion;
    private String categoria;
    private String nivel;
    private String imagenUrl;
    private int totalModulos;
    private boolean inscrito; // Útil para cambiar el botón entre "Inscribirse" y "Continuar"

    public Curso() {
    }

    public Curso(int idCurso, String titulo, String descripcion, String categoria, String nivel, String imagenUrl, int totalModulos) {
        this.idCurso = idCurso;
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.categoria = categoria;
        this.nivel = nivel;
        this.imagenUrl = imagenUrl;
        this.totalModulos = totalModulos;
    }

    // Getters y Setters
    public int getIdCurso() { return idCurso; }
    public void setIdCurso(int idCurso) { this.idCurso = idCurso; }

    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public String getCategoria() { return categoria; }
    public void setCategoria(String categoria) { this.categoria = categoria; }

    public String getNivel() { return nivel; }
    public void setNivel(String nivel) { this.nivel = nivel; }

    public String getImagenUrl() { return imagenUrl; }
    public void setImagenUrl(String imagenUrl) { this.imagenUrl = imagenUrl; }

    public int getTotalModulos() { return totalModulos; }
    public void setTotalModulos(int totalModulos) { this.totalModulos = totalModulos; }

    public boolean isInscrito() { return inscrito; }
    public void setInscrito(boolean inscrito) { this.inscrito = inscrito; }

    private int progreso;
    private String moduloActual;
    private int idUltimaLeccion;

    public int getProgreso() { return progreso; }
    public void setProgreso(int progreso) { this.progreso = progreso; }

    public String getModuloActual() { return moduloActual; }
    public void setModuloActual(String moduloActual) { this.moduloActual = moduloActual; }

    public int getIdUltimaLeccion() { return idUltimaLeccion; }
    public void setIdUltimaLeccion(int idUltimaLeccion) { this.idUltimaLeccion = idUltimaLeccion; }
}