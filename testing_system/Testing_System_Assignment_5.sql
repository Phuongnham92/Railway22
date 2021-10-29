    -- Exercise 1: Tiếp tục với Database Testing System
-- (Sử dụng subquery hoặc CTE)
-- Question 1: Tạo view có chứa danh sách nhân viên thuộc phòng ban 'Marketing'

-- CREATE OR REPLACE VIEW Marketing_acc AS
-- 	SELECT *
--     FROM 	accounts
--     WHERE	department_id = (SELECT		department_id
-- 								FROM	departments
-- 								WHERE 	department_name = 'Marketing');
-- 	SELECT * 
--     FROM Marketing_acc;

CREATE OR REPLACE VIEW Marketing_acc AS
	SELECT		a.account_id,a.user_name,a.full_name,d.department_name
	FROM		`accounts` a
	INNER JOIN	departments d
	WHERE		a.department_id = d.department_id AND department_name = 'Marketing';

SELECT * FROM Marketing_acc;
    
-- cach su dung CTE
 WITH	Marketing_acc AS
	(SELECT *
    FROM 	accounts
    WHERE	department_id = (SELECT		department_id
								FROM	departments
								WHERE 	department_name = 'Marketing')
                                )
	SELECT	* FROM sale_acc;
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

-- SELECT MAX(SL_ACC)
-- 			FROM	
-- 			A	SELECT...AS SL_ACC


-- Question 3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ được coi là quá dài) và xóa nó đi

CREATE OR REPLACE VIEW content_dai AS
	SELECT	q.*, LENGTH(content) AS do_dai_content
	FROM	questions q
	WHERE	LENGTH(content) > 8;
    
SELECT * FROM content_dai;
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

-- CTE Tạo CTE có chứa danh sách các phòng ban có nhiều nhân viên nhất
WITH	ds_phong_ban AS
	(SELECT		d.department_name, COUNT(a.account_id) as So_Luong_NV
	FROM		departments d
	INNER JOIN	`accounts` a 
	ON 			d.department_id=a.department_id
	GROUP BY	a.department_id)
    
SELECT	*	
FROM	ds_phong_ban
WHERE	So_Luong_NV = (SELECT MAX(So_Luong_NV)
						FROM	ds_phong_ban);





 
 -- CACH 2. 
CREATE or REPLACE VIEW ds_nv AS
	SELECT		d.department_name, COUNT(a.department_id) as So_Luong
	FROM		departments d
	INNER JOIN	`accounts` a 
	ON 			d.department_id=a.department_id
	GROUP BY	a.department_id
	HAVING COUNT(a.department_id)= (SELECT MAX(X)
									FROM	
										(SELECT		d.department_name, COUNT(a.department_id) as X
										FROM		departments d
										INNER JOIN	`accounts` a 
										ON 			d.department_id=a.department_id
										GROUP BY	a.department_id));
-- Question 5: Tạo view có chứa tất các các câu hỏi do user họ Nguyễn tạo

CREATE OR REPLACE VIEW		ho_nguyen AS
	SELECT			a.full_name, q.*	
	FROM			questions q
	INNER JOIN		`accounts` a
	ON				q.creator_id=a.account_id
	WHERE			a.full_name LIKE "Nguyen%";

SELECT * FROM	ho_nguyen;


