-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`A`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`A` ;

CREATE TABLE IF NOT EXISTS `mydb`.`A` (
  `idA` INT NOT NULL,
  `Acol` VARCHAR(45) NULL,
  PRIMARY KEY (`idA`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`B`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`B` ;

CREATE TABLE IF NOT EXISTS `mydb`.`B` (
  `idB` INT NOT NULL,
  `Bcol` VARCHAR(45) NULL,
  `A_idA` INT NULL,
  PRIMARY KEY (`idB`),
  INDEX `fk_B_A_idx` (`A_idA` ASC) VISIBLE,
  CONSTRAINT `fk_B_A`
    FOREIGN KEY (`A_idA`)
    REFERENCES `mydb`.`A` (`idA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`A2`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`A2` ;

CREATE TABLE IF NOT EXISTS `mydb`.`A2` (
  `idA` INT NOT NULL,
  `Acol` VARCHAR(45) NULL,
  PRIMARY KEY (`idA`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`B2`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`B2` ;

CREATE TABLE IF NOT EXISTS `mydb`.`B2` (
  `idB` INT NOT NULL,
  `Bcol` VARCHAR(45) NULL,
  `A2_idA` INT NOT NULL,
  PRIMARY KEY (`idB`, `A2_idA`),
  INDEX `fk_B2_A21_idx` (`A2_idA` ASC) VISIBLE,
  CONSTRAINT `fk_B2_A21`
    FOREIGN KEY (`A2_idA`)
    REFERENCES `mydb`.`A2` (`idA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`A3`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`A3` ;

CREATE TABLE IF NOT EXISTS `mydb`.`A3` (
  `idA3` INT NOT NULL,
  `A3col` VARCHAR(45) NULL,
  PRIMARY KEY (`idA3`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`B3`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`B3` ;

CREATE TABLE IF NOT EXISTS `mydb`.`B3` (
  `idB3` INT NOT NULL,
  `B3col` VARCHAR(45) NULL,
  `A3_idA3` INT NOT NULL,
  PRIMARY KEY (`idB3`, `A3_idA3`),
  INDEX `fk_B3_A31_idx` (`A3_idA3` ASC) VISIBLE,
  CONSTRAINT `fk_B3_A31`
    FOREIGN KEY (`A3_idA3`)
    REFERENCES `mydb`.`A3` (`idA3`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
