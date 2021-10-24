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

                        
-- 4. Viết 1 thủ tục (không có parameter) để xóa các đơn hàng đã bị hủy của những năm trước. In ra số lượng bản ghi đã bị xóa.

-- 5. Viết 1 thủ tục (có CustomerID parameter) để in ra thông tin của các đơn hàng đã đặt hàng bao gồm: tên của khách hàng, mã đơn hàng, số lượng oto 
-- và tên hãng sản xuất.
-- 6. Viết trigger để tránh trường hợp người dụng nhập thông tin không hợp lệ 
-- vào database (DeliveryDate < OrderDate + 15).
