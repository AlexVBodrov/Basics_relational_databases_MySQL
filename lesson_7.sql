-- Тема “Сложные запросы”

-- 1 Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

SELECT u.name
FROM users AS u
JOIN orders AS o ON (o.user_id = u.id)
GROUP BY u.name
HAVING COUNT(o.id) > 0;

-- 2 Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT p.name, c.name 
FROM products AS p 
JOIN catalogs AS c ON (p.catalog_id = c.id)
GROUP BY p.id;

-- 3 (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). Поля from, to и label содержат английские названия городов, поле name — русское. Выведите список рейсов flights с русскими названиями городов.

USE flights_cities;
SELECT 
	name AS "Отправление",
	(SELECT name FROM cities AS c where c.label=f.`to`) AS "Прибытие",
	 `from`,
	 `to`
FROM flights AS f LEFT JOIN  cities AS c
ON c.label=f.`FROM` 
;

-- добавил вариант без английских столбцов

SELECT 
	name AS "Отправление",
	(SELECT name FROM cities AS c where c.label=f.`to`) AS "Прибытие"
	 -- `from`,
	 -- `to`
FROM flights AS f INNER JOIN  cities AS c
ON c.label=f.`FROM` 
;
