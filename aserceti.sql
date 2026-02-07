-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 07-02-2026 a las 01:58:07
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
-- Base de datos: `aserceti`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `administrador`
--

CREATE TABLE `administrador` (
  `id` int(8) NOT NULL,
  `NombreAdmin` varchar(40) NOT NULL,
  `id_usuario` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `administrador`
--

INSERT INTO `administrador` (`id`, `NombreAdmin`, `id_usuario`) VALUES
(1, 'Carlos Ruiz', 3),
(2, 'Luis Administrador', 3),
(3, 'Admin Auxiliar', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `alumno`
--

CREATE TABLE `alumno` (
  `Registro` int(8) NOT NULL,
  `Carrera` varchar(40) NOT NULL,
  `Grado` int(1) NOT NULL,
  `NivelAca` varchar(40) NOT NULL,
  `Estatus_Academico` varchar(40) NOT NULL,
  `id_usuario` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `alumno`
--

INSERT INTO `alumno` (`Registro`, `Carrera`, `Grado`, `NivelAca`, `Estatus_Academico`, `id_usuario`) VALUES
(1001, 'Ingeniería en Sistemas', 2, 'Licenciatura', 'Regular', 1),
(1002, 'Ingeniería Industrial', 1, 'Licenciatura', 'Regular', 5),
(1003, 'Ingeniería en Sistemas', 3, 'Licenciatura', 'Irregular', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asesor`
--

CREATE TABLE `asesor` (
  `IdAse` int(8) NOT NULL,
  `Division` varchar(40) NOT NULL,
  `Tipo` varchar(40) NOT NULL,
  `nivel` varchar(40) NOT NULL,
  `id_usuario` int(8) NOT NULL,
  `id_materia` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `asesor`
--

INSERT INTO `asesor` (`IdAse`, `Division`, `Tipo`, `nivel`, `id_usuario`, `id_materia`) VALUES
(2001, 'Ingeniería', 'Tiempo Completo', 'Licenciatura', 2, 1),
(2002, 'Ingeniería', 'Medio Tiempo', 'Licenciatura', 6, 3),
(2003, 'Ingeniería', 'Tiempo Completo', 'Maestría', 2, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asesoria`
--

CREATE TABLE `asesoria` (
  `id_asesoria` int(8) NOT NULL,
  `id_horario` int(11) NOT NULL,
  `tema` varchar(40) NOT NULL,
  `estado` tinyint(1) NOT NULL,
  `obligatoria` tinyint(1) NOT NULL,
  `registro` int(8) NOT NULL,
  `idAse` int(8) NOT NULL,
  `id_materia` int(11) NOT NULL,
  `id_solicitud` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `asesoria`
--

INSERT INTO `asesoria` (`id_asesoria`, `id_horario`, `tema`, `estado`, `obligatoria`, `registro`, `idAse`, `id_materia`, `id_solicitud`) VALUES
(1, 1, 'Álgebra básica', 1, 0, 1001, 2001, 1, 1),
(2, 3, 'Cinemática', 1, 1, 1002, 2002, 3, 2),
(3, 4, 'Consultas SQL', 1, 0, 1003, 2003, 4, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `casoespecial`
--

CREATE TABLE `casoespecial` (
  `id_caso` int(11) NOT NULL,
  `fechaC` date NOT NULL,
  `descripcion` varchar(40) NOT NULL,
  `id_asesoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `casoespecial`
--

INSERT INTO `casoespecial` (`id_caso`, `fechaC`, `descripcion`, `id_asesoria`) VALUES
(1, '2026-02-01', 'Alumno con bajo rendimiento', 1),
(2, '2026-02-02', 'Falta de conocimientos previos', 2),
(3, '2026-02-03', 'Problemas de asistencia', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentario`
--

CREATE TABLE `comentario` (
  `id_comentario` int(11) NOT NULL,
  `aspecto` varchar(40) NOT NULL,
  `valor` int(11) NOT NULL,
  `id_opinion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `comentario`
--

INSERT INTO `comentario` (`id_comentario`, `aspecto`, `valor`, `id_opinion`) VALUES
(1, 'Claridad', 5, 1),
(2, 'Paciencia', 4, 1),
(3, 'Dominio del tema', 4, 2),
(4, 'Explicación', 3, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `horario`
--

CREATE TABLE `horario` (
  `id_horario` int(8) NOT NULL,
  `fecha` datetime NOT NULL,
  `modalidad` varchar(40) NOT NULL,
  `capacidad` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `horario`
--

INSERT INTO `horario` (`id_horario`, `fecha`, `modalidad`, `capacidad`) VALUES
(1, '2026-02-01 10:00:00', 'Presencial', 20),
(2, '2026-02-02 12:00:00', 'Virtual', 30),
(3, '2026-02-03 09:00:00', 'Presencial', 15),
(4, '2026-02-04 14:00:00', 'Virtual', 25);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `listaespera`
--

CREATE TABLE `listaespera` (
  `id_espera` int(11) NOT NULL,
  `fecha` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `listaespera`
--

INSERT INTO `listaespera` (`id_espera`, `fecha`) VALUES
(1, '2026-01-30'),
(2, '2026-01-31'),
(3, '2026-02-01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `materia`
--

CREATE TABLE `materia` (
  `id_materia` int(8) NOT NULL,
  `nombre` varchar(40) NOT NULL,
  `division` varchar(40) NOT NULL,
  `nivel` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `materia`
--

INSERT INTO `materia` (`id_materia`, `nombre`, `division`, `nivel`) VALUES
(1, 'Matemáticas', 'Ingeniería', 1),
(2, 'Programación', 'Ingeniería', 2),
(3, 'Física', 'Ingeniería', 1),
(4, 'Bases de Datos', 'Ingeniería', 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `opinion`
--

CREATE TABLE `opinion` (
  `id_opinion` int(11) NOT NULL,
  `estrellas` int(11) NOT NULL,
  `descripcion` varchar(40) NOT NULL,
  `registro` int(11) NOT NULL,
  `id_asesoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `opinion`
--

INSERT INTO `opinion` (`id_opinion`, `estrellas`, `descripcion`, `registro`, `id_asesoria`) VALUES
(1, 5, 'Muy buena asesoría', 1001, 1),
(2, 4, 'Buena atención', 1002, 2),
(3, 3, 'Puede mejorar', 1003, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reporte`
--

CREATE TABLE `reporte` (
  `id_asesoria` int(11) NOT NULL,
  `id_reporte` int(11) NOT NULL,
  `tipo` varchar(40) NOT NULL,
  `formato` varchar(40) NOT NULL,
  `id_horario` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `reporte`
--

INSERT INTO `reporte` (`id_asesoria`, `id_reporte`, `tipo`, `formato`, `id_horario`) VALUES
(1, 1, 'Asistencia', 'PDF', 1),
(2, 2, 'Evaluación', 'Word', 3),
(3, 3, 'Seguimiento', 'PDF', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `solicitudasesoria`
--

CREATE TABLE `solicitudasesoria` (
  `id_solicitud` int(11) NOT NULL,
  `id_espera` int(11) NOT NULL,
  `fecha_soli` date NOT NULL,
  `estado` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `solicitudasesoria`
--

INSERT INTO `solicitudasesoria` (`id_solicitud`, `id_espera`, `fecha_soli`, `estado`) VALUES
(1, 1, '2026-01-30', 'Pendiente'),
(2, 2, '2026-01-31', 'Aceptada'),
(3, 3, '2026-02-01', 'Rechazada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `supervisor`
--

CREATE TABLE `supervisor` (
  `id_usuario` int(8) NOT NULL,
  `supervisor` varchar(40) NOT NULL,
  `id_super` int(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `supervisor`
--

INSERT INTO `supervisor` (`id_usuario`, `supervisor`, `id_super`) VALUES
(4, 'María Torres', 1),
(3, 'Supervisor General', 2),
(4, 'Supervisor Académico', 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id_usuario` int(8) NOT NULL,
  `nombre` varchar(40) NOT NULL,
  `correo` varchar(40) NOT NULL,
  `password` varchar(20) NOT NULL,
  `rol` text NOT NULL,
  `estado` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id_usuario`, `nombre`, `correo`, `password`, `rol`, `estado`) VALUES
(1, 'Juan Pérez', 'juan@correo.com', '1234', 'Alumno', 'Activo'),
(2, 'Ana López', 'ana@correo.com', '1234', 'Asesor', 'Activo'),
(3, 'Carlos Ruiz', 'carlos@correo.com', '1234', 'Administrador', 'Activo'),
(4, 'María Torres', 'maria@correo.com', '1234', 'Supervisor', 'Activo'),
(5, 'Luis Gómez', 'luis@correo.com', '1234', 'Alumno', 'Activo'),
(6, 'Sofía Hernández', 'sofia@correo.com', '1234', 'Asesor', 'Activo');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `administrador`
--
ALTER TABLE `administrador`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `alumno`
--
ALTER TABLE `alumno`
  ADD PRIMARY KEY (`Registro`),
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `asesor`
--
ALTER TABLE `asesor`
  ADD PRIMARY KEY (`IdAse`),
  ADD KEY `id_usuario` (`id_usuario`),
  ADD KEY `id_materia` (`id_materia`);

--
-- Indices de la tabla `asesoria`
--
ALTER TABLE `asesoria`
  ADD PRIMARY KEY (`id_asesoria`),
  ADD UNIQUE KEY `id_asesoria` (`id_asesoria`),
  ADD KEY `registro` (`registro`),
  ADD KEY `idAse` (`idAse`),
  ADD KEY `id_horario` (`id_horario`),
  ADD KEY `id_materia` (`id_materia`),
  ADD KEY `id_solicitud` (`id_solicitud`);

--
-- Indices de la tabla `casoespecial`
--
ALTER TABLE `casoespecial`
  ADD PRIMARY KEY (`id_caso`),
  ADD KEY `id_asesoria` (`id_asesoria`);

--
-- Indices de la tabla `comentario`
--
ALTER TABLE `comentario`
  ADD PRIMARY KEY (`id_comentario`),
  ADD KEY `id_opinion` (`id_opinion`);

--
-- Indices de la tabla `horario`
--
ALTER TABLE `horario`
  ADD PRIMARY KEY (`id_horario`);

--
-- Indices de la tabla `listaespera`
--
ALTER TABLE `listaespera`
  ADD PRIMARY KEY (`id_espera`);

--
-- Indices de la tabla `materia`
--
ALTER TABLE `materia`
  ADD PRIMARY KEY (`id_materia`);

--
-- Indices de la tabla `opinion`
--
ALTER TABLE `opinion`
  ADD PRIMARY KEY (`id_opinion`),
  ADD KEY `registro` (`registro`),
  ADD KEY `id_asesoria` (`id_asesoria`);

--
-- Indices de la tabla `reporte`
--
ALTER TABLE `reporte`
  ADD PRIMARY KEY (`id_reporte`),
  ADD KEY `id_asesoria` (`id_asesoria`),
  ADD KEY `id_horario` (`id_horario`);

--
-- Indices de la tabla `solicitudasesoria`
--
ALTER TABLE `solicitudasesoria`
  ADD PRIMARY KEY (`id_solicitud`),
  ADD KEY `id_espera` (`id_espera`);

--
-- Indices de la tabla `supervisor`
--
ALTER TABLE `supervisor`
  ADD KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id_usuario`);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `administrador`
--
ALTER TABLE `administrador`
  ADD CONSTRAINT `administrador_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`);

--
-- Filtros para la tabla `alumno`
--
ALTER TABLE `alumno`
  ADD CONSTRAINT `alumno_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`);

--
-- Filtros para la tabla `asesor`
--
ALTER TABLE `asesor`
  ADD CONSTRAINT `asesor_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`),
  ADD CONSTRAINT `asesor_ibfk_2` FOREIGN KEY (`id_materia`) REFERENCES `materia` (`id_materia`);

--
-- Filtros para la tabla `asesoria`
--
ALTER TABLE `asesoria`
  ADD CONSTRAINT `asesoria_ibfk_1` FOREIGN KEY (`registro`) REFERENCES `alumno` (`Registro`),
  ADD CONSTRAINT `asesoria_ibfk_2` FOREIGN KEY (`idAse`) REFERENCES `asesor` (`IdAse`),
  ADD CONSTRAINT `asesoria_ibfk_3` FOREIGN KEY (`id_horario`) REFERENCES `horario` (`id_horario`),
  ADD CONSTRAINT `asesoria_ibfk_4` FOREIGN KEY (`id_materia`) REFERENCES `materia` (`id_materia`),
  ADD CONSTRAINT `asesoria_ibfk_5` FOREIGN KEY (`id_solicitud`) REFERENCES `solicitudasesoria` (`id_solicitud`);

--
-- Filtros para la tabla `casoespecial`
--
ALTER TABLE `casoespecial`
  ADD CONSTRAINT `casoespecial_ibfk_1` FOREIGN KEY (`id_asesoria`) REFERENCES `asesoria` (`id_asesoria`);

--
-- Filtros para la tabla `comentario`
--
ALTER TABLE `comentario`
  ADD CONSTRAINT `comentario_ibfk_1` FOREIGN KEY (`id_opinion`) REFERENCES `opinion` (`id_opinion`);

--
-- Filtros para la tabla `opinion`
--
ALTER TABLE `opinion`
  ADD CONSTRAINT `opinion_ibfk_1` FOREIGN KEY (`registro`) REFERENCES `alumno` (`Registro`),
  ADD CONSTRAINT `opinion_ibfk_2` FOREIGN KEY (`id_asesoria`) REFERENCES `asesoria` (`id_asesoria`);

--
-- Filtros para la tabla `reporte`
--
ALTER TABLE `reporte`
  ADD CONSTRAINT `reporte_ibfk_1` FOREIGN KEY (`id_asesoria`) REFERENCES `asesoria` (`id_asesoria`),
  ADD CONSTRAINT `reporte_ibfk_2` FOREIGN KEY (`id_horario`) REFERENCES `horario` (`id_horario`);

--
-- Filtros para la tabla `solicitudasesoria`
--
ALTER TABLE `solicitudasesoria`
  ADD CONSTRAINT `solicitudasesoria_ibfk_1` FOREIGN KEY (`id_espera`) REFERENCES `listaespera` (`id_espera`);

--
-- Filtros para la tabla `supervisor`
--
ALTER TABLE `supervisor`
  ADD CONSTRAINT `supervisor_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuario` (`id_usuario`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
