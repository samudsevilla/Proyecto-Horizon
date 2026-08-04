package com.mycompany.horizon.modelo;

public class Evaluacion {
    private int idEvaluacion;
    private int idModulo;
    private String titulo;

    public Evaluacion() {}

    public Evaluacion(int idEvaluacion, int idModulo, String titulo) {
        this.idEvaluacion = idEvaluacion;
        this.idModulo = idModulo;
        this.titulo = titulo;
    }

    public int getIdEvaluacion() {
        return idEvaluacion;
    }

    public void setIdEvaluacion(int idEvaluacion) {
        this.idEvaluacion = idEvaluacion;
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
}
