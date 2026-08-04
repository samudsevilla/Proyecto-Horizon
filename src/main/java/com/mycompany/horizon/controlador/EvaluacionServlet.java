package com.mycompany.horizon.controlador;

import com.mycompany.horizon.modelo.Usuario;
import com.mycompany.horizon.modelo.Evaluacion;
import com.mycompany.horizon.modelo.EvaluacionDAO;
import com.mycompany.horizon.modelo.Pregunta;
import com.mycompany.horizon.modelo.PreguntaDAO;
import com.mycompany.horizon.modelo.CertificadoDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "EvaluacionServlet", urlPatterns = {"/EvaluacionServlet"})
public class EvaluacionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/vistas/auth/login.jsp");
            return;
        }

        String idModuloStr = request.getParameter("idModulo");
        if (idModuloStr == null || idModuloStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/HomeServlet");
            return;
        }

        try {
            int idModulo = Integer.parseInt(idModuloStr.trim());
            EvaluacionDAO evalDAO = new EvaluacionDAO();
            Evaluacion eval = evalDAO.obtenerPorModulo(idModulo);

            if (eval == null) {
                request.setAttribute("error", "No se encontró una evaluación para este módulo.");
                request.getRequestDispatcher("/HomeServlet").forward(request, response);
                return;
            }

            PreguntaDAO preguntaDAO = new PreguntaDAO();
            List<Pregunta> preguntas = preguntaDAO.obtenerPreguntasPorEvaluacion(eval.getIdEvaluacion());

            request.setAttribute("evaluacion", eval);
            request.setAttribute("preguntas", preguntas);
            request.getRequestDispatcher("/vistas/cursos/evaluacion.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/HomeServlet");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        if (usuario == null) {
            response.sendRedirect(request.getContextPath() + "/vistas/auth/login.jsp");
            return;
        }

        String idEvalStr = request.getParameter("idEvaluacion");
        if (idEvalStr == null || idEvalStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/HomeServlet");
            return;
        }

        try {
            int idEvaluacion = Integer.parseInt(idEvalStr.trim());
            PreguntaDAO preguntaDAO = new PreguntaDAO();
            List<Pregunta> preguntas = preguntaDAO.obtenerPreguntasPorEvaluacion(idEvaluacion);

            if (preguntas.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/HomeServlet");
                return;
            }

            int aciertos = 0;
            int totalPreguntas = preguntas.size();

            for (Pregunta p : preguntas) {
                String paramName = "respuesta_" + p.getIdPregunta();
                String userAns = request.getParameter(paramName);
                if (userAns != null && !userAns.trim().isEmpty()) {
                    char ansChar = userAns.trim().toUpperCase().charAt(0);
                    if (ansChar == Character.toUpperCase(p.getRespuestaCorrecta())) {
                        aciertos++;
                    }
                }
            }

            double notaRaw = ((double) aciertos / totalPreguntas) * 20.0;
            double nota = Math.round(notaRaw * 100.0) / 100.0;
            boolean aprobado = nota >= 10.0; // Nota mínima aprobatoria 10/20

            EvaluacionDAO evalDAO = new EvaluacionDAO();
            boolean guardado = evalDAO.guardarResultado(usuario.getIdUsuario(), idEvaluacion, nota, aprobado);

            boolean certificadoGenerado = false;
            if (aprobado) {
                // Verificar si se completó el curso y generar certificado
                CertificadoDAO certDAO = new CertificadoDAO();
                certificadoGenerado = certDAO.verificarYGenerarCertificado(usuario.getIdUsuario(), idEvaluacion);
            }

            // Conseguir título de la evaluación para mostrar en los resultados
            String evalTitulo = request.getParameter("evaluacionTitulo");
            if (evalTitulo == null) {
                evalTitulo = "Evaluación del Módulo";
            }

            request.setAttribute("evaluacionTitulo", evalTitulo);
            request.setAttribute("nota", nota);
            request.setAttribute("aprobado", aprobado);
            request.setAttribute("aciertos", aciertos);
            request.setAttribute("totalPreguntas", totalPreguntas);
            request.setAttribute("certificadoGenerado", certificadoGenerado);

            request.getRequestDispatcher("/vistas/cursos/resultado.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/HomeServlet");
        }
    }
}
