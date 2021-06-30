-- Практическое задание по теме “Оптимизация запросов”
-- 1.Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и содержимое поля name.

CREATE TABLE logs (
	tablename VARCHAR(255),
	logs_id INT,
	name VARCHAR(255),
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=Archive;

DELIMETR // 
CREATE TRIGGER log_after_insert AFTER INSERT ON users
FOR EACH ROW BEGIN
	INSERT INTO logs (tablename, logs_id, name) VALUES('users', NEW.id, NEW.name);
END//

CREATE TRIGGER log_after_insert AFTER INSERT ON catalogs
FOR EACH ROW BEGIN
	INSERT INTO logs (tablename, logs_id, name) VALUES('catalogs', NEW.id, NEW.name);
END//

CREATE TRIGGER log_after_insert AFTER INSERT ON products
FOR EACH ROW BEGIN
	INSERT INTO logs (tablename, logs_id, name) VALUES('products', NEW.id, NEW.name);
END//

-- 2. (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.

CREATE TABLE users(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	birthday_at DATE,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- http://filldb.info/ add 10 VALUES
INSERT INTO `users` VALUES (1,'Frederik Fisher','2010-04-25','2021-01-12 12:36:32','1995-04-25 21:12:30'),(2,'Aisha Kuhic','1990-07-21','1976-01-27 14:31:34','1987-05-13 02:15:35'),(3,'Geo Hickle IV','1970-11-29','2015-08-08 20:12:21','2003-01-22 20:03:30'),(4,'Vivienne Gorczany','2002-05-06','2001-12-16 07:09:05','1970-10-31 20:06:36'),(5,'Dagmar Nitzsche','2021-02-07','1974-03-22 02:45:28','2014-12-15 22:29:42'),(6,'Rosalind Nolan','1971-04-03','1971-06-13 10:34:52','2007-09-30 21:23:43'),(7,'Mavis Thiel','1981-05-27','2019-07-15 08:01:17','1970-02-27 11:39:27'),(8,'Asa Spencer','1996-07-16','1992-01-08 14:42:38','2003-02-09 14:37:16'),(9,'Mr. Chadrick Schiller','2018-11-15','1990-06-12 02:13:26','1982-07-01 10:07:37'),(10,'Modesto Runolfsdottir','2003-11-07','2006-07-18 08:23:55','2019-09-12 00:56:57');
	
INSERT INTO
	  users (name, birthday_at)
	SELECT
	  t1.name
	  t1.birthday_at
	FROM
		users AS t1,
		users AS t2,
		users AS t3,
		users AS t4,
		users AS t5,
		users AS t6;


