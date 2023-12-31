-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema little_lemon_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema little_lemon_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `little_lemon_db` DEFAULT CHARACTER SET utf8 ;
USE `little_lemon_db` ;

-- -----------------------------------------------------
-- Table `little_lemon_db`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`Bookings` (
  `booking_id` INT NOT NULL,
  `booking_date` DATE NOT NULL,
  `table_number` INT NOT NULL,
  PRIMARY KEY (`booking_id`),
  UNIQUE INDEX `booking_id_UNIQUE` (`booking_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`Menu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`Menu` (
  `item_id` INT NOT NULL,
  `item_category` VARCHAR(45) NOT NULL,
  `item_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`item_id`),
  UNIQUE INDEX `item_id_UNIQUE` (`item_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`Staff` (
  `staff_id` INT NOT NULL,
  `staff_name` VARCHAR(45) NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  `salary` INT NOT NULL,
  PRIMARY KEY (`staff_id`),
  UNIQUE INDEX `staff_id_UNIQUE` (`staff_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`Customers` (
  `customer_id` INT NOT NULL,
  `customer_name` VARCHAR(45) NOT NULL,
  `contact_number` INT NOT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE INDEX `customer_id_UNIQUE` (`customer_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`Orders` (
  `order_id` INT NOT NULL,
  `item_id` INT NOT NULL,
  `staff_id` INT NOT NULL,
  `customer_id` INT NOT NULL,
  `booking_id` INT NOT NULL,
  `order_date` DATE NOT NULL,
  `quantity` INT NOT NULL,
  `total_cost` INT NOT NULL,
  PRIMARY KEY (`order_id`, `item_id`, `staff_id`, `customer_id`, `booking_id`),
  UNIQUE INDEX `order_id_UNIQUE` (`order_id` ASC) VISIBLE,
  INDEX `fk_Orders_Menu1_idx` (`item_id` ASC) VISIBLE,
  INDEX `fk_Orders_Bookings1_idx` (`booking_id` ASC) VISIBLE,
  INDEX `fk_Orders_Staff1_idx` (`staff_id` ASC) VISIBLE,
  INDEX `fk_Orders_Customers1_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Menu1`
    FOREIGN KEY (`item_id`)
    REFERENCES `little_lemon_db`.`Menu` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Bookings1`
    FOREIGN KEY (`booking_id`)
    REFERENCES `little_lemon_db`.`Bookings` (`booking_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Staff1`
    FOREIGN KEY (`staff_id`)
    REFERENCES `little_lemon_db`.`Staff` (`staff_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Customers1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `little_lemon_db`.`Customers` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `little_lemon_db`.`Orders_Delivery_Status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `little_lemon_db`.`Orders_Delivery_Status` (
  `order_id` INT NOT NULL,
  `item_id` INT NOT NULL,
  `delivery_date` DATE NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`order_id`, `item_id`),
  INDEX `fk_Orders_Delivery_Status_Orders1_idx` (`order_id` ASC, `item_id` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Delivery_Status_Orders1`
    FOREIGN KEY (`order_id` , `item_id`)
    REFERENCES `little_lemon_db`.`Orders` (`order_id` , `item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
