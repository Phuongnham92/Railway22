USE quanli_car;
INSERT INTO	customers(`name`, 				phone,				 email,					address, 	note)
	VALUES			('Nguyen Hai Dang',		0123456787,	  	'haidang2@gmail.com',	'address1',	'tocngan'),
                    ('Nguyen Chien Thang',	0123456780,      'account1@gmail.com',	'address2',	'tocdai'),
                    ('Nguyen Van Chien',	0123456783,      'account2@gmail.com',	'address3',	'cao'),
                    ('Duong Do',			0123456781,      'account3@gmail.com',	'address4',	'thap'),
                    ('Nguyen Chien',    	0123456785,      'account4@gmail.com',	'address5',	'tocvang');
                    
INSERT INTO	cars(maker,		model,	 			`year`,		 		color,			note)
VALUES			('HONDA',	'modelA',			'2020-03-03',		'black',		'hdfh'),
				('TOYOTA',	'modelB',			'2012-03-09',		'redd',			'vjhvh'),
                ('NISSAN',	'modelC',			'2019-09-07',		'blue',			'gjhkinb');
                
INSERT INTO	car_orders(customer_id,	car_id, amount, sale_price,		order_date,	 delivery_date,	delivery_address,	 `status`,		note)			
VALUES				(1	,			3,		1,		1000000,	 '2010-09-02', 	'2010-09-03',		'fgfd',				'0',		'tyfchg'),	
					(2	,			3,		6,		2000000,     '2021-08-06', 	'2021-08-07',  		'address2',			'1',		'NULnfL'),
                    (3	,			3,		4,		5000000,     '2021-02-04', 	'2021-02-09',  		'address3',			'1',		'NngULL'),
                    (4	,			1,		3,		3000000,     '2021-08-02', 	'2021-08-06',  		'hfghfgh',			'0',		'NULnvL'),
                    (5	,			1,		1,		3000000,     '2020-10-10',	'2020-10-18', 		'jgfjg',			'2',		'cancel');