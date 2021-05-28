--Домашнее задание из презентации
/* 1. задание
Пусть в таблице catalogs базы данных shop в строке name могут находиться пустые строки и поля принимающие значение NULL. Напишите запрос, который заменяет все такие поля на строку ‘empty’. Помните, что на уроке мы установили уникальность на поле name. Возможно ли оставить это условие? Почему?
*/
DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

--Пусть в таблице catalogs базы данных shop в строке name могут находиться пустые строки и поля принимающие значение NULL
INSERT INTO catalogs value
	(null, null),
	(null, null),
	(null, null);

SELECT * FROM catalogs;
DESCRIBE catalogs; 

UPDATE catalogs SET name ='empty' WHERE (name IS NULL); 

/*
Выдаст: Error 
Причина: Duplicate entry 'empty' for key 'catalogs.unique_name'

Запрос выдает ошибку так как мы установили уникальность на поле name.
если удалить строчку: UNIQUE unique_name(name(10))
все отработает
*/



/* 2. задание
Спроектируйте базу данных, которая позволяла бы организовать хранение медиа-файлов, загружаемых пользователем (фото, аудио, видео).
Сами файлы будут храниться в файловой системе, а база данных будет хранить только 
пути к файлам, названия, описания, ключевых слов и принадлежности пользователю.
*/
DROP DATABASE IF EXISTS media_storage;
CREATE DATABASE media_storage DEFAULT CHARACTER SET utf8;
USE media_storage;

DROP TABLE IF EXISTS media_files;
CREATE TABLE media_files (
	id serial PRIMARY KEY,
    path_file VARCHAR(256) NOT NULL COMMENT 'путь к файлу',
    title VARCHAR(128) NOT NULL COMMENT 'Название',
    description text COMMENT 'Описание',
    key_words VARCHAR(256) COMMENT 'Ключевые слова',
    owner_user VARCHAr(128) NOT NULL COMMENT 'Кому принадлежит'
);

