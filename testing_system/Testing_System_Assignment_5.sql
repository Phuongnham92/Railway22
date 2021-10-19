    -- Exercise 1: Tiếp tục với Database Testing System
-- (Sử dụng subquery hoặc CTE)
-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban sale

CREATE OR REPLACE VIEW sale_acc AS
	SELECT *
    FROM 	accounts
    WHERE	department_id = (SELECT		department_id
								FROM	departments
								WHERE 	department_name = 'Marketing');
	SELECT * 
    FROM sale_acc;

-- Question 2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
CREATE OR REPLACE VIEW thamgia_gr AS
	SELECT		a.*, COUNT(g.group_id) sl
	FROM		`accounts` a 
	RIGHT JOIN	group_accounts g
		ON		a.account_id=g.account_id
	GROUP BY	g.account_id
	HAVING COUNT(g.account_id) = (SELECT COUNT(g.group_id) soluong
								FROM  		`accounts` a 
                                LEFT JOIN 	group_accounts g
                                ON			a.account_id=g.account_id
                                GROUP BY	g.account_id
                                ORDER BY COUNT(g.group_id) DESC
                                LIMIT 1);
SELECT * FROM thamgia_gr;

-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ được coi là quá dài) và xóa nó đi

CREATE OR REPLACE VIEW content_dai AS
	SELECT	*
	FROM	questions
	WHERE	length(content) > 8;
SELECT * FROM questions;
DROP VIEW content_dai;

-- Question 4: Tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất
CREATE or REPLACE VIEW ds_nv AS
	SELECT		d.department_name, COUNT(a.department_id) as So_Luong
	FROM		departments d
	INNER JOIN	`accounts` a 
	ON 			d.department_id=a.department_id
	GROUP BY	a.department_id
	HAVING COUNT(a.department_id)=(SELECT COUNT(a.department_id) AS Sl
								FROM		departments d
								INNER JOIN	`accounts`  a
								ON 			d.department_id=a.department_id
                                GROUP BY	a.department_id
                                ORDER BY 	Sl DESC LIMIT 1);
SELECT	*	FROM ds_nv;
      
-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo

CREATE OR REPLACE VIEW		ho_nguyen AS
	SELECT			a.full_name, q.*	
	FROM			questions q
	INNER JOIN		`accounts` a
	ON				q.creator_id=a.account_id
	WHERE			a.full_name LIKE ("Nguyen%");

SELECT * FROM	ho_nguyen;
