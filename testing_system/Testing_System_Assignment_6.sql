-- Exercise 1: Tiếp tục với Database Testing System
-- Question 1: Tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các
-- account thuộc phòng ban đó
DROP PROCEDURE IF EXISTS thongtinphongban;
DELIMITER $$
CREATE PROCEDURE thongtinphongban(IN in_tenphongban VARCHAR(100))
BEGIN
	SELECT 		d.department_name, a.account_id, a.full_name
    FROM		`accounts` a 
    INNER JOIN	departments d
    ON			d.department_id=a.department_id
    WHERE		d.department_name=in_tenphongban;
END$$
DELIMITER ;
CALL thongtinphongban('Giám đốc');

-- Question 2: Tạo store để in ra số lượng account trong mỗi group
DROP PROCEDURE IF EXISTS sl_account;
DELIMITER $$
CREATE PROCEDURE	sl_account(IN in_tengroup VARCHAR(100))
BEGIN
		SELECT		g.group_name, COUNT(ga.account_id) AS sl_acc
        FROM		`groups` g
        INNER JOIN	group_accounts ga
        ON			g.group_id=ga.group_id
		WHERE		g.group_name=in_tengroup;
END$$
DELIMITER ;
CALL	sl_account('A');

-- Question 3: Tạo store để thống kê mỗi type question có bao nhiêu question được tạo
-- trong tháng hiện tại
DROP PROCEDURE IF EXISTS sl_cauhoi;
DELIMITER $$
CREATE PROCEDURE	sl_cauhoi()
BEGIN			
	SELECT		tq.type_id, tq.type_name, COUNT(q.question_id) as sl
    FROM		type_questions tq
    INNER JOIN	questions q 
    ON			tq.type_id=q.type_id
    WHERE		month(create_date)=month(now())
    GROUP BY	tq.type_id;
END$$
DELIMITER ;
CALL	sl_cauhoi();
    
-- Question 4: Tạo store để trả ra id của type question có nhiều câu hỏi nhất
DROP PROCEDURE IF EXISTS	id_of_max_typequestion;
DELIMITER $$
CREATE PROCEDURE id_of_max_typequestion(OUT out_type_question TINYINT UNSIGNED)
BEGIN
		WITH 		max_type_id	AS
			(SELECT	type_id,	COUNT(type_id) 
            FROM		questions
            GROUP BY	type_id
            ORDER BY	COUNT(type_id) DESC
            LIMIT		1)
	SELECT	*	FROM	max_type_id	INTO	out_type_question;
												
END$$
DELIMITER ;
SET		@type_id=1;
CALL 	id_of_max_typequestion(@type_id=1);
SELECT	@type_id;

-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question da goi ra o question 4
SELECT	type_name

FROM	type_questions
WHERE	type_id=@type_id;

-- Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên
-- chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa
-- chuỗi của người dùng nhập vào
DROP PROCEDURE IF EXISTS	find_group_from_string;
DELIMITER $$
CREATE PROCEDURE	find_group_from_string(IN in_chuoi_nhap_vao VARCHAR(100))
BEGIN				
	SELECT	group_name,group_id
    FROM	`groups`
    WHERE	group_name
		LIKE CONCAT('%',in_chuoi_nhap_vao,'%') 
	UNION
    SELECT	account_id,user_name
    FROM	`accounts`
	WHERE	user_name
		LIKE CONCAT('%',in_chuoi_nhap_vao,'%');
END$$
DELIMITER ;
CALL find_group_from_string('');
    
-- Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và trong store sẽ tự động gán:
-- username sẽ giống email nhưng bỏ phần @..mail đi
-- positionID: sẽ có default là developer
-- departmentID: sẽ được cho vào 1 phòng chờ
-- Sau đó in ra kết quả tạo thành công

DROP PROCEDURE IF EXISTS	tim_thong_tin_acc;
DELIMITER $$
CREATE PROCEDURE tim_thong_tin_acc(IN in_fullName VARCHAR(100), IN in_email VARCHAR(100))
BEGIN
DECLARE username VARCHAR(100) DEFAULT substring_index2(in_email,'@',1);
DECLARE positionID TINYINT UNSIGNED DEFAULT("Dev");
DECLARE departmentID TINYINT UNSIGNED DEFAULT('phongcho');
WHERE

