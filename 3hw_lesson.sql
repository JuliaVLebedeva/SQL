/*
Таблица для работы на слайде.
1. Отсортируйте данные по полю заработная плата (salary) в порядке: убывания; возрастания
*/

-- Убывание 
SELECT * FROM staff ORDER BY salary DESC;
-- Возрастание 
SELECT * FROM staff ORDER BY age;

/*
2. Выведите 5 максимальных заработных плат (saraly)
*/
SELECT * FROM staff ORDER BY salary DESC LIMIT 5;

/*
3. Посчитайте суммарную зарплату (salary) по каждой специальности (роst)
*/
SELECT post, SUM(salary) FROM staff
GROUP BY post;

/*
4. Найдите кол-во сотрудников со специальностью (post) «Рабочий» в возрасте от 24 до 49 лет включительно.
*/ -- SELECT COUNT(*) FROM staff WHERE post = 'Рабочий';

SELECT COUNT(*) FROM staff WHERE post = 'Рабочий' and age between '24' and '49';

/*
5. Найдите количество специальностей
*/ 
SELECT COUNT(DISTINCT post) FROM staff;

/*
6. Выведите специальности, у которых средний возраст сотрудников меньше 30 лет
*/

-- ЭТОТ КОД НЕ СРАБОТАЛ. НЕ СМОГЛА ПОНЯТЬ ПОЧЕМУ.

SELECT post FROM staff 
GROUP BY post
HAVING AVG(age) < 30;


