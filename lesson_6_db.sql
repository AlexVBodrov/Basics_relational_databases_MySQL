-- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение. Агрегация данных”

-- Работаем с БД vk и тестовыми данными, которые вы сгенерировали ранее:

-- 1 Проанализировать запросы, которые выполнялись на занятии, определить возможные корректировки и/или улучшения (JOIN пока не применять).

-- 2 Пусть задан некоторый пользователь. 
-- Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.

USE vk;
SELECT from_user_id, COUNT(*) as send, -- считаем кол-во отправленных
	(SELECT first_name FROM users WHERE id = from_user_id) AS 'Name friend', -- имя друга
	(SELECT last_name FROM users WHERE id = from_user_id) AS 'Last_name friend' -- фамилия
FROM messages WHERE to_user_id=1  -- из сообщений где некоторый пользователь id=1
GROUP BY from_user_id ORDER BY send DESC LIMIT 1; -- сортируем, оставляем нужное


-- 3 Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

SELECT user_id, birthday, (YEAR(NOW())-YEAR(birthday)) AS age FROM profiles WHERE (YEAR(NOW())-YEAR(birthday)) ORDER BY age ASC LIMIT 10; -- 10 самых молодых
-- вставляем их id и считаем лайки следующим запросом
SELECT count(id) FROM likes WHERE user_id IN (245, 173, 190, 167, 184, 185, 180, 284, 172, 246);  -- WHERE + LIMIT выдает ошибку, поэтому решение вставить номера id



-- 4 Определить кто больше поставил лайков (всего) - мужчины или женщины?


SELECT gender, COUNT(*) as count_likes FROM profiles GROUP BY gender ORDER BY count_likes DESC LIMIT 1;


-- 5 Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.

SELECT 
  CONCAT(firstname, ' ', lastname) AS user, 
  (SELECT COUNT(*) FROM likes WHERE likes.user_id = users.id) + 
  (SELECT COUNT(*) FROM media WHERE media.user_id = users.id) + 
  (SELECT COUNT(*) FROM messages WHERE messages.from_user_id = users.id) AS min_activity 
FROM users
ORDER BY min_activity
LIMIT 1;