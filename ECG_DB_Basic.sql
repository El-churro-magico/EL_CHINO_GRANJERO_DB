
-- MySQL Script generated by MySQL Workbench
-- Sat Oct  3 21:18:29 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ELCHINOGRANJEROTEST
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ELCHINOGRANJEROTEST
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ELCHINOGRANJERO` DEFAULT CHARACTER SET utf8 ;
USE `ELCHINOGRANJERO` ;

-- -----------------------------------------------------
-- Table `ELCHINOGRANJERO`.`PRODUCTORES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ELCHINOGRANJERO`.`PRODUCTORES` (
  `Cedula` INT NOT NULL,
  `Nombre` VARCHAR(20) NOT NULL,
  `Apellidos` VARCHAR(45) NOT NULL,
  `Provincia` VARCHAR(12) NOT NULL,
  `Canton` VARCHAR(30) NOT NULL,
  `Distrito` VARCHAR(30) NOT NULL,
  `Direccion` VARCHAR(75) NOT NULL,
  `Telefono` INT NOT NULL,
  `Fecha_Nacimiento` VARCHAR(25) NOT NULL,
  `Num_Sinpe` INT NOT NULL,
  `Calificacion` FLOAT NOT NULL DEFAULT 5,
  `Lugares_Entrega` VARCHAR(200) NOT NULL,
  `nombreNegocio` VARCHAR(150) NOT NULL,
  `Password` VARCHAR(500) NOT NULL,
  `Salt` VARCHAR(32),
  `Imagen` VARCHAR(200) NULL DEFAULT 'https://i.imgur.com/fj91AfX.jpeg',
  PRIMARY KEY (`Cedula`),
  UNIQUE INDEX `Cedula_UNIQUE` (`Cedula` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ELCHINOGRANJERO`.`CLIENTES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ELCHINOGRANJERO`.`CLIENTES` (
  `Cedula` INT NOT NULL,
  `Nombre` VARCHAR(20) NOT NULL,
  `Apellidos` VARCHAR(45) NOT NULL,
  `Provincia` VARCHAR(12) NOT NULL,
  `Canton` VARCHAR(30) NOT NULL,
  `Distrito` VARCHAR(30) NOT NULL,
  `Direccion` VARCHAR(75) NOT NULL,
  `Telefono` INT NOT NULL,
  `Fecha_Nacimiento` VARCHAR(30) NOT NULL,
  `Usuario` VARCHAR(15) NOT NULL,
  `Password` VARCHAR(500) NOT NULL,
  `Salt` VARCHAR(32),
  `Compras` INT NOT NULL,
  PRIMARY KEY (`Cedula`),
  UNIQUE INDEX `Cedula_UNIQUE` (`Cedula` ASC) VISIBLE,
  UNIQUE INDEX `Usuario_UNIQUE` (`Usuario` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ELCHINOGRANJERO`.`CATEGORIAS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ELCHINOGRANJERO`.`CATEGORIAS` (
  `ID` INT NOT NULL,
  `Nombre` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
  UNIQUE INDEX `Nombre_UNIQUE` (`Nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ELCHINOGRANJERO`.`PRODUCTOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ELCHINOGRANJERO`.`PRODUCTOS` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(25) NOT NULL,
  `Categoria` INT NULL,
  `Productor` INT NULL,
  `Foto` VARCHAR(500) NULL,
  `Precio` FLOAT NOT NULL,
  `Modo_Venta` VARCHAR(15) NOT NULL,
  `Disponibilidad` INT NOT NULL,
  `Ganancias` FLOAT NOT NULL,
  `Vendidos` INT NOT NULL Default 0,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
  INDEX `Productor_idx` (`Productor` ASC) VISIBLE,
  INDEX `Categorias_idx` (`Categoria` ASC) VISIBLE,
  CONSTRAINT `ID_Productor`
    FOREIGN KEY (`Productor`)
    REFERENCES `ELCHINOGRANJERO`.`PRODUCTORES` (`Cedula`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Categorias`
    FOREIGN KEY (`Categoria`)
    REFERENCES `ELCHINOGRANJERO`.`CATEGORIAS` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ELCHINOGRANJERO`.`AFILIACIONES`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ELCHINOGRANJERO`.`AFILIACIONES` (
  `Cedula` INT NOT NULL,
  `Nombre` VARCHAR(20) NOT NULL,
  `Apellidos` VARCHAR(45) NOT NULL,
  `Provincia` VARCHAR(12) NOT NULL,
  `Canton` VARCHAR(30) NOT NULL,
  `Distrito` VARCHAR(30) NOT NULL,
  `Direccion` VARCHAR(75) NOT NULL,
  `Telefono` INT NOT NULL,
  `Fecha_Nacimiento` VARCHAR(45) NOT NULL,
  `Num_Sinpe` INT NOT NULL,
  `Comentario` VARCHAR(150) NOT NULL DEFAULT 5,
  `Estado` VARCHAR(15) NOT NULL,
  `nombreNegocio` VARCHAR(50) NOT NULL,
  `Password` VARCHAR(32) NOT NULL,
  PRIMARY KEY (`Cedula`),
  UNIQUE INDEX `Cedula_UNIQUE` (`Cedula` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ELCHINOGRANJERO`.`PEDIDOS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ELCHINOGRANJERO`.`PEDIDOS` (
  `ID` INT NOT NULL,
  `Cliente` INT NULL,
  `Productor` INT NULL,
  `ID_Producto` INT NULL,
  `Comprobante` VARCHAR(400) NULL,
  `Direccion` VARCHAR(75) NULL, 
  `Estado` VARCHAR(25) NULL,
  `Cantidad` INT NULL,
  INDEX `Pedido_Productor_idx` (`Productor` ASC) VISIBLE,
  INDEX `Pedido_Cliente_idx` (`Cliente` ASC) VISIBLE,
  CONSTRAINT `Pedido_Productor`
    FOREIGN KEY (`Productor`)
    REFERENCES `ELCHINOGRANJERO`.`PRODUCTORES` (`Cedula`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Pedido_Cliente`
    FOREIGN KEY (`Cliente`)
    REFERENCES `ELCHINOGRANJERO`.`CLIENTES` (`Cedula`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Pedido_Producto`
    FOREIGN KEY (`ID_Producto`)
    REFERENCES `ELCHINOGRANJERO`.`PRODUCTOS` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `ELCHINOGRANJERO`.`TOKENS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ELCHINOGRANJERO`.`TOKENS` (
  `Usuario` INT NOT NULL,
  `Token` VARCHAR(32) NULL,
  `Tipo` VARCHAR(25) NULL)
  
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `ELCHINOGRANJERO`.`NOTIFICACIONES` (
  `ID` INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `Productor` INT NOT NULL,
  `Cliente` INT NOT NULL,
  `Mensaje` VARCHAR(500) NOT NULL,
  CONSTRAINT `Notifications_Producer`
    FOREIGN KEY (`Productor`)
    REFERENCES `ELCHINOGRANJERO`.`PRODUCTORES` (`Cedula`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `Notifications_Client`
    FOREIGN KEY (`Cliente`)
    REFERENCES `ELCHINOGRANJERO`.`Clientes` (`Cedula`)
    ON DELETE CASCADE
    ON UPDATE CASCADE) 
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

use elchinogranjerotest;


select * from clientes;
select* from productores;
select* from afiliaciones;
select * from tokens;
select* from productos;
select * from categorias;

INSERT INTO categorias (ID,Nombre) VALUES (1,"Vegetales");
INSERT INTO categorias (ID,Nombre) VALUES (2,"Carnes");
INSERT INTO categorias (ID,Nombre) VALUES (3,"Abarrotes");
INSERT INTO categorias (ID,Nombre) VALUES (4,"Varios");
INSERT INTO categorias (ID,Nombre) VALUES (5,"Mariscos");
INSERT INTO categorias (ID,Nombre) VALUES (6,"Panes");
INSERT INTO categorias (ID,Nombre) VALUES (7,"Frutas");
INSERT INTO categorias (ID,Nombre) VALUES (8,"Cochinadas");
