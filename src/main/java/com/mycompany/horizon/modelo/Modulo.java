package com.mycompany.horizon.modelo;

import java.util.ArrayList;
import java.util.List;

public class Modulo {
    private int idModulo;
    private int idCurso;
    private String titulo;
    private int orden;
    private List<Leccion> lecciones = new ArrayList<>();

    public Modulo() {}

    public Modulo(int idModulo, int idCurso, String titulo, int orden) {
        this.idModulo = idModulo;
        this.idCurso = idCurso;
        this.titulo = titulo;
        this.orden = orden;
    }

    public int getIdModulo() { return idModulo; }
    public void setIdModulo(int idModulo) { this.idModulo = idModulo; }

    public int getIdCurso() { return idCurso; }
    public void setIdCurso(int idCurso) { this.idCurso = idCurso; }

    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }

    public int getOrden() { return orden; }
    public void setOrden(int orden) { this.orden = orden; }

    public List<Leccion> getLecciones() { return lecciones; }
    public void setLecciones(List<Leccion> lecciones) { this.lecciones = lecciones; }
}