SELECT * FROM	customers;
SELECT * FROM	cars;
SELECT * FROM	car_orders;

-- Questions
-- 1. Tạo table với các ràng buộc và kiểu dữ liệu
-- Thêm ít nhất 5 bản ghi vào table.
-- 2. Viết lệnh lấy ra thông tin của khách hàng: tên, số lượng oto khách hàng đã mua và sắp sếp tăng dần theo số lượng oto đã mua.
SELECT		c.`name` ,co.amount soluong
FROM		customers c 
RIGHT JOIN	car_orders co
ON			c.customer_id=co.customer_id
WHERE		co.`status`='1'
GROUP BY	c.customer_id
ORDER BY	co.amount ASC;

-- 3. Viết hàm (không có parameter) trả về tên hãng sản xuất đã bán được nhiều oto nhất trong năm nay.
DROP PROCEDURE IF EXISTS MAX_SALE_CAR;
DELIMITER $$
CREATE PROCEDURE	MAX_SALE_CAR()
BEGIN	
	SELECT		c.car_id, c.maker,COUNT(co.order_id) sl
    FROM		cars c
    INNER JOIN	car_orders co
    ON			c.car_id=co.car_id
    WHERE		year(delivery_date)=year(now()) AND co.`status`=1
    GROUP BY	c.maker
    ORDER BY COUNT(co.order_id) DESC
    LIMIT 1;
END$$
DELIMITER ;
CALL	MAX_SALE_CAR;
                        
-- 4. Viết 1 thủ tục (không có parameter) để xóa các đơn hàng đã bị hủy của những năm trước. In ra số lượng bản ghi đã bị xóa.
DROP PROCEDURE IF EXISTS xoa_order_cancel;
DELIMITER $$
CREATE PROCEDURE xoa_order_cancel()
BEGIN
	DELETE FROM	car_orders
    WHERE		`status`=2 AND	year(order_date)!=year(now());
END$$
DELIMITER ;
CALL	xoa_order_cancel;

-- 5. Viết 1 thủ tục (có CustomerID parameter) để in ra thông tin của các đơn hàng đã đặt hàng bao gồm: tên của khách hàng, mã đơn hàng, số lượng oto 
-- và tên hãng sản xuất.
DROP PROCEDURE IF EXISTS da_dat_hang;
DELIMITER $$
CREATE PROCEDURE da_dat_hang(IN in_customer_id TINYINT)
BEGIN 
SELECT c.`name`, co.order_id, car.maker, co.mount
FROM customers c
JOIN  car_order co
ON c.customer_id=co.customer_id
JOIN cars car
ON car.car_id=co.car_id
WHERE co.customer_id= in_customer_id;
END$$
DELIMITER ;
CALL da_dat_hang(2);
-- 6. Viết trigger để tránh trường hợp người dụng nhập thông tin không hợp lệ 
-- vào database (DeliveryDate < OrderDate + 15).
