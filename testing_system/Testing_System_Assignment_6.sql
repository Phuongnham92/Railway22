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
CREATE PROCEDURE id_of_max_typequestion()
BEGIN
	SELECT tq.type_id, tq.type_name,COUNT(q.question_id)
    FROM		type_questions tq
    INNER JOIN	questions q 
    ON			tq.type_id=q.type_id
    GROUP BY	tq.type_id
    ORDER BY	COUNT(q.question_id) DESC 
    LIMIT 1;
END$$
DELIMITER ;
CALL id_of_max_typequestion();

-- Question 5: Sử dụng store ở question 4 để tìm ra tên của type question
-- 				da goi ra o question 4
-- Question 6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên
-- chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa
-- chuỗi của người dùng nhập vào

-- Question 7: Viết 1 store cho phép người dùng nhập vào thông tin fullName, email và
-- trong store sẽ tự động gán:

-- username sẽ giống email nhưng bỏ phần @..mail đi
-- positionID: sẽ có default là developer
-- departmentID: sẽ được cho vào 1 phòng chờ

-- Sau đó in ra kết quả tạo thành công

-- Question 8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice
-- để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất
-- Question 9: Viết 1 store cho phép người dùng xóa exam dựa vào ID
-- Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử
-- dụng store ở câu 9 để xóa)
-- Sau đó in số lượng record đã remove từ các table liên quan trong khi
-- removing
-- Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng
-- nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được
-- chuyển về phòng ban default là phòng ban chờ việc
-- Question 12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm
-- nay

-- 2

-- Question 13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6
-- tháng gần đây nhất
-- (Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong
-- tháng")