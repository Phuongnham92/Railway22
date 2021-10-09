CREATE DATABASE IF NOT EXISTS testing_system; 
DROP TABLE IF EXISTS 
Departments,
Positions,
`Accounts`,
`Groups`,
Group_Accounts,
Type_Questions,
Category_Questions,.
Questions,
Answers,
Exams,
ExamQues_tions;

CREATE TABLE Departments
(
    Department_ID	TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Department_Name	VARCHAR(100) NOT NULL
);
    
CREATE TABLE Positions
(
	Position_ID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Position_Name	ENUM("Dev","Test","Scrum Master","PM") DEFAULT "Dev"
);
    
CREATE TABLE `Accounts`
(
	Account_ID		INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Email			VARCHAR(50) UNIQUE NOT NULL,
	Username		VARCHAR(100) UNIQUE NOT NULL,
    FullName		VARCHAR(100) NOT NULL,
    Gender			BIT DEFAULT 1,
    Department_ID	TINYINT UNSIGNED,
    Position_ID		TINYINT UNSIGNED,
    CreateDate		DATE,
    FOREIGN KEY(Department_ID) REFERENCES department(Department_ID)
    );
    
CREATE TABLE `Groups`
(
	Group_ID	TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Group_Name	VARCHAR(100) NOT NULL,
	Creator_ID	INT UNSIGNED,
	Create_Date	DATE,
    FOREIGN KEY(Creator_ID) REFERENCES accounts(account_id)
    );
    
CREATE TABLE Group_Accounts
(
	Group_ID	TINYINT UNSIGNED,
	Account_ID	INT UNSIGNED,
	Join_Date	DATE,
    PRIMARY KEY(Group_ID, Account_ID),
    FOREIGN KEY(Group_ID) REFERENCES `Groups`(Group_ID),
    FOREIGN KEY(Account_ID) REFERENCES `Account`(Account_ID)
);
    
CREATE TABLE Type_Questions
(
    Type_ID		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Type_Name	ENUM("essay","multiple-choice") DEFAULT"aultiple_choice"
);
  
CREATE TABLE Category_Questions
(
	Category_ID TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Category_Name	VARCHAR(100) NOT NULL
);
 
CREATE TABLE Question
(
	Question_ID 	INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Content 		TEXT,
	Category_ID		TINYINT UNSIGNED,
	Type_ID 		INT UNSIGNED,
	Creator_ID		INT UNSIGNED,
	Create_Date		DATE,
    FOREIGN KEY(Type_ID) REFERENCES Type_Questions(Type_ID),
    FOREIGN KEY(Category_ID) REFERENCES Category_Questions(Category_ID),
    FOREIGN KEY(Creator_ID) REFERENCES `Account`(Account_ID)
);
    
 CREATE TABLE Answers
 (
	Answer_ID	INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	Content		TEXT,
	Question_ID	INT UNSIGNED,
	isCorrect 	BIT DEFAULT 1,
    FOREIGN KEY(Question_ID) REFERENCES Questons(Question_ID)
    );
    
CREATE TABLE Exams
(
    ExamID	INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	`Code`	CHAR(10) UNIQUE NOT NULL,
	Title	VARCHAR(100) NOT NULL,
	Category_ID	TINYINT UNSIGNED,
 	Duration	TINYINT UNSIGNED,
 	Creator_ID	INT UNSIGNED,
 	Create_Date	DATE,
    FOREIGN KEY(Creator_ID) REFERENCES Accoounts(Account_ID)
);

CREATE TABLE Exam_Questions
(
    Exam_ID		INT UNSIGNED,
    Question_ID	INT UNSIGNED,
    PRIMARY KEY(Exam_ID,Question_ID),
    FOREIGN KEY(Question_ID) REFERENCES Questions(Question_ID)
);
    
    

  


