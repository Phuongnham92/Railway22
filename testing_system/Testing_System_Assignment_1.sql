CREATE DATABASE IF NOT EXISTS testing_system; 
DROP TABLE IF EXISTS Department,
Position,
`Account`,
`Group`,
GroupAccount,
TypeQuestion,
CategoryQuestion,
Question,
Answer,
Exam,
ExamQuestion;

CREATE TABLE Department
	(
    Department_ID	INT AUTO_INCREMENT PRIMARY KEY,
	Department_Name	VARCHAR(100)
    );
    
CREATE TABLE Position
(
	Position_ID INT AUTO_INCREMENT PRIMARY KEY,
	Position_Name	ENUM("Dev","Test","Scrum Master","PM")
    );
    
CREATE TABLE `Account`
(
	Account_ID	INT AUTO_INCREMENT PRIMARY KEY,
    Email	VARCHAR(100),
	Username	VARCHAR(100),
    FullName	VARCHAR(100),
    Department_ID INT,
    Position_ID	INT,
    CreateDate	DATE
    );
    
CREATE TABLE `Groups`
(
	Group_ID	INT AUTO_INCREMENT PRIMARY KEY,
	Group_Name	VARCHAR(100),
	Creator_ID	INT(100),
	Create_Date	INT(100)
    );
    
CREATE TABLE GroupAccount
	(
	Group_ID	INT AUTO_INCREMENT PRIMARY KEY,
	Account_ID INT,
	Join_Date	DATE,
    PRIMARY KEY(Group_ID, Account_ID)
    );
    
CREATE TABLE TypeQuestion
	(
    TypeID	INT AUTO_INCREMENT PRIMARY KEY,
    TypeName	ENUM("essay","multiple-choice")
  );
  
CREATE TABLE CategoryQuestion
	(
	CategoryID INT 
    AUTO_INCREMENT PRIMARY KEY,
	CategoryName	VARCHAR(100)
    );
 
CREATE TABLE Question
	(
	Question_ID INT AUTO_INCREMENT PRIMARY KEY,
	Content TEXT,
	Category_ID	VARCHAR(100),
	Type_ID INT,
	Creator_ID	INT,
	Create_Date	DATE
    );
    
 CREATE TABLE Answer
 (
	Answer_ID	INT 
    AUTO_INCREMENT PRIMARY KEY,
	Content	TEXT(100),
	Question_ID	INT,
	isCorrect BINARY
    );
    
CREATE TABLE Exam
	(
    ExamID	INT AUTO_INCREMENT PRIMARY KEY,
	`Code`	CHAR(10),
	Title	VARCHAR(100),
	Category_ID	INT,
 	Duration	INT,
 	Creator_ID	INT,
 	Create_Date	DATE
    );

CREATE TABLE ExamQuestion
	(
    Exam_ID	INT,
    Question_ID	INT,
    PRIMARY KEY("Exam_ID","Question_ID")
    );
    
    

  


