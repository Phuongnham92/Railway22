-- DELIMITER $$
-- CREATE TRIGGER cau_6
-- BEFORE INSERT ON `groups`
-- FOR EACH ROW
-- BEGIN 
-- 	IF 
--     
-- END $$
-- DELIMITER ;

-- Exercise 1: Tiếp tục với Database Testing System
-- Question 1: Tạo trigger không cho phép người dùng nhập vào Group có ngày tạo trước 1 năm trước

DROP TRIGGER IF EXISTS cannot_insert_trc1namtrc;
DELIMITER $$
	CREATE TRIGGER cannot_insert_trc1namtrc
	BEFORE INSERT ON `groups`
    FOR EACH ROW	
    BEGIN	
			IF(NEW.create_date<ADDDATE(NOW(), INTERVAL-1 YEAR)) THEN
				SIGNAL SQLSTATE '12345'
                SET MESSAGE_TEXT = 'ngaynhap_kodung';
			END IF;
	END $$
    DELIMITER ;
    
    INSERT INTO `groups`(group_name,	creator_id,	create_date)
    VALUES				('testing_system1',		1,	'2021-10-26');
            
-- Question 2: Tạo trigger Không cho phép người dùng thêm bất kỳ user nào vào department "Sale" nữa, khi thêm thì hiện ra thông báo "Department
-- "Sale" cannot add more user"

DROP TRIGGER IF EXISTS cannot_insert_Sale;
DELIMITER $$
	CREATE TRIGGER cannot_insert_Sale
	BEFORE INSERT ON departments
    FOR EACH ROW	
    BEGIN	
			IF(NEW.department_name='Sale') THEN
				SIGNAL SQLSTATE '12345'
                SET MESSAGE_TEXT = "Department 'Sale' cannot add more user"
;
			END IF;
	END $$
    DELIMITER ;
    
    INSERT INTO departments (department_name)
    VALUE					(N'Sale');

-- Question 3: Cấu hình 1 group có nhiều nhất là 5 user

DROP TRIGGER IF EXISTS max_member_5;
DELIMITER $$
	CREATE TRIGGER max_member_5
	BEFORE INSERT ON group_accounts
    FOR EACH ROW	
    BEGIN	
			DECLARE	x_mount_account_id TINYINT;
            SELECT	COUNT(ga.account_id) INTO x_mount_account_id
            FROM	group_accounts ga
            WHERE	ga.group_id=NEW.group_id;
			IF	(x_mount_account_id>5) THEN
				SIGNAL SQLSTATE '12345'
                SET MESSAGE_TEXT = "Department 'Sale' cannot add more user";
			END IF;
	END $$
    DELIMITER ;
    
    INSERT INTO group_accounts (group_id,account_id,join_date)
    VALUE						(1,		1,		2021-10-27);
    
-- Question 4: Cấu hình 1 bài thi có nhiều nhất là 10 Question
DROP TRIGGER IF EXISTS max_of_question_10;
DELIMITER $$
	CREATE TRIGGER max_of_question_10
	BEFORE INSERT ON exam_questions
    FOR EACH ROW	
    BEGIN	
		IF	(SELECT		question_id
			FROM		exam_questions
            GROUP BY	question_id
            HAVING COUNT(question_id)>10) THEN
			SIGNAL SQLSTATE '12345'
			SET MESSAGE_TEXT = "loi_nhieu_nhat_10_question";
		END IF;
	END $$
    DELIMITER ;
    
INSERT INTO	exam_questions(exam_id,question_id)
VALUES						(11,	11);
-- Question 5: Tạo trigger không cho phép người dùng xóa tài khoản có email là admin@gmail.com (đây là tài khoản admin, không cho phép user xóa),
-- còn lại các tài khoản khác thì sẽ cho phép xóa và sẽ xóa tất cả các thông tin liên quan tới user đó

DROP TRIGGER IF EXISTS xoa_tai_khoan;
DELIMITER $$
	CREATE TRIGGER xoa_tai_khoan
	BEFORE INSERT ON `accounts`
    FOR EACH ROW	
    BEGIN	
		IF	OLD.email = 'admin@gmail.com'	THEN
        SIGNAL SQLSTATE '12345'
			SET MESSAGE_TEXT = "đây là tài khoản admin, không cho phép user xóa";
		END IF;
	END $$
    DELIMITER ;

-- Question 6: Không sử dụng cấu hình default cho field DepartmentID của table
-- Account, hãy tạo trigger cho phép người dùng khi tạo account không điền
-- vào departmentID thì sẽ được phân vào phòng ban "waiting Department"

DROP TRIGGER IF EXISTS insert_into_waiting_department;
DELIMITER $$
	CREATE TRIGGER insert_into_waiting_department
	BEFORE DELETE ON `accounts`
    FOR EACH ROW	
    BEGIN	
			DECLARE	waiting_department_id		TINYINT UNSIGNED;
			SELECT	department_id	INTO	waiting_department_id
			FROM	departments
			WHERE	department_name	=	'PHONG_CHO';
        IF	NEW.department_id IS NULL	THEN
			SET		NEW.department_id = waiting_department_id;
		
        END IF;
	END $$
    DELIMITER ;
        
