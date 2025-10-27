-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.4.32-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.11.0.7065
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para hospitalbq
CREATE DATABASE IF NOT EXISTS `hospitalbq` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `hospitalbq`;

-- Volcando estructura para tabla hospitalbq.citas
CREATE TABLE IF NOT EXISTS `citas` (
  `id_cita` int(11) NOT NULL AUTO_INCREMENT,
  `id_paciente` int(11) NOT NULL,
  `id_doctor` int(11) NOT NULL,
  `fecha_cita` datetime NOT NULL,
  `motivo_consulta` varchar(255) DEFAULT NULL,
  `estado` enum('Programada','Completada','Cancelada') DEFAULT 'Programada',
  PRIMARY KEY (`id_cita`),
  KEY `id_paciente` (`id_paciente`),
  KEY `id_doctor` (`id_doctor`),
  CONSTRAINT `citas_ibfk_1` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id_paciente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `citas_ibfk_2` FOREIGN KEY (`id_doctor`) REFERENCES `doctores` (`id_doctor`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla hospitalbq.citas: ~5 rows (aproximadamente)
INSERT IGNORE INTO `citas` (`id_cita`, `id_paciente`, `id_doctor`, `fecha_cita`, `motivo_consulta`, `estado`) VALUES
	(1, 1, 1, '2025-10-27 09:00:00', 'Dolor torácico', 'Completada'),
	(2, 2, 2, '2025-10-28 10:30:00', 'Fiebre y dolor de garganta', 'Programada'),
	(3, 3, 3, '2025-10-29 08:15:00', 'Dolores de cabeza frecuentes', 'Programada'),
	(4, 4, 4, '2025-10-30 14:00:00', 'Control postoperatorio', 'Completada'),
	(5, 5, 5, '2025-11-01 11:00:00', 'Chequeo general', 'Programada');

-- Volcando estructura para tabla hospitalbq.doctores
CREATE TABLE IF NOT EXISTS `doctores` (
  `id_doctor` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  `id_especialidad` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_doctor`),
  UNIQUE KEY `correo` (`correo`),
  KEY `id_especialidad` (`id_especialidad`),
  CONSTRAINT `doctores_ibfk_1` FOREIGN KEY (`id_especialidad`) REFERENCES `especialidades` (`id_especialidad`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla hospitalbq.doctores: ~9 rows (aproximadamente)
INSERT IGNORE INTO `doctores` (`id_doctor`, `nombre`, `apellido`, `telefono`, `correo`, `id_especialidad`) VALUES
	(1, 'Ana', 'Pérez', '3001112233', 'ana.perez@hospital.com', 1),
	(2, 'Carlos', 'Gómez', '3102223344', 'carlos.gomez@hospital.com', 2),
	(3, 'Javier', 'Ramírez', '3203334455', 'javier.ramirez@hospital.com', 3),
	(4, 'Diana', 'Lozano', '3104445566', 'diana.lozano@hospital.com', 4),
	(5, 'Andrés', 'Moreno', '3005556677', 'andres.moreno@hospital.com', 5),
	(6, 'Luisa', 'Torres', '3106667788', 'luisa.torres@hospital.com', 6),
	(7, 'Marta', 'Rojas', '3207778899', 'marta.rojas@hospital.com', 7),
	(8, 'Diego', 'Hernández', '3118889900', 'diego.hernandez@hospital.com', 8),
	(9, 'Kevin', 'Almario', '3107095196', 'kevin.almario@hospital.com', 3);

-- Volcando estructura para tabla hospitalbq.especialidades
CREATE TABLE IF NOT EXISTS `especialidades` (
  `id_especialidad` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  PRIMARY KEY (`id_especialidad`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla hospitalbq.especialidades: ~8 rows (aproximadamente)
INSERT IGNORE INTO `especialidades` (`id_especialidad`, `nombre`, `descripcion`) VALUES
	(1, 'Cardiología', 'Tratamiento de enfermedades del corazón'),
	(2, 'Pediatría', 'Atención médica a niños'),
	(3, 'Neurología', 'Trastornos del sistema nervioso'),
	(4, 'Oncología', 'Tratamiento de cáncer'),
	(5, 'Medicina Interna', 'Atención general de adultos'),
	(6, 'Traumatología', 'Lesiones óseas y musculares'),
	(7, 'Ginecología', 'Salud reproductiva femenina'),
	(8, 'Psiquiatría', 'Trastornos mentales y emocionales');

-- Volcando estructura para tabla hospitalbq.habitaciones
CREATE TABLE IF NOT EXISTS `habitaciones` (
  `id_habitacion` int(11) NOT NULL AUTO_INCREMENT,
  `numero_habitacion` varchar(10) NOT NULL,
  `tipo` enum('UCI','General','Maternidad','Pediátrica','Aislamiento') NOT NULL,
  `estado` enum('Disponible','Ocupada','Mantenimiento') DEFAULT 'Disponible',
  PRIMARY KEY (`id_habitacion`),
  UNIQUE KEY `numero_habitacion` (`numero_habitacion`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla hospitalbq.habitaciones: ~8 rows (aproximadamente)
INSERT IGNORE INTO `habitaciones` (`id_habitacion`, `numero_habitacion`, `tipo`, `estado`) VALUES
	(1, '101', 'General', 'Disponible'),
	(2, '102', 'General', 'Ocupada'),
	(3, '201', 'UCI', 'Ocupada'),
	(4, '202', 'UCI', 'Disponible'),
	(5, '301', 'Maternidad', 'Disponible'),
	(6, '302', 'Pediátrica', 'Ocupada'),
	(7, '401', 'Aislamiento', 'Disponible'),
	(8, '402', 'Aislamiento', 'Disponible');

-- Volcando estructura para tabla hospitalbq.medicamentos
CREATE TABLE IF NOT EXISTS `medicamentos` (
  `id_medicamento` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `dosis_recomendada` varchar(50) DEFAULT NULL,
  `presentacion` enum('Tableta','Jarabe','Inyección','Cápsula','Pomada') DEFAULT NULL,
  `stock` int(11) DEFAULT 0,
  `fecha_vencimiento` date DEFAULT NULL,
  PRIMARY KEY (`id_medicamento`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla hospitalbq.medicamentos: ~8 rows (aproximadamente)
INSERT IGNORE INTO `medicamentos` (`id_medicamento`, `nombre`, `descripcion`, `dosis_recomendada`, `presentacion`, `stock`, `fecha_vencimiento`) VALUES
	(1, 'Paracetamol', 'Analgésico y antipirético', '500 mg cada 8h', 'Tableta', 200, '2026-05-01'),
	(2, 'Amoxicilina', 'Antibiótico de amplio espectro', '500 mg cada 12h', 'Cápsula', 150, '2025-12-31'),
	(3, 'Ibuprofeno', 'Antiinflamatorio no esteroideo', '400 mg cada 8h', 'Tableta', 300, '2027-01-01'),
	(4, 'Omeprazol', 'Inhibidor de la bomba de protones', '20 mg al día', 'Cápsula', 250, '2026-08-15'),
	(5, 'Loratadina', 'Antialérgico', '10 mg al día', 'Tableta', 180, '2027-03-10'),
	(6, 'Metformina', 'Antidiabético oral', '850 mg cada 12h', 'Tableta', 400, '2025-09-30'),
	(7, 'Furosemida', 'Diurético', '40 mg al día', 'Tableta', 120, '2026-12-01'),
	(8, 'Cefalexina', 'Antibiótico', '500 mg cada 8h', 'Cápsula', 130, '2026-10-20');

-- Volcando estructura para tabla hospitalbq.pacientes
CREATE TABLE IF NOT EXISTS `pacientes` (
  `id_paciente` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `genero` enum('Masculino','Femenino','Otro') NOT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  `tipo_sangre` varchar(5) DEFAULT NULL,
  `fecha_ingreso` date DEFAULT curdate(),
  `id_habitacion` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_paciente`),
  KEY `id_habitacion` (`id_habitacion`),
  CONSTRAINT `pacientes_ibfk_1` FOREIGN KEY (`id_habitacion`) REFERENCES `habitaciones` (`id_habitacion`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla hospitalbq.pacientes: ~5 rows (aproximadamente)
INSERT IGNORE INTO `pacientes` (`id_paciente`, `nombre`, `apellido`, `fecha_nacimiento`, `genero`, `direccion`, `telefono`, `tipo_sangre`, `fecha_ingreso`, `id_habitacion`) VALUES
	(1, 'Laura', 'Martínez', '1990-07-12', 'Femenino', 'Cra 10 #5-23', '3115678901', 'O+', '2025-10-27', 2),
	(2, 'Pedro', 'López', '1985-06-10', 'Masculino', 'Calle 23 #7-90', '3124567890', 'A+', '2025-10-27', 3),
	(3, 'Lucía', 'Mendoza', '2001-03-05', 'Femenino', 'Av 5 #22-14', '3001239876', 'B-', '2025-10-27', 6),
	(4, 'Ricardo', 'Díaz', '1975-09-19', 'Masculino', 'Calle 8 #9-15', '3101112233', 'AB+', '2025-10-27', 1),
	(5, 'Sara', 'Cruz', '1995-11-02', 'Femenino', 'Cra 45 #15-32', '3204445566', 'O-', '2025-10-27', 5);

-- Volcando estructura para tabla hospitalbq.tratamientos
CREATE TABLE IF NOT EXISTS `tratamientos` (
  `id_tratamiento` int(11) NOT NULL AUTO_INCREMENT,
  `id_paciente` int(11) NOT NULL,
  `id_doctor` int(11) DEFAULT NULL,
  `id_medicamento` int(11) DEFAULT NULL,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date DEFAULT NULL,
  `dosis_diaria` varchar(50) DEFAULT NULL,
  `observaciones` text DEFAULT NULL,
  PRIMARY KEY (`id_tratamiento`),
  KEY `id_paciente` (`id_paciente`),
  KEY `id_doctor` (`id_doctor`),
  KEY `id_medicamento` (`id_medicamento`),
  CONSTRAINT `tratamientos_ibfk_1` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id_paciente`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tratamientos_ibfk_2` FOREIGN KEY (`id_doctor`) REFERENCES `doctores` (`id_doctor`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `tratamientos_ibfk_3` FOREIGN KEY (`id_medicamento`) REFERENCES `medicamentos` (`id_medicamento`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla hospitalbq.tratamientos: ~5 rows (aproximadamente)
INSERT IGNORE INTO `tratamientos` (`id_tratamiento`, `id_paciente`, `id_doctor`, `id_medicamento`, `fecha_inicio`, `fecha_fin`, `dosis_diaria`, `observaciones`) VALUES
	(1, 1, 1, 1, '2025-10-27', '2025-11-03', '500 mg cada 8h', 'Tomar después de las comidas'),
	(2, 2, 2, 2, '2025-10-28', '2025-11-05', '500 mg cada 12h', 'Completar el tratamiento de antibiótico'),
	(3, 3, 3, 3, '2025-10-29', NULL, '400 mg cada 8h', 'En caso de dolor fuerte, tomar antes de dormir'),
	(4, 4, 4, 4, '2025-10-25', '2025-10-31', '20 mg al día', 'Tomar en ayunas'),
	(5, 5, 5, 5, '2025-11-01', NULL, '10 mg al día', 'No exceder la dosis recomendada');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
