-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3307
-- Tiempo de generación: 25-07-2026 a las 21:04:45
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `horizon_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `certificaciones`
--

CREATE TABLE `certificaciones` (
  `id_certificacion` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `id_curso` int(11) DEFAULT NULL,
  `codigo_verificacion` varchar(100) DEFAULT NULL,
  `fecha_expedicion` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursos`
--

CREATE TABLE `cursos` (
  `id_curso` int(11) NOT NULL,
  `titulo` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `id_instructor` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluaciones`
--

CREATE TABLE `evaluaciones` (
  `id_evaluacion` int(11) NOT NULL,
  `id_modulo` int(11) DEFAULT NULL,
  `titulo` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inscripciones`
--

CREATE TABLE `inscripciones` (
  `id_inscripcion` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `id_curso` int(11) DEFAULT NULL,
  `porcentaje_progreso` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `lecciones`
--

CREATE TABLE `lecciones` (
  `id_leccion` int(11) NOT NULL,
  `id_modulo` int(11) DEFAULT NULL,
  `titulo` varchar(150) NOT NULL,
  `contenido_texto` text DEFAULT NULL,
  `url_video` varchar(255) DEFAULT NULL,
  `orden` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `modulos`
--

CREATE TABLE `modulos` (
  `id_modulo` int(11) NOT NULL,
  `id_curso` int(11) DEFAULT NULL,
  `titulo` varchar(150) NOT NULL,
  `orden` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `preguntas`
--

CREATE TABLE `preguntas` (
  `id_pregunta` int(11) NOT NULL,
  `id_evaluacion` int(11) DEFAULT NULL,
  `enunciado` text NOT NULL,
  `opcion_a` varchar(255) NOT NULL,
  `opcion_b` varchar(255) NOT NULL,
  `opcion_c` varchar(255) NOT NULL,
  `opcion_d` varchar(255) NOT NULL,
  `respuesta_correcta` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `resultados_evaluacion`
--

CREATE TABLE `resultados_evaluacion` (
  `id_resultado` int(11) NOT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  `id_evaluacion` int(11) DEFAULT NULL,
  `nota` decimal(5,2) DEFAULT NULL,
  `aprobado` tinyint(1) DEFAULT NULL,
  `fecha` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `rol` enum('ESTUDIANTE','INSTRUCTOR','ADMIN') DEFAULT 'ESTUDIANTE',
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `email`, `password`, `rol`, `fecha_registro`) VALUES
(1, 'Samuel Sevilla', 'sevillasamuel56@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'ESTUDIANTE', '2026-07-23 22:39:21');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `certificaciones`
--
ALTER TABLE `certificaciones`
  ADD PRIMARY KEY (`id_certificacion`),
  ADD UNIQUE KEY `codigo_verificacion` (`codigo_verificacion`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_curso` (`id_curso`);

--
-- Indices de la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD PRIMARY KEY (`id_curso`),
  ADD KEY `id_instructor` (`id_instructor`);

--
-- Indices de la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  ADD PRIMARY KEY (`id_evaluacion`),
  ADD KEY `id_modulo` (`id_modulo`);

--
-- Indices de la tabla `inscripciones`
--
ALTER TABLE `inscripciones`
  ADD PRIMARY KEY (`id_inscripcion`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_curso` (`id_curso`);

--
-- Indices de la tabla `lecciones`
--
ALTER TABLE `lecciones`
  ADD PRIMARY KEY (`id_leccion`),
  ADD KEY `id_modulo` (`id_modulo`);

--
-- Indices de la tabla `modulos`
--
ALTER TABLE `modulos`
  ADD PRIMARY KEY (`id_modulo`),
  ADD KEY `id_curso` (`id_curso`);

--
-- Indices de la tabla `preguntas`
--
ALTER TABLE `preguntas`
  ADD PRIMARY KEY (`id_pregunta`),
  ADD KEY `id_evaluacion` (`id_evaluacion`);

--
-- Indices de la tabla `resultados_evaluacion`
--
ALTER TABLE `resultados_evaluacion`
  ADD PRIMARY KEY (`id_resultado`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_evaluacion` (`id_evaluacion`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `certificaciones`
--
ALTER TABLE `certificaciones`
  MODIFY `id_certificacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cursos`
--
ALTER TABLE `cursos`
  MODIFY `id_curso` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  MODIFY `id_evaluacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `inscripciones`
--
ALTER TABLE `inscripciones`
  MODIFY `id_inscripcion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `lecciones`
--
ALTER TABLE `lecciones`
  MODIFY `id_leccion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `modulos`
--
ALTER TABLE `modulos`
  MODIFY `id_modulo` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `preguntas`
--
ALTER TABLE `preguntas`
  MODIFY `id_pregunta` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `resultados_evaluacion`
--
ALTER TABLE `resultados_evaluacion`
  MODIFY `id_resultado` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `certificaciones`
--
ALTER TABLE `certificaciones`
  ADD CONSTRAINT `certificaciones_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `certificaciones_ibfk_2` FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id_curso`) ON DELETE CASCADE;

--
-- Filtros para la tabla `cursos`
--
ALTER TABLE `cursos`
  ADD CONSTRAINT `cursos_ibfk_1` FOREIGN KEY (`id_instructor`) REFERENCES `usuarios` (`id_usuario`) ON DELETE SET NULL;

--
-- Filtros para la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  ADD CONSTRAINT `evaluaciones_ibfk_1` FOREIGN KEY (`id_modulo`) REFERENCES `modulos` (`id_modulo`) ON DELETE CASCADE;

--
-- Filtros para la tabla `inscripciones`
--
ALTER TABLE `inscripciones`
  ADD CONSTRAINT `inscripciones_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `inscripciones_ibfk_2` FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id_curso`) ON DELETE CASCADE;

--
-- Filtros para la tabla `lecciones`
--
ALTER TABLE `lecciones`
  ADD CONSTRAINT `lecciones_ibfk_1` FOREIGN KEY (`id_modulo`) REFERENCES `modulos` (`id_modulo`) ON DELETE CASCADE;

--
-- Filtros para la tabla `modulos`
--
ALTER TABLE `modulos`
  ADD CONSTRAINT `modulos_ibfk_1` FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id_curso`) ON DELETE CASCADE;

--
-- Filtros para la tabla `preguntas`
--
ALTER TABLE `preguntas`
  ADD CONSTRAINT `preguntas_ibfk_1` FOREIGN KEY (`id_evaluacion`) REFERENCES `evaluaciones` (`id_evaluacion`) ON DELETE CASCADE;

--
-- Filtros para la tabla `resultados_evaluacion`
--
ALTER TABLE `resultados_evaluacion`
  ADD CONSTRAINT `resultados_evaluacion_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `resultados_evaluacion_ibfk_2` FOREIGN KEY (`id_evaluacion`) REFERENCES `evaluaciones` (`id_evaluacion`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