-- Question 7: Cấu hình 1 bài thi chỉ cho phép user tạo tối đa 4 answers cho mỗi
-- question, trong đó có tối đa 2 đáp án đúng.

DROP TRIGGER IF EXISTS max_4_answer;
DELIMITER $$
	CREATE TRIGGER max_4_answer
	BEFORE DELETE ON answers
    FOR EACH ROW	
    BEGIN
		DECLARE	sl_answer	TINYINT	UNSIGNED;
        DECLARE	sl_correct_answer	TINYINT	UNSIGNED;
        
			SELECT	COUNT(a.answer_id)	INTO	sl_answer
			FROM	answers a 
			WHERE	a.question_id = NEW.question_id;
			
			SELECT	COUNT (1)	INTO	sl_correct_answer
			FROM	answers a 
			WHERE	a.question_id = NEW.question_id		AND		a.iscorrect = NEW.iscorrect;
        IF		(sl_answer>4)	OR	(sl_correct_answer>2)	THEN
			SIGNAL SQLSTATE '12345'
			SET MESSAGE_TEXT = "loi nhap qua so luong";
		END IF;
	END $$
    DELIMITER ;
        
-- Question 8: Viết trigger sửa lại dữ liệu cho đúng:
-- Nếu người dùng nhập vào gender của account là nam, nữ, chưa xác định
-- Thì sẽ đổi lại thành M, F, U cho giống với cấu hình ở database

DROP TRIGGER IF EXISTS insert_gender;
DELIMITER $$
	CREATE TRIGGER insert_gender
	BEFORE INSERT ON `accounts`
    FOR EACH ROW	
    BEGIN
		IF	NEW.gender = 'Nam' THEN
			SET NEW.gender = 'M';
				ELSEIF	NEW.gender = 'Nu' THEN
			SET NEW.gender = 'F';
				ELSEIF	NEW.gender = 'chưa xác định' THEN
			SET NEW.gender = 'U';
		END IF;
	END $$
    DELIMITER ;

-- Question 9: Viết trigger không cho phép người dùng xóa bài thi mới tạo được 2 ngày

DROP TRIGGER IF EXISTS khong_the_xoa_exam;
DELIMITER $$
	CREATE TRIGGER khong_the_xoa_exam
	BEFORE DELETE ON exams
    FOR EACH ROW	
    BEGIN
		IF (DATE(NOW()) - DATE(OLD.create_date)) < 2 THEN
			SIGNAL SQLSTATE '12345'
			SET MESSAGE_TEXT = "CANNOT_DELETE";
		END IF;
	END $$
    DELIMITER ;

-- Question 10: Viết trigger chỉ cho phép người dùng chỉ được update, delete các
-- question khi question đó chưa nằm trong exam nào

DROP TRIGGER IF EXISTS CHI_DUOC_XOA_NULL;
DELIMITER $$
	CREATE TRIGGER CHI_DUOC_XOA_NULL
	BEFORE DELETE ON questions
    FOR EACH ROW	
    BEGIN
		IF	(SELECT	exam_id FROM `Exam question`
			WHERE	question_id = OLD.question_id) IS NOT NULL THEN
         SIGNAL SQLSTATE '12345'
		 SET MESSAGE_TEXT = "CANNOT_DELETE_QUESTION";
		END IF;
	END $$
    DELIMITER ;   

-- Question 12: Lấy ra thông tin exam trong đó:
-- Duration <= 30 thì sẽ đổi thành giá trị "Short time"
-- 30 < Duration <= 60 thì sẽ đổi thành giá trị "Medium time"
-- Duration > 60 thì sẽ đổi thành giá trị "Long time"

SELECT	*,
		CASE	
			WHEN	e.duration <= 30 THEN "Short time"
            WHEN	30 < e.duration <= 60 THEN "Medium time"
			ELSE 	"Long time"
		END AS duration
FROM exams e;


-- Question 13: Thống kê số account trong mỗi group và in ra thêm 1 column nữa có tên
-- là the_number_user_amount và mang giá trị được quy định như sau:

-- Nếu số lượng user trong group =< 5 thì sẽ có giá trị là few
-- Nếu số lượng user trong group <= 20 và > 5 thì sẽ có giá trị là normal
-- Nếu số lượng user trong group > 20 thì sẽ có giá trị là higher

SELECT group_id, COUNT(account_id), 
		CASE
			WHEN	COUNT(account_id) <= 5 THEN 'few'
            WHEN	COUNT(account_id) <= 20 THEN 'normal'
            ELSE	'higher'
		END AS	the_number_user_amount
FROM	group_accounts;
            
-- Question 14: Thống kê số mỗi phòng ban có bao nhiêu user, nếu phòng ban nào
-- không có user thì sẽ thay đổi giá trị 0 thành "Không có User"

SELECT	d.department_name, COUNT(a.account_id),
	CASE	
		WHEN	COUNT(a.account_id) != 0 THEN COUNT(a.account_id)
        ELSE	"Không có User"
	END AS	sl_acc
FROM		departments d
LEFT JOIN	`accounts` a
ON			d.department_id = a.department_id
GROUP BY	d.department_id;
