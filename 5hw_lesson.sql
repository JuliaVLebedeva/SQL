/* Урок 5. SQL – оконные функции
Для решения задач используйте базу данных lesson_4
(скрипт создания, прикреплен к 4 семинару).

1. Создайте представление, в которое попадет информация о пользователях (имя, фамилия, город и пол), которые не старше 20 лет.

2. Найдите кол-во, отправленных сообщений каждым пользователем и выведите ранжированный список пользователей, 
указав имя и фамилию пользователя, количество отправленных сообщений и место в рейтинге 
(первое место у пользователя с максимальным количеством сообщений) . (используйте DENSE_RANK)

3. Выберите все сообщения, отсортируйте сообщения по возрастанию даты отправления (created_at) 
и найдите разницу дат отправления между соседними сообщениями, получившегося списка. (используйте LEAD или LAG)
*/

-- Создайте представление, в которое попадет информация о пользователях (имя, фамилия, город и пол), которые не старше 20 лет.

CREATE OR REPLACE VIEW view_user_less_20 AS
SELECT
	u.id,
	u.firstname,
	u.lastname,
	u.email,
    p.gender,
    p.birthday,
    p.hometown
FROM users AS u
JOIN profiles AS p ON u.id = p.user_id
WHERE TIMESTAMPDIFF(YEAR, p.birthday, NOW()) < 20;

SELECT
	id,
	firstname,
	lastname,
	email,
    gender,
    birthday,
    hometown
FROM view_user_less_20;

-- Найдите кол-во, отправленных сообщений каждым пользователем и выведите ранжированный список пользователей,
-- указав имя и фамилию пользователя, количество отправленных сообщений и место в рейтинге 
-- (первое место у пользователя с максимальным количеством сообщений). (используйте DENSE_RANK)

SELECT 
	id,
	DENSE_RANK() OVER(ORDER BY cnt DESC) AS user_rank,
    firstname,
	lastname,
	email,
    cnt
FROM 
(
SELECT
	u.id,
	u.firstname,
	u.lastname,
	u.email,
    COUNT(*) AS cnt
FROM users AS u
JOIN messages AS m ON u.id = m.from_user_id
GROUP BY from_user_id
ORDER BY cnt DESC
) sub;

-- Выберите все сообщения, отсортируйте сообщения по возрастанию даты отправления (created_at)
-- и найдите разницу дат отправления между соседними сообщениями, получившегося списка. (используйте LEAD или LAG)

SELECT 
	id,
    from_user_id,
    to_user_id,
    body,
    created_at,
	LEAD(created_at, 1, 0) OVER(ORDER BY created_at DESC) AS last_created_at, 
    TIMESTAMPDIFF(MINUTE, LEAD(created_at, 1, 0) OVER(ORDER BY created_at DESC), created_at) AS diff_created_at
	-- ROUND((created_at-LEAD(created_at, 1, 0) OVER(ORDER BY created_at DESC))) AS diff_created_at
FROM messages;