END$$
DELIMITER ;
CALL tim_thong_tin_acc();

-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
-- để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất

DROP PROCEDURE IF EXISTS max_type_question;
DELIMITER $$
CREATE PROCEDURE max_type_question(IN in_type_name ENUM('essay','multiple_choice'))
BEGIN
	IF in_type_name='essay'
		THEN 
			SELECT content, MAX(length(content)) 
            FROM	questions
            WHERE	type_id=1;
	ELSEIF in_type_name='multiple_choice'
		THEN
			SELECT content, MAX(length(content)) 
            FROM	questions
            WHERE	type_id=2;
	END IF;
    END$$
DELIMITER ;
CALL max_type_question('essay');


--CACH 2
BEGIN
	DECLARE INPUT_ID INT;
    DECLARE MAXLENGT INT;
    
    SELECT	type_id INTO	INPUT_ID
    FROM	type_question
    WHERE	type_name = in_type_name;
    
    SELECT MAX(LENGTH(content)) INTO	MAXLENGT
    FROM	questions
    WHERE	type_id = INPUT_ID;
    
    SELECT	* , LENGTH(content)
    FROM questions
    WHERE type_id= INPUT_ID AND LENGTH(content)= MAXLENGT;
    
END$$
DELIMITER ;

-- Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID

DROP PROCEDURE IF EXISTS xoa_exam;
DELIMITER $$
	CREATE PROCEDURE xoa_exam(IN in_exam_id	INT UNSIGNED)
	BEGIN

	DELETE FROM exam_questions
	WHERE		exam_id=in_exam_id;

	DELETE FROM exams
	WHERE		exam_id=in_exam_id;

	END$$
DELIMITER ;

CALL in_exam_id(1);

-- Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử dụng store ở câu 9 để xóa)
-- Sau đó in số lượng record đã remove từ các table liên quan trong khi removing

DROP PROCEDURE IF EXISTS xoa_exam_3nam_truoc;
DELIMITER $$
CREATE PROCEDURE xoa_exam_3nam_truoc()
BEGIN
	WITH	xoa_exam_3nam_truoc AS
		(
		SELECT	exam_id
		FROM	exams
		WHERE	year(create_date) < year(now())-3 			-- WHERE  create_date < ADDDATE(NOW(), INTERVAL -3 YEAR)
        )
DELETE FROM exams
WHERE		exam_id=(SELECT*FROM xoa_exam_3nam_truoc);
END$$
DELIMITER ;

-- Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được
-- chuyển về phòng ban default là phòng ban chờ việc

DROP PROCEDURE IF EXISTS xoa_phong_ban;
DELIMITER $$
CREATE PROCEDURE xoa_phong_ban(IN in_department_name VARCHAR(100))
BEGIN
DELETE FROM departments
WHERE		department_name=in_department_name;
END$$
DELIMITER ;

-- Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm
-- nay



-- Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6 tháng gần đây nhất
-- (Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong tháng")




-- FUNTION	NHAP VAO DEPARTMENT_ID SAU DO SU DUNG FUNCTON DE IN RA DEPARTMENT_NAME
SET GLOBAL log_bin_trust_function_creators = 1;
DROP FUNCTION IF EXISTS	get_DEPARTMENT_NAME;
DELIMITER $$
CREATE FUNCTION get_DEPARTMENT_NAME (var1 TINYINT) RETURNS VARCHAR(100)
		BEGIN	
			DECLARE	var_DEPARTMENT_NAME VARCHAR(100);
            SET		var_DEPARTMENT_NAME='';
            SELECT	d.department_name INTO var_DEPARTMENT_NAME
            FROM	departments d
            WHERE	d.department_id=var1;
		RETURN	var_DEPARTMENT_NAME;
        END$$
DELIMITER ;
SELECT	get_DEPARTMENT_NAME(2);
 