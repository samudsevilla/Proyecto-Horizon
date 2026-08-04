package com.mycompany.horizon.modelo;

public class Leccion {
    
    private int idCurso;
    private int idLeccion;
    private int idModulo;
    private String titulo;
    private String contenidoTexto;
    private String videoUrl;
    private int orden;

    // Constructor vacío
    public Leccion() {
    }

    // Constructor completo
    public Leccion(int idLeccion, int idModulo, String titulo, String contenidoTexto, String videoUrl, int orden) {
        this.idLeccion = idLeccion;
        this.idModulo = idModulo;
        this.titulo = titulo;
        this.contenidoTexto = contenidoTexto;
        this.videoUrl = videoUrl;
        this.orden = orden;
    }

    // --- GETTERS Y SETTERS ---

    public int getIdCurso() {
        return idCurso;
    }

    public void setIdCurso(int idCurso) {
        this.idCurso = idCurso;
    }
    
    

    public int getIdLeccion() {
        return idLeccion;
    }

    public void setIdLeccion(int idLeccion) {
        this.idLeccion = idLeccion;
    }

    public int getIdModulo() {
        return idModulo;
    }

    public void setIdModulo(int idModulo) {
        this.idModulo = idModulo;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getContenidoTexto() {
        return contenidoTexto;
    }

    public void setContenidoTexto(String contenidoTexto) {
        this.contenidoTexto = contenidoTexto;
    }

    public String getVideoUrl() {
        return videoUrl;
    }

    public void setVideoUrl(String videoUrl) {
        this.videoUrl = videoUrl;
    }

    public int getOrden() {
        return orden;
    }

    public void setOrden(int orden) {
        this.orden = orden;
    }
    
    
}