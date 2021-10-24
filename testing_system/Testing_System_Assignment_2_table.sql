-- question 3-- chuan bi data cho bai 3. insert data vao 11 table, moi table it nhat 10 records.

-- Add data Department
INSERT INTO departments(department_name)
VALUES
						(N'Marketing'	),
						(N'Sale'		),
						(N'Bảo vệ'		),
						(N'Nhân sự'		),
						(N'Kỹ thuật'	),
						(N'Tài chính'	),
						(N'Phó giám đốc'),
						(N'Giám đốc'	),
						(N'Thư kí'		),
						(N'Bán hàng'	);

-- Add data position
INSERT INTO positions(position_name) 
VALUES 					('Dev'			),
						('Test'			),
						('Scrum Master'	),
						('PM'			); 

INSERT INTO `accounts`(email							, user_name			,gender , full_name				, department_id	, position_id, create_date)
VALUES 				('haidang29productions@gmail.com'	, 'dangblack'		,'F','Nguyễn hải Đăng'		,   '5'			,   '1'		,'2020-03-05'),
					('account1@gmail.com'				, 'quanganh'		,'M','Nguyen Chien Thang2'	,   '1'			,   '2'		,'2020-03-05'),
                    ('account2@gmail.com'				, 'vanchien'		,'M','Nguyen Van Chien'		,   '2'			,   '3'		,'2020-03-07'),
                    ('account3@gmail.com'				, 'cocoduongqua'	,'F','Duong Do'				,   '3'			,   '4'		,'2020-03-08'),
                    ('account4@gmail.com'				, 'doccocaubai'		,'F','Nguyen Chien Thang1'	,   '4'			,   '4'		,'2020-03-10'),
                    ('dapphatchetngay@gmail.com'		, 'khabanh'			,'F','Ngo Ba Kha'			,   '6'			,   '3'		,'2020-04-05'),
                    ('songcodaoly@gmail.com'			, 'huanhoahong'		,'F','Bui Xuan Huan'		,   '7'			,   '2'		, NULL		),
                    ('sontungmtp@gmail.com'				, 'tungnui'			,'M','Nguyen Thanh Tung'	,   '8'			,   '1'		,'2020-04-07'),
                    ('duongghuu@gmail.com'				, 'duongghuu'		,'M','Duong Van Huu'		,   '9'			,   '2'		,'2020-04-07'),
                    ('vtiaccademy@gmail.com'			, 'vtiaccademy'		,'U','Vi Ti Ai'				,   '10'		,   '1'		,'2020-04-09');

	-- Ad data `group`
INSERT INTO `groups` (group_name,	creator_id,		create_date)
VALUES 				('A'			,	1			,	'2021-10-10'),
					('B'			,	2			,	'2021-09-08'),
                    ('C'			,	4			,	'2021-02-02'),
                    ('D'			,	3			,	'2021-09-03'),
                    ('E'			,	7			,	'2021-07-02'),
                    ('G'			,	8			,	'2021-09-02'),
                    ('H'			,	5			,	'2021-08-06'),
                    ('I'			,	10			,	'2021-02-04'),
                    ('K'			,	9			,	'2021-08-02'),
                    ('L'			,	6			,	'2021-10-10');
                    
	-- Add data group_account
INSERT INTO group_accounts (group_id,	account_id,	join_date)
VALUES						(1	,			2		,'2021-02-20'),
							(10	,			3		,'2021-09-02'),
                            (9	,			4		,'2021-10-10'),
                            (9	,			1		,'2021-10-10'),
                            (1	,			10		,'2021-09-02'),
                            (2	,			5		,'2021-05-02'),
                            (2	,			6		,'2021-10-16'),
                            (2	,			7		,'2021-12-12'),
                            (8	,			9		,'2021-09-02'),
                            (8	,			8		,'2021-02-02');
                            
	-- Add data type_question
INSERT INTO `type_questions` (type_name)
VALUES						('essay'),
                            ('multiple_choice');
                            
	 -- Add data category_question
INSERT INTO category_questions (category_name)
VALUES							('Java'),
								('ASP.NET'),
                                ('SQL'),
                                ('Postman'),
                                ('ruby'),
                                ('python'),
                                ('C++'),
                                ('C Sharp'),
                                ('PHP'),
                                ('ADO.NET');
                                
	 -- Add data `question`
INSERT INTO `questions`	(content,	category_id,	type_id,	creator_id,		create_date)
VALUES					('java Q',		1		,	1,			1		,'2021-02-20'		),
						('ASP.NET Q',	4		,	1,			2		,'2021-09-02'		),
						('SQL Q',		10		,	2,			3		,'2021-10-10'		),
                        ('Postman Q',	8		,	1,			4		,'2021-10-10'		),
						('ruby Q',		5		,	2,			5		,'2021-09-02'		),
						('python Q',	9		,	2,			6		,'2021-02-20'		),
						('C++ Q',		2		,	1,			7		,'2021-09-02'		),
						('C Sharp Q',	3		,	1,			8		,'2021-10-10'		),
						('PHP Q',		7		,	2,			9		,'2021-10-10'		),
						('ADO.NET Q',	6		,	1,			10		,'2021-09-02'		);
                    
	-- Add data `answer`
INSERT INTO `answers` (content,		question_id,	iscorrect)
VALUES					('java A',		10		,		0),
                        ('ASP.NET A',	8		,		1),		
                        ('SQL A',		1		,		0),
                        ('Postman A',	4		,		1),
                        ('ruby A',		5		,		1),
                        ('python A',	9		,		0),
                        ('C++ A',		2		,		0),
                        ('C Sharp A',	3		,		1),
                        ('PHP A',		7		,		1),
                        ('ADO.NET A',	6		,		1);
                        
	-- Add data `Exam`
INSERT INTO `exams` (`code`,			title,			category_id,	duration,	creator_id,	create_date)
VALUES				('SQL01',		N'de thi java'	,		2,				120,		1,		'2021-10-11'),		
					('SQL02',      N'de thi ASP.NET',		1, 				90  ,   	2,	    '2021-10-11'),
                    ('SQL03',      N'de thi SQL'	,		3,				120	,		3,		'2021-10-11'),		
                    ('SQL04',      N'de thi Postman',		5, 				60  ,   	4,	    '2021-10-11'),
                    ('SQL05',      N'de thi ruby'	,		6,				120	,		5,		'2021-10-11'),		
                    ('SQL06',      N'de thi python'	,		10,				90	,		6,		'2021-10-11'),		
                    ('SQL07',      N'de thi C++'	,		9,				90	,		7,		'2021-10-11'),		
                    ('SQL08',      N'de thi C Sharp',		9, 				100 ,   	8,	    '2021-10-11'),
                    ('SQL09',      N'de thi PHP'	,		8,				120	,		9,		'2021-10-11'),		
                    ('SQL10',      N'de thi ADO.NET',		8, 				120	,   	10,	    '2021-10-11');
                    
	-- Add data `Exam question`
INSERT INTO `exam_questions` (exam_id,	question_id)
VALUES							(1		,1		),
								(2		,2		),
                                (3		,3		),
                                (4		,4		),
                                (5		,5		),
                                (6		,6		),
                                (7		,7		),
                                (8		,8		),
                                (9		,9		),
                                (10		,10		);
                                
                                