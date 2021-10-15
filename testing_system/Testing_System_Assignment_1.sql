-- tao database 
CREATE DATABASE IF NOT EXISTS testing_system; 
DROP TABLE IF EXISTS department,
position,
`account`,
`group`,
group_account,
type_question,
category_question,
question,
answer,
exam,
exam_question;

CREATE TABLE department
	(
    department_id	INT AUTO_INCREMENT PRIMARY KEY,
	department_name	VARCHAR(100)
    );
    
CREATE TABLE position
(
	position_id INT AUTO_INCREMENT PRIMARY KEY,
	position_name	ENUM("Dev","Test","Scrum Master","PM")
    );
    
CREATE TABLE `account`
(
	account_id	INT AUTO_INCREMENT PRIMARY KEY,
    email	VARCHAR(100),
	user_name	VARCHAR(100),
    full_name	VARCHAR(100),
    department_id INT,
    position_id	INT,
    create_date	DATE
    );
    
CREATE TABLE `groups`
(
	group_id	INT AUTO_INCREMENT PRIMARY KEY,
	group_name	VARCHAR(100),
	creator_id	INT(100),
	create_date	INT(100)
    );
    
CREATE TABLE group_account
	(
	group_id	INT AUTO_INCREMENT PRIMARY KEY,
	account_id	INT,
	join_date	DATE,
    PRIMARY KEY(group_id, account_id)
    );
    
CREATE TABLE type_question
	(
    type_id	INT AUTO_INCREMENT PRIMARY KEY,
    type_name	ENUM("essay","multiple-choice")
  );
  
CREATE TABLE category_question
	(
	category_id INT 
    AUTO_INCREMENT PRIMARY KEY,
	category_name	VARCHAR(100)
    );
 
CREATE TABLE question
	(
	question_id INT AUTO_INCREMENT PRIMARY KEY,
	content TEXT,
	category_id	VARCHAR(100),
	type_id INT,
	creator_id	INT,
	create_date	DATE
    );
    
 CREATE TABLE answer
 (
	answer_id	INT 
    AUTO_INCREMENT PRIMARY KEY,
	content	TEXT(100),
	question_id	INT,
	iscorrect BINARY
    );
    
CREATE TABLE exam
	(
    exam_id	INT AUTO_INCREMENT PRIMARY KEY,
	`code`	CHAR(10),
	title	VARCHAR(100),
	category_id	INT,
 	duration	INT,
 	creator_id	INT,
 	create_date	DATE
    );

CREATE TABLE exam_question
	(
    exam_id	INT,
    question_id	INT,
    PRIMARY KEY(`exam_id`,`question_id`)
    );
    
    

  


