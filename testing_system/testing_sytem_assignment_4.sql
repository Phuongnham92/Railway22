--  Tiếp tục với Database Testing System
-- Exercise 1: Join
-- Question 1: Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ

SELECT		a.user_name, a.full_name, d.department_name
FROM 		`accounts` a 
LEFT JOIN	departments d
ON			a.department_id = d.department_id;

-- Question 2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2021

SELECT	account_id 
FROM	`accounts`
WHERE	create_date < "2021-12-20";

-- Question 3: Viết lệnh để lấy ra tất cả các developer

SELECT				a.email, a.user_name, a.full_name, p.position_name
FROM				`accounts` a
INNER JOIN			positions p
ON					a.position_id=p.position_id
WHERE				position_name = "Dev";

-- Question 4: Viết lệnh để lấy ra danh sách các phòng ban có <3 nhân viên

SELECT		d.department_id, d.department_name, count(a.department_id) AS sl
FROM		`accounts` a 
INNER JOIN	departments d
ON			a.department_id=d.department_id
GROUP BY	a.department_id
HAVING COUNT(a.department_id)<3;  


-- Question 5: Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất

SELECT		*
FROM		questions q
INNER JOIN	exam_questions eq
ON			q.question_id=eq.question_id
GROUP BY	eq.question_id
HAVING COUNT(eq.question_id)=(SELECT COUNT(question_id)
										FROM exam_questions
                                        GROUP BY question_id
                                        ORDER BY COUNT(question_id) DESC
                                        LIMIT 1);



-- Question 6: Thông kê mỗi category Question được sử dụng trong bao nhiêu Question

SELECT		cq.*, COUNT(category_id) AS sl
FROM		category_questions cq
LEFT JOIN	questions q
ON			q.category_id=cq.category_id
GROUP BY	q.category_id;

-- Question 7: Thông kê mỗi Question được sử dụng trong bao nhiêu Exam

SELECT		q.question_id, q.content, COUNT(eq.question_id) AS so_lan
FROM		questions q
LEFT JOIN	exam_questions eq
ON			eq.question_id=q.question_id
GROUP BY	q.question_id;



-- Question 8: Lấy ra Question có nhiều câu trả lời nhất

SELECT		a.question_id, q.content
FROM		answers a
INNER JOIN	questions q
ON			q.question_id=a.question_id
GROUP BY	a.question_id
HAVING COUNT(a.question_id)=(SELECT COUNT(question_id)
							FROM		answers
                            GROUP BY	question_id
                            ORDER BY	COUNT(question_id) DESC
                            LIMIT		1);

-- Question 9: Thống kê số lượng account trong mỗi group

SELECT		g.group_id, g.group_name, COUNT(ga.account_id) AS sl_ac
FROM		group_accounts ga
RIGHT JOIN	`groups` g 
ON			g.group_id=ga.group_id
GROUP BY	g.group_id
ORDER BY	COUNT(ga.account_id);

-- Question 10: Tìm chức vụ có ít người nhất

SELECT		p.position_id, p.position_name, COUNT(a.position_id) AS so_nguoi
FROM		`accounts` a
INNER JOIN	positions p
ON			a.position_id=p.position_id
GROUP BY	a.position_id
HAVING COUNT(a.position_id) = MIN(a.position_id);

-- Question 11: Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM

SELECT		d.department_id, d.department_name, p.position_name, COUNT(p.position_id)
FROM		departments d
INNER JOIN	`accounts` a 
ON			d.department_id=a.department_id
INNER JOIN	positions p 
ON			p.position_id=a.position_id
GROUP BY	d.department_id, p.position_id;

-- Question 12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, ...

SELECT		q.question_id, tq.type_name, cq.category_name, q.content, q.type_id, q.creator_id, a.full_name, an.answer_id, an.content
FROM		answers an 
INNER JOIN	questions q			ON q.question_id=an.question_id
INNER JOIN	`accounts` a		ON a.account_id=q.creator_id
INNER JOIN	type_questions tq	ON tq.type_id=q.type_id
INNER JOIN	category_questions cq ON cq.category_id=q.category_id;


-- Question 13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm (de hay kho)

SELECT		tq.type_id, tq.type_name, COUNT(q.type_id) AS soluong
FROM		questions q
INNER JOIN	type_questions tq
ON			tq.type_id=q.type_id
GROUP BY	q.type_id;

-- Question 14:Lấy ra group không có account nào

SELECT	* FROM	`groups` g 
LEFT JOIN		group_accounts ga
ON				g.group_id=ga.group_id
WHERE			ga.group_id IS NULL;

-- Question 15: Lấy ra group không có account nào

-- Question 16: Lấy ra question không có answer nào

SELECT		* FROM questions q
LEFT JOIN	answers a 
ON			q.question_id=a.question_id
WHERE		a.question_id IS NULL;


-- Exercise 2: Union
-- Question 17:
-- a) Lấy các account thuộc nhóm thứ 1
SELECT *	FROM `accounts` a
INNER JOIN		group_accounts ga
ON				a.account_id=ga.account_id
WHERE			ga.group_id=1;

-- b) Lấy các account thuộc nhóm thứ 2
SELECT *	FROM `accounts` a
INNER JOIN		group_accounts ga
ON				a.account_id=ga.account_id
WHERE			ga.group_id=2;

-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau

SELECT *	FROM `accounts` a
INNER JOIN		group_accounts ga
ON				a.account_id=ga.account_id
WHERE			ga.group_id=1
UNION
SELECT *	FROM `accounts` a
INNER JOIN		group_accounts ga
ON				a.account_id=ga.account_id
WHERE			ga.group_id=2;


-- Question 18:
-- a) Lấy các group có lớn hơn 2 thành viên
SELECT		* FROM group_accounts ga
INNER JOIN	`accounts` a 
ON			a.account_id=ga.account_id
GROUP BY	ga.account_id
HAVING COUNT(ga.account_id)>=3;
                            
-- b) Lấy các group có nhỏ hơn 7 thành viên
SELECT		* FROM group_accounts ga
INNER JOIN	`accounts` a 
ON			a.account_id=ga.account_id
GROUP BY	ga.account_id
HAVING COUNT(ga.account_id)<=7;

-- c) Ghép 2 kết quả từ câu a) và câu b)
SELECT		* FROM group_accounts ga
INNER JOIN	`accounts` a 
ON			a.account_id=ga.account_id
GROUP BY	ga.account_id
HAVING COUNT(ga.account_id)>=3
UNION ALL
SELECT		* FROM group_accounts ga
INNER JOIN	`accounts` a 
ON			a.account_id=ga.account_id
GROUP BY	ga.account_id
HAVING COUNT(ga.account_id)<=7;

