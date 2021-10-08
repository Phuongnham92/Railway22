CREATE DATABASE IF NOT EXISTS testing_system; 
DROP TABLE IF EXISTS Department,
Position,
`Account`,
`Group`,
GroupAccount,
TypeQuestion,
CategoryQuestion,.
Question,
Answer,
Exam,
ExamQuestion;

CREATE TABLE Department
	(
    Department_ID	TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Department_Name	VARCHAR(100) NOT NULL
    );
    
CREATE TABLE Position
(
	Position_ID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Position_Name	ENUM("Dev","Test","Scrum Master","PM") DEFAULT"Dev"
    );
    
CREATE TABLE `Account`
(
	Account_ID		INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Email			VARCHAR(50) UNIQUE NOT NULL,
	Username		VARCHAR(100) UNIQUE NOT NULL,
    FullName		VARCHAR(100) NOT NULL,
    Gender			BIT DEFAULT 1,
    Department_ID	TINYINT,
    Position_ID		TINYINT,
    CreateDate		DATE
    );
    
CREATE TABLE `Groups`
(
	Group_ID	TINYINT AUTO_INCREMENT PRIMARY KEY,
	Group_Name	VARCHAR(100) NOT NULL,
	Creator_ID	INT,
	Create_Date	DATE
    );
    
CREATE TABLE Group_Account
	(
	Group_ID	INT AUTO_INCREMENT PRIMARY KEY,
	Account_ID TINYINT,
	Join_Date	DATE,
    PRIMARY KEY(Group_ID, Account_ID)
    );
    
CREATE TABLE TypeQuestion
	(
    TypeID	TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    TypeName	ENUM("essay","multiple-choice") DEFAULT"aultiple_choice"
  );
  
CREATE TABLE CategoryQuestion
	(
	CategoryID TINYINT 
    AUTO_INCREMENT PRIMARY KEY,
	CategoryName	VARCHAR(100) NOT NULL
    );
 
CREATE TABLE Question
	(
	Question_ID 	INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Content 		TEXT,
	Category_ID		TINYINT,
	Type_ID 		INT,
	Creator_ID		INT,
	Create_Date		DATE
    );
    
 CREATE TABLE Answer
 (
	Answer_ID	INT 
    AUTO_INCREMENT PRIMARY KEY,
	Content	TEXT(100),
	Question_ID	INT,
	isCorrect BIT DEFAULT 1
    );
    
CREATE TABLE Exam
	(
    ExamID	INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	`Code`	CHAR(10) UNIQUE NOT NULL,
	Title	VARCHAR(100) NOT NULL,
	Category_ID	INT,
 	Duration	TINYINT,
 	Creator_ID	INT,
 	Create_Date	DATE
    );

CREATE TABLE Exam_Questions
	(
    Exam_ID		INT UNSIGNED,
    Question_ID	INT UNSIGNED,
    PRIMARY KEY(Exam_ID,Question_ID)
    );
    
    

  


