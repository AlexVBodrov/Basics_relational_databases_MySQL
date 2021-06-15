--  Практическое задание по теме «Операторы, фильтрация, сортировка и ограничение»
-- 1 Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.

UPDATE users SET created_at= now() , updated_at = Now(); -- без WHERE обновит поля на текущую дату и время
SELECT created_at, updated_at FROM users;


/* Таблица users2 была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате 20.10.2017 8:10. Необходимо преобразовать поля к типу DATETIME, сохранив введённые ранее значения.*/


DROP TABLE IF EXISTS users2;
CREATE TABLE users2 (
	id SERIAL PRIMARY KEY,
	name_U VARCHAR(255),
	created_at varchar(255),
	updated_at varchar(255) );

INSERT INTO users2 
	(name_U, created_at, updated_at)
	VALUES
  ('ГОША', '10.05.1990 10:01', '20.10.2017 8:10'),
  ('Наталья', '11.12.1984 10:01', '20.10.2017 8:10'),
  ('Александр', '20.05.1985 10:01', '20.10.2017 8:10'),
  ('Сергей', '14.02.1988 10:01', '20.10.2017 8:10'),
  ('Иван', '01.12.1998 10:01', '20.10.2017 8:10'),
  ('Мария', '08.09.1992 10:01', '20.10.2017 8:10');
  
ALTER TABLE users2 ADD COLUMN created_at_dt DATETIME;
ALTER TABLE users2 ADD COLUMN updated_at_dt DATETIME;


UPDATE users2
	SET created_at_dt = STR_TO_DATE(created_at, '%d.%m.%Y %h:%i'),
	    updated_at_dt = STR_TO_DATE(updated_at, '%d.%m.%Y %h:%i');
	   
ALTER TABLE users2 
    DROP created_at, DROP updated_at, 
    RENAME COLUMN created_at_dt TO created_at, RENAME COLUMN updated_at_dt TO updated_at;

describe users2;


/*
В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. Однако нулевые запасы должны выводиться в конце, после всех записей. */

DROP TABLE IF EXISTS storehouses_products;
create table storehouses_products (
	id SERIAL PRIMARY KEY,
    storehouse_id INT unsigned,
    product_id INT unsigned,
    `value` INT unsigned COMMENT 'Запас товарный позиции на складке',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

INSERT INTO
    storehouses_products (storehouse_id, product_id, value)
VALUES
    (1, 1, 15),
    (1, 3, 0),
    (1, 5, 10),
    (1, 7, 5),
    (1, 8, 0);

SELECT 
    value
FROM
    storehouses_products ORDER BY IF(value > 0, 0, 1), value; 

/*
(по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы в виде списка английских названий (may, august) */

SELECT
    name, birthday_at, 
    CASE 
        WHEN DATE_FORMAT(birthday_at, '%m') = 05 THEN 'may'
        WHEN DATE_FORMAT(birthday_at, '%m') = 08 THEN 'august'
    END AS mounth
FROM
    users WHERE DATE_FORMAT(birthday_at, '%m') = 05 OR DATE_FORMAT(birthday_at, '%m') = 08;

SELECT
    name, birthday_at, DATE_FORMAT(birthday_at, '%m') as mounth_of_birth
FROM
    users;

SELECT name FROM users WHERE DATE_FORMAT(birthday_at, '%m') IN ('may', 'august'); 

/*
(по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.
*/
SELECT* FROM catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2); 

/*
Практическое задание теме «Агрегация данных»
*/
-- 1.Подсчитайте средний возраст пользователей в таблице users.

SELECT ROUND(AVG((TO_DAYS(NOW()) - TO_DAYS(birthday_at)) / 365.25), 0) AS AVG_Age FROM users;

-- 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. Следует учесть, что необходимы дни недели текущего года, а не года рождения.

SELECT
	DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day,
	COUNT(*) AS total
FROM
	users
GROUP BY
	day
ORDER BY
	total DESC;

-- 3.(по желанию) Подсчитайте произведение чисел в столбце таблицы.

DROP TABLE IF EXISTS integers;
CREATE TABLE integers(
    value SERIAL PRIMARY KEY
);

INSERT INTO integers VALUES
    (NULL),
    (NULL),
    (NULL),
    (NULL),
    (NULL);

SELECT ROUND(exp(SUM(ln(value))), 0) AS product_numbers FROM integers;

