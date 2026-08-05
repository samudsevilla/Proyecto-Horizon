-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3307
-- Tiempo de generación: 05-08-2026 a las 15:26:35
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
  `fecha_expedicion` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `certificaciones`
--

INSERT INTO `certificaciones` (`id_certificacion`, `id_usuario`, `id_curso`, `codigo_verificacion`, `fecha_expedicion`) VALUES
(1, 1, 3, 'HZ-984210', '2026-07-30 14:44:20'),
(2, 2, 1, 'HZ-906404', '2026-08-04 09:47:33'),
(3, 1, 1, 'HZ-849891', '2026-08-04 19:13:38'),
(4, 1, 2, 'HZ-243714', '2026-08-04 19:16:34');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cursos`
--

CREATE TABLE `cursos` (
  `id_curso` int(11) NOT NULL,
  `titulo` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `id_instructor` int(11) DEFAULT NULL,
  `imagen_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cursos`
--

INSERT INTO `cursos` (`id_curso`, `titulo`, `descripcion`, `id_instructor`, `imagen_url`) VALUES
(1, 'Arquitectura de Servidores y Redes', 'Aprende a gestionar infraestructura web, contenedores y microservicios escalables.', 1, 'https://images.unsplash.com/photo-1558494949-ef010cbdcc31?w=600&auto=format&fit=crop&q=60'),
(2, 'Curso de Ciberseguridad desde 0', 'Aprende los principios fundamentales de la seguridad informática, cifrado de datos, protocolos seguros y protección de infraestructura contra amenazas y vulnerabilidades modernas', 1, 'https://images.unsplash.com/photo-1563986768609-322da13575f3?w=600&auto=format&fit=crop&q=60'),
(3, 'Curso de programación JAVA desde cero', 'Curso JAVA desde cero,  Este es un curso gratuito y completo de programación en JAVA con bloc de notas.', 1, 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=600&auto=format&fit=crop&q=60');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluaciones`
--

