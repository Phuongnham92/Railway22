DROP DATABASE IF EXISTS quanli_car;
CREATE DATABASE  quanli_car;
USE quanli_car;
-- DROP TABLE IF EXISTS
-- CUSTOMER,
-- `ORDER`,
-- CAR;

CREATE TABLE	customers
(
	customer_id		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	`name`			VARCHAR(50) NOT NULL, 	
	phone			VARCHAR(13)	NOT NULL,
	email			VARCHAR(50) UNIQUE NOT NULL,
	address			VARCHAR(100),
	note			TEXT
    );
    
CREATE TABLE	cars
(
	car_id			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    maker			ENUM('HONDA','TOYOTA','NISSAN'),
    model			VARCHAR(50) NOT NULL,
    `year`			DATE,
    color			VARCHAR(50),
    note			TEXT
);

CREATE TABLE	car_orders
(	
	order_id		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	customer_id		TINYINT UNSIGNED, -- foreign key.
	car_id			TINYINT UNSIGNED,	--  foreign key.
	amount			TINYINT DEFAULT 1,
	sale_price		INT	UNSIGNED,
	order_date		DATE,
	delivery_date	DATE,
	delivery_address	VARCHAR(100),
	`status`		ENUM('0','1','2') DEFAULT(0),
    -- (0: đã đặt hàng, 1: đã giao, 2: đã hủy), mặc định trạng thái là đã đặt hàng.
	 note			TEXT,
     FOREIGN KEY(customer_id) REFERENCES customers(customer_id),
     FOREIGN KEY(car_id) REFERENCES cars(car_id)
     );
		
		
    
    
    
    