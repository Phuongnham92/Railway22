-- Question 1: Thêm ít nhất 10 record vào mỗi table

-- Question 2: lấy ra tất cả các phòng ban

SELECT * FROM departments;

-- Question 3: lấy ra id của phòng ban "Sale"

SELECT	department_id 
FROM	departments 
WHERE	department_name = 'Sale';

-- Question 4: lấy ra thông tin account có full name dài nhất

SELECT * 
FROM		accounts
ORDER BY 	full_name DESC;

SELECT *, 	length(full_name)
FROM		accounts
GROUP BY	length(full_name)
ORDER BY 	length(full_name) DESC
LIMIT 1;

SELECT *
FROM `accounts`
WHERE length(full_name)= (SELECT MAX(length(full_name)) FROM `accounts`);


-- Question 5: Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3

SELECT *
FROM `accounts`
WHERE length(full_name)= (SELECT MAX(length(full_name)) FROM `accounts` Where department_id=3) AND department_id=3;

-- Question 6: Lấy ra tên group đã tham gia trước ngày 20/12/2019

SELECT		A.group_name
FROM		`groups` A
INNER JOIN	group_accounts B
ON			A.group_id = B.group_id
WHERE		join_date <= '2021-10-5';

-- Question 7: Lấy ra ID của question có >= 4 câu trả lời

SELECT		Q.question_id 
FROM		questions Q
INNER JOIN	answers A
ON			Q.question_id = A.question_id
GROUP BY	Q.question_id
HAVING COUNT(A.question_id) >= 2;

-- Question 8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019

SELECT	`code`
FROM	exams
WHERE	duration >= 60
AND		create_date < '2021-10-11';

-- Question 9: Lấy ra 5 group được tạo gần đây nhất

SELECT * 
FROM	 `groups`
ORDER BY create_date DESC
LIMIT 	5;

-- Question 10: Đếm số nhân viên thuộc department có id = 2

SELECT COUNT(account_id)
FROM		accounts 
WHERE		department_id=2;


-- Question 11: Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"

SELECT	full_name
FROM	accounts 
WHERE	full_name LIKE "D%o";

-- Question 12: Xóa tất cả các exam được tạo trước ngày '2020-10-9'

SELECT	exam_id 
FROM	exams 
WHERE	create_date='2020-10-9';

SELECT	question_id 
FROM exam_questions
WHERE exam_id=10;

DELETE FROM exam_questions WHERE exam_id =10;-- xoá con
DELETE FROM exams -- bảng cha
WHERE exam_id =10;
-- 1: muốn xoá được thì ở where cần phải để là trường primary key
-- 2: xoá hết tất cả các thông tin foreign key tới bảng cần xoá


-- Question 13: Xóa tất cả các question có nội dung bắt đầu bằng từ "java"

SELECT *
 FROM questions 
WHERE content 
LIKE "%java%";

-- Question 14: Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn

UPDATE accounts 
SET full_name = 'Nguyễn Bá Lộc', 
email = 'loc.nguyenba@vti.com.vn'
WHERE account_id = 5;

-- Question 15: update account có id = 5 sẽ thuộc group có id = 4

UPDATE	group_accounts
SET  	group_id = 4 
WHERE	account_id = 5;



