/*
Урок 4. SQL – работа с несколькими таблицами
Условие:
1. Подсчитать общее количество лайков, которые получили пользователи
младше 12 лет. */
SELECT
	COUNT(*) AS `Общее количество лайков`
FROM likes AS l
JOIN media AS m ON m.id = l.media_id
JOIN profiles AS p ON p.user_id = m.user_id
WHERE TIMESTAMPDIFF(YEAR, p.birthday, NOW()) < 12;

/*
2. Определить кто больше поставил лайков (всего): мужчины или
женщины. */
SELECT
	COUNT(*) as `Количество лайков`,
	(SELECT CASE
			WHEN p.gender = 'f' THEN 'Женщины'
			WHEN p.gender = 'm' THEN 'Мужики'
		END)  AS `Кто поставил лайки?`
FROM likes AS l
JOIN profiles AS p ON p.user_id = l.user_id
GROUP BY `Кто поставил лайки?`
ORDER BY `Количество лайков` DESC
LIMIT 1;

/*
3. Вывести всех пользователей, которые не отправляли сообщения.
*/
SELECT 
	u.id,
	u.firstname,
	u.lastname,
	u.email
FROM users AS u
LEFT JOIN messages AS m ON u.id = m.from_user_id
WHERE m.from_user_id IS NULL;

/*
4. (по желанию)* Пусть задан некоторый пользователь. Из всех друзей
этого пользователя найдите человека, который больше всех написал
ему сообщений.
*/
SELECT 
	COUNT(*) as count, 
	m.from_user_id,
	u.firstname,
	u.lastname,
	u.email
FROM messages AS m
JOIN users AS u ON u.id = m.from_user_id 
WHERE to_user_id = '2'
GROUP BY m.from_user_id
ORDER BY count DESC
LIMIT 1;