CREATE TABLE `evaluaciones` (
  `id_evaluacion` int(11) NOT NULL,
  `id_modulo` int(11) DEFAULT NULL,
  `titulo` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `evaluaciones`
--

INSERT INTO `evaluaciones` (`id_evaluacion`, `id_modulo`, `titulo`) VALUES
(1, 1, 'Evaluación: Fundamentos de Infraestructura Web'),
(2, 2, 'Evaluación: Introducción a la Ciberseguridad'),
(3, 3, 'Evaluación: Dominios y Fundamentos Técnicos'),
(4, 4, 'Evaluación: Amenazas y Tipos de Ataques'),
(5, 5, 'Evaluación: Mecanismos de Defensa y Protección'),
(6, 10, 'Evaluacion: Introducción, JDK y Entorno'),
(7, 11, 'Evaluación: Estructuras Condicionales y Lógica'),
(8, 12, 'Evaluación: Estructuras Repetitivas(Bucles)'),
(9, 13, 'Evaluación: Arreglos Unidimensionales y Bidimensionales');

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

--
-- Volcado de datos para la tabla `inscripciones`
--

INSERT INTO `inscripciones` (`id_inscripcion`, `id_usuario`, `id_curso`, `porcentaje_progreso`) VALUES
(1, 2, 1, 0),
(2, 2, 2, 0),
(3, 2, 3, 0),
(4, 1, 1, 0),
(5, 1, 2, 0),
(6, 1, 3, 0);

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

--
-- Volcado de datos para la tabla `lecciones`
--

INSERT INTO `lecciones` (`id_leccion`, `id_modulo`, `titulo`, `contenido_texto`, `url_video`, `orden`) VALUES
(1, 1, ' Configuración Inicial', 'En este primer capitulo del curso SERVIDORES DESDE CERO hacemos una selección de las herramientas de configuración inicial que necesitamos para poder tomar este curso, revisamos los tipos de consola tanto El Símbolo del Sistema como PowerShell disponibles en Windows 10, y hacemos una breve revisión del programa para conexiones SSH llamado Putty. Les muestro un ejemplo de configuración de herramientas en un sistema Linux en especifico Ubuntu 18.04.3, e instalamos la suite multiplataforma OpenSSH la cual nos ayudara a realizar las conexiones SSH desde nuestro equipo local hacia nuestro Servidor.', 'https://www.youtube.com/embed/UXC50iojhos', 1),
(2, 1, '1.2 Instalar Windows Terminal', 'En este segundo capitulo del curso SERVIDORES DESDE CERO hacemos la instalación de Windows Terminal la nueva terminal de comandos de Microsoft la cual nos provee mas y mejores características de funcionalidad, vemos también como instalar Ubuntu dentro de Windows 10 a manera de Subsistema. Al finalizar la instalación de Windows Terminal muestro un completo y detallado recorrido por las configuraciones de la nueva terminal de Microsoft, personalizamos su tema y sus colores por defecto al estilo que nosotros deseemos.', 'https://www.youtube.com/embed/h2w5LpIiyy8?list=PLRkLUCeZtOrN9K0pjQgBp3652_iiEooWo&index=2', 2),
(3, 1, '1.3 Que es un Servidor?', 'En este tercer capitulo del curso SERVIDORES DESDE CERO explicamos el significado del concepto Servidor y vemos a detalle sus diferentes tipos de alojamiento, tanto el SERVIDOR DEDICADO, SERVIDOR COMPARTIDO, SERVIDOR VIRTUAL mejor conocido con la abreviatura VPS. Te recomiendo mucho este vídeo ya que te ayudara a tener un entendimiento mas claro y detallado del significado del concepto SERVIDOR, claro en el ámbito de la informática.', 'https://www.youtube.com/embed/xZ7aXpfX4f0?list=PLRkLUCeZtOrN9K0pjQgBp3652_iiEooWo&index=', 3),
(4, 1, '1.4 Creando el VPS', 'En este cuarto capitulo del curso SERVIDORES DESDE CERO revisamos las plataformas web que nos permiten virtualizar hardware para la creación de nuestro Servidor VPS, realizamos una comparación entre las plataformas para llegar a saber cual es la que nos conviene utilizar en este curso. Una ves que decidimos la plataforma adecuada, nos registraremos paso a paso y les regalara un cupón con un crédito de 100 dolares que podrán utilizar durante todo este curso.', 'https://www.youtube.com/embed/mHCtAIPpjrc?list=PLRkLUCeZtOrN9K0pjQgBp3652_iiEooWo&index=4', 4),
(5, 1, '1.5 Configurar el VPS', 'En este quinto capitulo del curso SERVIDORES DESDE CERO, llego la hora de crear nuestro primer VPS, nos dirigimos a la plataforma que utilizaremos, en mi caso sera en DigitalOcean, una vez que acabamos de iniciar sesión lo primero que nos aparecerá sera nuestro panel principal. Vamos a dar un pequeño repaso por las opciones principales de la plataforma. Revisamos los servicios principales que podemos utilizar y trabajar en esta plataforma de virtualización de Servidores, desde cortafuegos, dominios, base de datos hasta llegar a la opción que utilizaremos, que es la creación de un VPS o un Droplet que es con el termino que se le conoce a un Servidor Virtual en DigitalOcean.', 'https://www.youtube.com/embed/ydStf9b1kXc?list=PLRkLUCeZtOrN9K0pjQgBp3652_iiEooWo&index=5', 5),
(6, 1, '1.6 Criptografía Asimétrica', 'En este sexto capitulo del curso SERVIDORES DESDE CERO realizamos una amplia explicación sobre como reforzar la seguridad en tu VPS, analizamos a detalle la instrucción utilizada hasta el momento para iniciar sesión en nuestro Servidor y nos daremos cuenta cuales son sus debilidades. Utilizaremos uno de los métodos mas seguros para iniciar sesión en el servidor, que es la criptografía asimétrica, conocida como clave publica y clave privada, estudiaremos el algoritmo de cifrado RSA que es el que nos ayudara a entender mejor como funciona la criptografía asimétrica.', 'https://www.youtube.com/embed/D6NeCReqYJQ?list=PLRkLUCeZtOrN9K0pjQgBp3652_iiEooWo&index=6', 6),
(23, 2, '1.1 ¿Qué es la ciberseguridad? Conceptos y objetivos', 'En este video del curso de RINKU aprenderás qué es exactamente la ciberseguridad, sus objetivos principales y por qué es clave en el entorno actual.', 'https://www.youtube.com/embed/6pfBS8Qy_UI?list=PLg7ZNf8WsbWCQwxFYbJQt3kqApCwB9YdS&index=2', 1),
(24, 2, '1.2 ¿Qué es la triada CIA en ciberseguridad? ', 'Aprende el PILAR FUNDAMENTAL en el que se basa la CIBERSEGURIDAD', 'https://www.youtube.com/embed/_MJt0ugOc_E?list=PLg7ZNf8WsbWCQwxFYbJQt3kqApCwB9YdS&index=3', 2),
(25, 3, '2.1 Dominios de la Ciberseguridad', 'Lección enfocada en descomponer las diferentes áreas y dominios que abarca la ciberseguridad (seguridad de red, cloud, respuesta a incidentes, GRC, etc.).', 'https://www.youtube.com/embed/1hqJWDd8hOY', 1),
(26, 3, '2.2 Fundamentos de Redes y Protocolos', 'Conoce los fundamentos de redes y protocolos que te serán útiles en ciberseguridad y hacking ético.', 'https://www.youtube.com/embed/9lcgudR2IOI?list=PLg7ZNf8WsbWCQwxFYbJQt3kqApCwB9YdS&index=5', 2),
(27, 4, '3.1 Tipos de AMENAZAS en CIBERSEGURIDAD', 'Análisis detallado de las principales amenazas digitales, vectores de ataque comunes y cómo afectan a usuarios y empresas.', 'https://www.youtube.com/embed/EEHvx0xlqFA', 1),
(28, 4, '3.2 ¿Por qué atacan los hackers?', '¿Te habías preguntado alguna vez por qué atacan los hackers?\r\nHaz clic en el vídeo y averígualo ', 'https://www.youtube.com/embed/PFrQxPtXVE0?list=PLg7ZNf8WsbWCQwxFYbJQt3kqApCwB9YdS&index=11', 2),
(29, 5, '4.1 Cómo DEFENDERSE de los CIBERATAQUES', 'Estrategias, buenas prácticas y controles para mitigar riesgos y prevenir incidentes de seguridad.', 'https://www.youtube.com/embed/8Xpi-NLwIL0', 1),
(30, 5, '4.2 Próximos pasos', 'Has llegado al final de este curso de fundamentos de ciberseguridad.\r\n\r\nDurante estas clases, hemos recorrido los conceptos esenciales que todo profesional del área necesita comprender para construir una base sólida.', 'https://www.youtube.com/embed/DKJxov92p1w?list=PLg7ZNf8WsbWCQwxFYbJQt3kqApCwB9YdS&index=14', 2),
(107, 10, '1.1 Instalación del JDK y Configuración', 'Introducción a Java, características principales e instalación y configuración del Java Development Kit.', 'https://www.youtube.com/embed/L1oMLsiMusQ', 1),
(108, 10, '1.2 Indentación, Compilación y Ejecución', 'Aprenderás a indentar tu código correctamente, estructurar el método main y compilar desde la terminal.', 'https://www.youtube.com/embed/Cs5ymoNkrX8', 2),
(109, 10, '1.3 Variables y Tipos de Datos Primitivos', 'Declaración de variables, tipos primitivos enteros, decimales y cadenas de texto iniciales.', 'https://www.youtube.com/embed/vJTeIJx_Kn0?list=PLyvsggKtwbLX9LrDnl1-K6QtYo7m0yXWB&index=4', 3),
(110, 10, '1.4 Operadores Aritméticos y Asignación', 'Uso de suma, resta, multiplicación, división y precedencia de operadores.', 'https://www.youtube.com/embed/Ifg_JzetpU4?list=PLyvsggKtwbLX9LrDnl1-K6QtYo7m0yXWB&index=5', 4),
(111, 11, '2.1 Estructuras Condicionales IF-ELSE', 'Toma de decisiones dentro de tus programas mediante bloques condicionales simples y compuestos.', 'https://www.youtube.com/embed/pwVppK3RgyI?list=PLyvsggKtwbLX9LrDnl1-K6QtYo7m0yXWB&index=6', 1),
(112, 11, '2.2 Operadores Lógicos y Relacionales', 'Comparación de valores y combinaciones de condiciones usando AND, OR y NOT.', 'https://www.youtube.com/embed/i5y1agE0nLs?list=PLyvsggKtwbLX9LrDnl1-K6QtYo7m0yXWB&index=9', 2),
(113, 11, '2.3 Selección Múltiple con Switch Case', 'Evaluación limpia de múltiples posibilidades utilizando la instrucción switch case.', 'https://www.youtube.com/embed/3asmLRCsASs?list=PLyvsggKtwbLX9LrDnl1-K6QtYo7m0yXWB&index=11', 3),
(114, 12, '3.1 Ciclo FOR Tradicional', 'Iteraciones controladas mediante contadores en bucles determinados.', 'https://www.youtube.com/embed/GnIdk6Rvj1I?list=PLyvsggKtwbLX9LrDnl1-K6QtYo7m0yXWB&index=12', 1),
(115, 12, '3.2 Ciclo WHILE y DO-WHILE', 'Bucle indeterminado y ejecución garantizada al menos una vez con do-while.', 'https://www.youtube.com/embed/5B-yd6EgpTc?list=PLyvsggKtwbLX9LrDnl1-K6QtYo7m0yXWB&index=14', 2),
(116, 12, '3.3 Ejercicios Prácticos de Lógica de Bucles', 'Desarrollo de lógica aplicada combinando bucles y estructuras condicionales.', 'https://www.youtube.com/embed/4MBWUxSR7_M?list=PLyvsggKtwbLX9LrDnl1-K6QtYo7m0yXWB&index=15', 3),
(117, 13, '4.1 Arreglos Unidimensionales (Vectores)', 'Creación, asignación e iteración sobre listas o estructuras estáticas de una dimensión.', 'https://www.youtube.com/embed/6zP9AuO2gsM?list=PLyvsggKtwbLX9LrDnl1-K6QtYo7m0yXWB&index=19', 1),
(118, 13, '4.2 Arreglos Bidimensionales (Matrices)', 'Manejo de tablas de dos dimensiones utilizando filas, columnas y bucles anidados.', 'https://www.youtube.com/embed/bPVcx44wgmQ?list=PLyvsggKtwbLX9LrDnl1-K6QtYo7m0yXWB&index=21', 2);

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

--
-- Volcado de datos para la tabla `modulos`
--

INSERT INTO `modulos` (`id_modulo`, `id_curso`, `titulo`, `orden`) VALUES
(1, 1, 'Módulo 1: Fundamentos de Infraestructura Web', 1),
(2, 2, 'Módulo 1: Introducción a la Ciberseguridad', 1),
(3, 2, 'Módulo 2: Dominios y Fundamentos Técnicos', 2),
(4, 2, 'Módulo 3: Amenazas y Tipos de Ataques', 3),
(5, 2, 'Módulo 4: Mecanismos de Defensa y Protección', 4),
(10, 3, 'Módulo 1: Introducción, JDK y Entorno', 1),
(11, 3, 'Módulo 2: Estructuras Condicionales y Lógica', 2),
(12, 3, 'Módulo 3: Estructuras Repetitivas (Bucles)', 3),
(13, 3, 'Módulo 4: Arreglos Unidimensionales y Bidimensionales', 4);

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

--
-- Volcado de datos para la tabla `preguntas`
--

INSERT INTO `preguntas` (`id_pregunta`, `id_evaluacion`, `enunciado`, `opcion_a`, `opcion_b`, `opcion_c`, `opcion_d`, `respuesta_correcta`) VALUES
(1, 1, '¿Qué significa HTTP?', 'HyperText Transfer Protocol', 'High Transfer Text Protocol', 'Hyperlink Text Technical Protocol', 'Home Text Transfer Procedure', 'A'),
(2, 1, '¿Cuál es el puerto por defecto para el protocolo HTTPS?', '80', '21', '443', '8080', 'C'),
(3, 1, '¿Qué capa del modelo OSI gestiona el direccionamiento IP?', 'Capa de Enlace de Datos', 'Capa de Red', 'Capa de Transporte', 'Capa Física', 'B'),
(4, 2, '¿Qué pilar de la seguridad de la información garantiza que los datos no sean alterados por terceros?', 'Confidencialidad', 'Integridad', 'Disponibilidad', 'Autenticidad', 'B'),
(5, 2, '¿Cuál es el término utilizado para describir una debilidad en un sistema que puede ser explotada por una amenaza?', 'Vulnerabilidad', 'Exploit', 'Riesgo', 'Malware', 'A'),
(6, 2, '¿Cuál de los siguientes es un ataque de ingeniería social común?', 'Phishing', 'Inyección SQL', 'DDoS', 'Keylogger', 'A'),
(7, 3, '¿Qué tipo de cifrado utiliza la misma clave tanto para cifrar como para descifrar la información?', 'Cifrado Asimétrico', 'Cifrado Simétrico', 'Hashing', 'Esteganografía', 'B'),
(8, 3, '¿Cuál es el protocolo seguro que se utiliza para transferir páginas web cifrando la comunicación?', 'HTTP', 'FTP', 'HTTPS', 'SSH', 'C'),
(9, 3, '¿Qué dispositivo de red filtra el tráfico entrante y saliente según un conjunto de reglas de seguridad?', 'Router', 'Switch', 'Firewall', 'Hub', 'C'),
(10, 4, '¿Qué tipo de malware bloquea el acceso a los archivos del usuario y exige un pago para recuperarlos?', 'Ransomware', 'Troyano', 'Spyware', 'Gusano', 'A'),
(11, 4, '¿Qué significa DDoS?', 'Distributed Denial of Service', 'Direct Domain Operating System', 'Data Delivery Online System', 'Dual Denial of Security', 'A'),
(12, 4, '¿Qué tipo de ataque consiste en interceptar y modificar la comunicación entre dos partes sin que lo sepan?', 'Man-in-the-Middle (MitM)', 'Phishing', 'Brute Force', 'XSS', 'A'),
(13, 5, '¿Qué mecanismo añade una capa de seguridad requiriendo dos o más pruebas de identidad para iniciar sesión?', 'MFA (Multi-Factor Authentication)', 'Contraseña compleja', 'Hashing', 'Encriptación', 'A'),
(14, 5, '¿Cuál es la primera línea de defensa para proteger la confidencialidad de los archivos respaldados en la nube?', 'Desfragmentación', 'Cifrado de datos', 'Compresión', 'Indexación', 'B'),
(15, 5, '¿Qué práctica consiste en realizar copias periódicas de seguridad de los datos importantes en un medio externo o nube?', 'Backup', 'Firewalling', 'Phishing', 'Sandboxing', 'A');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `progreso_lecciones`
--

CREATE TABLE `progreso_lecciones` (
  `id_progreso` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_leccion` int(11) NOT NULL,
  `completado` tinyint(1) DEFAULT 1,
  `fecha_completado` timestamp NOT NULL DEFAULT current_timestamp()
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

--
-- Volcado de datos para la tabla `resultados_evaluacion`
--

INSERT INTO `resultados_evaluacion` (`id_resultado`, `id_usuario`, `id_evaluacion`, `nota`, `aprobado`, `fecha`) VALUES
(1, 2, 1, 0.00, 0, '2026-08-04 13:42:16'),
(2, 2, 1, 6.67, 0, '2026-08-04 13:47:21'),
(3, 2, 1, 0.00, 0, '2026-08-04 13:47:27'),
(4, 2, 1, 13.33, 1, '2026-08-04 13:47:33'),
(5, 2, 2, 0.00, 0, '2026-08-04 13:58:30'),
(6, 2, 2, 0.00, 0, '2026-08-04 13:58:32'),
(7, 2, 1, 6.67, 0, '2026-08-04 14:34:13'),
(8, 2, 1, 6.67, 0, '2026-08-04 14:52:11'),
(9, 1, 1, 13.33, 1, '2026-08-04 23:13:38'),
(10, 1, 5, 20.00, 1, '2026-08-04 23:14:13'),
(11, 1, 2, 20.00, 1, '2026-08-04 23:14:39'),
(12, 1, 2, 20.00, 1, '2026-08-04 23:14:53'),
(13, 1, 3, 20.00, 1, '2026-08-04 23:15:12'),
(14, 1, 4, 20.00, 1, '2026-08-04 23:16:34');

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
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp(),
  `verificado` tinyint(1) DEFAULT 0,
  `codigo_verificacion` varchar(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuario`, `nombre`, `email`, `password`, `rol`, `fecha_registro`, `verificado`, `codigo_verificacion`) VALUES
(1, 'Samuel Sevilla', 'sevillasamuel56@gmail.com', '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92', 'ESTUDIANTE', '2026-07-23 22:39:21', 1, NULL),
(2, 'daniel colmenarez', 'Danielalejandrocolmenarez2308@gmail.com', 'e4ce92c11ef6b1b69a35e5a008f737fc8b234c1b0633b08c935739ffcf8e9642', 'ESTUDIANTE', '2026-08-04 13:07:38', 1, NULL),
(3, 'adsasdads', 'brakysan@gmail.com', 'bd3dae5fb91f88a4f0978222dfd58f59a124257cb081486387cbae9df11fb879', 'ESTUDIANTE', '2026-08-04 15:12:57', 1, NULL),
(6, 'Sarai Perez', 'sevillasamuel.31@gmail.com', '5b9869abafee11c889e73129428181f8300f93391afe9499218f046f06d3b33d', 'ESTUDIANTE', '2026-08-05 00:35:06', 1, NULL);

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
-- Indices de la tabla `progreso_lecciones`
--
ALTER TABLE `progreso_lecciones`
  ADD PRIMARY KEY (`id_progreso`),
  ADD UNIQUE KEY `user_leccion_unique` (`id_usuario`,`id_leccion`),
  ADD KEY `id_leccion` (`id_leccion`);

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
  MODIFY `id_certificacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `cursos`
--
ALTER TABLE `cursos`
  MODIFY `id_curso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  MODIFY `id_evaluacion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `inscripciones`
--
ALTER TABLE `inscripciones`
  MODIFY `id_inscripcion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `lecciones`
--
ALTER TABLE `lecciones`
  MODIFY `id_leccion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=119;

--
-- AUTO_INCREMENT de la tabla `modulos`
--
ALTER TABLE `modulos`
  MODIFY `id_modulo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `preguntas`
--
ALTER TABLE `preguntas`
  MODIFY `id_pregunta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `progreso_lecciones`
--
ALTER TABLE `progreso_lecciones`
  MODIFY `id_progreso` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `resultados_evaluacion`
--
ALTER TABLE `resultados_evaluacion`
  MODIFY `id_resultado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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
-- Filtros para la tabla `progreso_lecciones`
--
ALTER TABLE `progreso_lecciones`
  ADD CONSTRAINT `progreso_lecciones_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id_usuario`) ON DELETE CASCADE,
  ADD CONSTRAINT `progreso_lecciones_ibfk_2` FOREIGN KEY (`id_leccion`) REFERENCES `lecciones` (`id_leccion`) ON DELETE CASCADE;

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
