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
-- Table `mydb`.`waiver_limit_rule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`waiver_limit_rule` (
  `transfer_entry_level` INT NOT NULL,
  `transfer_grade` VARCHAR(45) NOT NULL,
  `max_waiver_credits` INT NOT NULL,
  PRIMARY KEY (`transfer_entry_level`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`student` (
  `student_id` VARCHAR(9) NOT NULL,
  `student_name` VARCHAR(45) NOT NULL,
  `entry_year` VARCHAR(3) NOT NULL,
  `student_type` VARCHAR(45) NOT NULL,
  `transfer_entry_level` INT NULL,
  PRIMARY KEY (`student_id`),
  INDEX `fk_student_waiver_limit_rule1_idx` (`transfer_entry_level` ASC) VISIBLE,
  CONSTRAINT `fk_student_waiver_limit_rule1`
    FOREIGN KEY (`transfer_entry_level`)
    REFERENCES `mydb`.`waiver_limit_rule` (`transfer_entry_level`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`college`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`college` (
  `college_id` VARCHAR(3) NOT NULL,
  `college_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`college_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`department` (
  `department_id` VARCHAR(3) NOT NULL,
  `department_name` VARCHAR(45) NOT NULL,
  `college_id` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`department_id`),
  INDEX `fk_department_college1_idx` (`college_id` ASC) VISIBLE,
  CONSTRAINT `fk_department_college1`
    FOREIGN KEY (`college_id`)
    REFERENCES `mydb`.`college` (`college_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`course`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`course` (
  `course_id` VARCHAR(9) NOT NULL,
  `course_name` VARCHAR(100) NOT NULL,
  `credits` INT NOT NULL,
  `department_id` VARCHAR(3) NOT NULL,
  `category` VARCHAR(45) NOT NULL,
  `is_core_ge` TINYINT(1) NULL COMMENT '\'是否為核心通識\'',
  PRIMARY KEY (`course_id`),
  INDEX `fk_course_department1_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_course_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `mydb`.`department` (`department_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`take_record`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`take_record` (
  `student_id` VARCHAR(9) NOT NULL,
  `course_id` VARCHAR(9) NOT NULL,
  `semester` VARCHAR(3) NOT NULL,
  `score` INT NOT NULL,
  `passed` TINYINT(1) NOT NULL,
  PRIMARY KEY (`student_id`, `course_id`, `semester`),
  INDEX `fk_student_has_course_course1_idx` (`course_id` ASC) VISIBLE,
  INDEX `fk_student_has_course_student1_idx` (`student_id` ASC) VISIBLE,
  CONSTRAINT `fk_student_has_course_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `mydb`.`student` (`student_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_student_has_course_course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `mydb`.`course` (`course_id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`graduation_rule`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`graduation_rule` (
  `rule_id` INT NOT NULL,
  `entry_year` VARCHAR(3) NOT NULL,
  `total_credits_min` INT NOT NULL,
  PRIMARY KEY (`rule_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`rule_condition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`rule_condition` (
  `condition_id` INT NOT NULL,
  `rule_id` INT NOT NULL,
  `category` VARCHAR(45) NOT NULL,
  `min_credits` INT NULL,
  `max_credits` INT NULL,
  `min_courses` INT NULL COMMENT '用來處理體育',
  `restrict_dept_id` VARCHAR(3) NULL,
  `restrict_college_id` VARCHAR(3) NULL,
  PRIMARY KEY (`condition_id`),
  INDEX `fk_rule_condition_graduation_rule1_idx` (`rule_id` ASC) VISIBLE,
  INDEX `fk_rule_condition_department1_idx` (`restrict_dept_id` ASC) VISIBLE,
  INDEX `fk_rule_condition_college1_idx` (`restrict_college_id` ASC) VISIBLE,
  CONSTRAINT `fk_rule_condition_graduation_rule1`
    FOREIGN KEY (`rule_id`)
    REFERENCES `mydb`.`graduation_rule` (`rule_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_rule_condition_department1`
    FOREIGN KEY (`restrict_dept_id`)
    REFERENCES `mydb`.`department` (`department_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_rule_condition_college1`
    FOREIGN KEY (`restrict_college_id`)
    REFERENCES `mydb`.`college` (`college_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`credit_waiver`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`credit_waiver` (
  `waiver_id` VARCHAR(20) NOT NULL,
  `student_id` VARCHAR(9) NOT NULL,
  `course_id` VARCHAR(9) NOT NULL,
  `original_course_name` VARCHAR(100) NOT NULL,
  `credits` INT NOT NULL,
  PRIMARY KEY (`waiver_id`, `student_id`),
  INDEX `fk_credit_waiver_student1_idx` (`student_id` ASC) VISIBLE,
  INDEX `fk_credit_waiver_course1_idx` (`course_id` ASC) VISIBLE,
  CONSTRAINT `fk_credit_waiver_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `mydb`.`student` (`student_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_credit_waiver_course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `mydb`.`course` (`course_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
