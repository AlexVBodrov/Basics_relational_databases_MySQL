 /* 1.	Проанализировать структуру БД vk, которую мы создали на занятии, и внести предложения по усовершенствованию (если такие идеи есть). Напишите пожалуйста, всё-ли понятно по структуре.
 */
 -- в основном предложения заключаються в добавление новых таблиц типа, новостей постов, колекций полезных ресурсов, добавления игр , приложений, внутреней валюты и т.п
 -- password_hash VARCHAR(100) - таких паролей не бывает около 20 символов максимум
 -- в процессе разработки может возникнуть необходимость добавить несколько полей в какие-то таблицы
 
 
/* 2 Практическое задание по теме “Введение в проектирование БД”
Написать крипт, добавляющий в БД vk, которую создали на занятии, 3 новые таблицы
 (с перечнем полей, указанием индексов и внешних ключей)
 */
 
DROP TABLE IF EXISTS user_post;
CREATE TABLE user_post (
	id SERIAL, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
	from_user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(), -- авто вставка времени
	

    FOREIGN KEY (from_user_id) REFERENCES users(id),

);

DROP TABLE IF EXISTS user_comments;
CREATE TABLE user_comments (
	id SERIAL, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
	from_user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(), -- авто вставка времени
	user_post_id BIGINT UNSIGNED NOT NULL,
	media_id BIGINT UNSIGNED NOT NULL,

	

    FOREIGN KEY (from_user_id) REFERENCES users(id),
	FOREIGN KEY (from_media_id) REFERENCES media(id);
	FOREIGN KEY (from_user_post_id) REFERENCES user_post(id)
);

DROP TABLE IF EXISTS `music_albums`;
CREATE TABLE `music_albums` (
	`id` SERIAL,
	`name` varchar(255) DEFAULT NULL,
    `user_id` BIGINT UNSIGNED DEFAULT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
  	PRIMARY KEY (`id`)
);


DROP TABLE IF EXISTS `music`;
CREATE TABLE `music` (
	id SERIAL,
	`music_albums` BIGINT unsigned NULL,
	`media_id` BIGINT unsigned NOT NULL,

	FOREIGN KEY (album_id) REFERENCES music_albums(id),
    FOREIGN KEY (media_id) REFERENCES media(id)
);

3.	Используя сервис http://filldb.info или другой по вашему желанию, сгенерировать тестовые данные для всех таблиц, учитывая логику связей. Для всех таблиц, где это имеет смысл, создать не менее 100 строк. Создать локально БД vk и загрузить в неё тестовые данные.

