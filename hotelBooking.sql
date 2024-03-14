-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Hotel_Booking
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Hotel_Booking
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Hotel_Booking` DEFAULT CHARACTER SET utf8 ;
USE `Hotel_Booking` ;

-- -----------------------------------------------------
-- Table `Hotel_Booking`.`Country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel_Booking`.`Country` (
  `idCountry` INT NOT NULL,
  `countryName` VARCHAR(45) NULL,
  PRIMARY KEY (`idCountry`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hotel_Booking`.`Guest`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel_Booking`.`Guest` (
  `idGuest` INT NOT NULL,
  `idCountry` INT NULL,
  `isRepeatedGuest` INT NULL,
  `previousCancellations` INT NULL,
  `previousBookingsNotCanceled` INT NULL,
  `nbrAdults` INT NULL,
  `nbrChildren` INT NULL,
  `nbrBabies` INT NULL,
  PRIMARY KEY (`idGuest`),
  CONSTRAINT `FK_Country_Guest` FOREIGN KEY (`idCountry`) 
    REFERENCES `Hotel_Booking`.`Country` (`idCountry`) 
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hotel_Booking`.`DepositType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel_Booking`.`DepositType` (
  `idDepositType` INT NOT NULL,
  `depositTypeName` VARCHAR(45) NULL,
  PRIMARY KEY (`idDepositType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hotel_Booking`.`Year`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel_Booking`.`Year` (
  `idYear` INT NOT NULL,
  `theYear` INT NULL,
  PRIMARY KEY (`idYear`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hotel_Booking`.`Month`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel_Booking`.`Month` (
  `idMonth` INT NOT NULL,
  `theMonth` VARCHAR(45) NULL,
  `idYear` INT NULL,
  PRIMARY KEY (`idMonth`),
  CONSTRAINT `FK_Year_Month` FOREIGN KEY (`idYear`) 
    REFERENCES `Hotel_Booking`.`Year` (`idYear`) 
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hotel_Booking`.`Week`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel_Booking`.`Week` (
  `idWeek` INT NOT NULL,
  `theWeek` INT NULL,
  `idMonth` INT NULL,
  PRIMARY KEY (`idWeek`),
  CONSTRAINT `FK_Month_Week` FOREIGN KEY (`idMonth`) 
    REFERENCES `Hotel_Booking`.`Month` (`idMonth`) 
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hotel_Booking`.`Day`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel_Booking`.`Day` (
  `idDay` INT NOT NULL,
  `theDay` INT NULL,
  `idWeek` INT NULL,
  PRIMARY KEY (`idDay`),
  CONSTRAINT `FK_Week_Day` FOREIGN KEY (`idWeek`) 
    REFERENCES `Hotel_Booking`.`Week` (`idWeek`) 
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hotel_Booking`.`MealPlan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel_Booking`.`MealPlan` (
  `idMealPlan` INT NOT NULL,
  `mealPlanName` VARCHAR(45) NULL,
  PRIMARY KEY (`idMealPlan`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hotel_Booking`.`Hotel Type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel_Booking`.`Hotel Type` (
  `idHotelType` INT NOT NULL,
  `theHotelType` VARCHAR(45) NULL,
  PRIMARY KEY (`idHotelType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hotel_Booking`.`RoomType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel_Booking`.`RoomType` (
  `idRoomType` INT NOT NULL,
  `roomTypeName` VARCHAR(45) NULL,
  `idHotelType` INT NULL,
  PRIMARY KEY (`idRoomType`),
  CONSTRAINT `FK_HotelType_RoomType` FOREIGN KEY (`idHotelType`) 
    REFERENCES `Hotel_Booking`.`Hotel Type` (`idHotelType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hotel_Booking`.`CustomerType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel_Booking`.`CustomerType` (
  `idCustomerType` INT NOT NULL,
  `customerTypeName` VARCHAR(45) NULL,
  PRIMARY KEY (`idCustomerType`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hotel_Booking`.`TotalNightsSpecification`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel_Booking`.`TotalNightsSpecification` (
  `idTotalNightsSpecification` INT NOT NULL,
  `nbrWeekNights` INT NULL,
  `nbrWeekEndNights` INT NULL,
  PRIMARY KEY (`idTotalNightsSpecification`))
ENGINE = InnoDB;

ALTER TABLE `Hotel_Booking`.`TotalNightsSpecification`
MODIFY COLUMN `idNbrOfNights` INT NULL;
CREATE INDEX idx_idNbrOfNights ON `Hotel_Booking`.`TotalNightsSpecification` (`idNbrOfNights`);


-- -----------------------------------------------------
-- Table `Hotel_Booking`.`MarketSegment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel_Booking`.`MarketSegment` (
  `idMarketSegment` INT NOT NULL,
  `segmentName` VARCHAR(45) NULL,
  PRIMARY KEY (`idMarketSegment`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hotel_Booking`.`Reservation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel_Booking`.`Reservation` (
  `idReservation` INT NOT NULL,
  `idGuest` INT NULL,
  `idDepositType` INT NULL,
  `idMealPlan` INT NULL,
  `idRoomType` INT NULL,
  `idCustomerType` INT NULL,
  `idArrivalDate_Day` INT NULL,
  `idNbrOfNights` INT NULL,
  `isCanceled` BINARY(45) NULL,
  `reservationStatus` VARCHAR(45) NULL,
  `reservationStatusDate` DATE NULL,
  `leadTime` INT NULL,
  `ADR` BLOB NULL,
  `idMarketSegment` INT NULL,
  PRIMARY KEY (`idReservation`),
  CONSTRAINT `FK_Guest_Reservation` FOREIGN KEY (`idGuest`) 
    REFERENCES `Hotel_Booking`.`Guest` (`idGuest`) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_DepositType_Reservation` FOREIGN KEY (`idDepositType`) 
    REFERENCES `Hotel_Booking`.`DepositType` (`idDepositType`) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_Day_Reservation` FOREIGN KEY (`idArrivalDate_Day`) 
    REFERENCES `Hotel_Booking`.`Day` (`idDay`) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_MealPlan_Reservation` FOREIGN KEY (`idMealPlan`) 
    REFERENCES `Hotel_Booking`.`MealPlan` (`idMealPlan`) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_RoomType_Reservation` FOREIGN KEY (`idRoomType`) 
    REFERENCES `Hotel_Booking`.`RoomType` (`idRoomType`) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_CustomerType_Reservation` FOREIGN KEY (`idCustomerType`) 
    REFERENCES `Hotel_Booking`.`CustomerType` (`idCustomerType`) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_TotalNightsSpecification_Reservation` FOREIGN KEY (`idNbrOfNights`) 
    REFERENCES `Hotel_Booking`.`TotalNightsSpecification` (`idNbrOfNights`) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_MarketSegment_Reservation` FOREIGN KEY (`idMarketSegment`) 
    REFERENCES `Hotel_Booking`.`MarketSegment` (`idMarketSegment`) 
    ON DELETE NO ACTION 
    ON UPDATE NO ACTION
) ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `Hotel_Booking`.`ReservationStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hotel_Booking`.`ReservationStatus` (
  `idReservationStatus` INT NOT NULL,
  `reservationStatus` VARCHAR(45) NULL,
  PRIMARY KEY (`idReservationStatus`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
