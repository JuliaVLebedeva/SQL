/*  
1. Используя операторы языка SQL, создайте табличку “sales”. Заполните ее данными 
*/
USE 2_lesson;

CREATE TABLE Sales
(
	Id SERIAL PRIMARY KEY,
	Order_date DATE,
	Count_product INT
);

INSERT INTO Sales (Order_date, Count_product)
VALUES 
('2022-01-01', 156),
('2022-01-02', 180),
('2022-01-03', 21),
('2022-01-04', 124),
('2022-01-05', 341);
-- ----------------------------------

/*
2. Для данных таблицы “sales” укажите тип заказа в зависимости от кол-ва : 
   меньше 100 - "Маленький заказ"; от 100 до 300 - "Средний заказ"; больше 300 - "Большой заказ";
*/
SELECT id, 
CASE 
	WHEN Count_product < 100 THEN 'Маленький заказ'
    WHEN Count_product BETWEEN 100 AND 300 THEN 'Средний заказ'
    WHEN Count_product > 300 THEN 'Большой заказ'
    ELSE 'Не указано'
END AS 'Тип заказа'
FROM Sales;

/* 
3. Создайте таблицу “orders”, заполните ее значениями (см. презентацию). 
	Выберите все заказы. В зависимости от поля order_status выведите столбец full_order_status: 
	OPEN – «Order is in open state» ; CLOSED - «Order is closed»; CANCELLED - «Order is cancelled».
*/

CREATE TABLE Orders
(
	Id SERIAL PRIMARY KEY,
	Employee_id VARCHAR(11),
	Amount VARCHAR(11),
    Order_status TEXT
);

INSERT INTO Orders (Employee_id, Amount, Order_status)
VALUES 
('e03', 15.00, 'OPEN'),
('e01', 25.50, 'OPEN'),
('e05', 100.70, 'CLOSED'),
('e02', 22.18, 'OPEN'),
('e04', 9.50, 'CANCELLED')
;

-- ПЕРВЫЙ ВАРИАНТ
SELECT *,
IF (Order_status = 'OPEN', 'Order is in open state',
	IF (Order_status = 'CLOSED', 'Order is closed state',
		IF (Order_status = 'CANCELLED', 'Order is cancelled state', 'Не определено'))) AS Full_order_status
FROM Orders;


-- ВТОРОЙ ВАРИАНТ
SELECT *,
CASE order_status
    WHEN "OPEN" THEN 'Order is in open state'
    WHEN "CLOSED" THEN 'Order is closed state'
    ELSE 'Order is cancelled state'
END AS Full_order_status
FROM orders;

/*
	4. Чем NULL отличается от 0?
    
    "0" — это значение, константа. A null указывает на "пустое место" — объявленную, но неинициализированную переменную, объект и т.
    NULL - это специальное значение, которое используется в SQL для обозначения отсутствия данных. 
    Оно отличается от пустой строки или нулевого значения, так как NULL означает отсутствие какого-либо значения в ячейке таблицы.
    Однако, важно понимать, что NULL не обязательно означает отсутствие информации или отсутствие значения в столбце. 
    NULL может быть использован для разных целей, таких как указание на неопределенный результат для вычислений или 
    как маркер для отметки отсутствия значения в таблице.
*/


    
    