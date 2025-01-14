



-- ###########################################################
-- 2 задание
/* 1. Написать функцию, которая удаляет всю информацию об указанном пользователе из БД vk. Пользователь задается по id. 
Удалить нужно все сообщения, лайки, медиа записи, профиль и запись из таблицы users. Функция должна возвращать номер пользователя. */

DROP FUNCTION IF EXISTS DeleteUserFunc;

CREATE FUNCTION DeleteUserFunc (delete_user_id INT)
RETURNS INT
BEGIN

    DELETE FROM likes
     WHERE likes.user_id = delete_user_id;
    
    DELETE FROM users_communities
     WHERE users_communities.user_id = delete_user_id;
    
    DELETE FROM messages
     WHERE messages.to_user_id = delete_user_id OR messages.from_user_id = delete_user_id;
    
    DELETE FROM friend_requests
     WHERE friend_requests.initiator_user_id = delete_user_id OR friend_requests.target_user_id = delete_user_id;
    
    DELETE likes
      FROM media
      JOIN likes ON likes.media_id = media.id
     WHERE media.user_id = delete_user_id;
    
    UPDATE profiles
      JOIN media ON profiles.photo_id = media.id
       SET profiles.photo_id = NULL
     WHERE media.user_id = delete_user_id;

    DELETE FROM media
     WHERE media.user_id = delete_user_id;
    
    DELETE FROM profiles
     WHERE profiles.user_id = delete_user_id;
    
    DELETE FROM users
     WHERE users.id = delete_user_id;
    
    RETURN delete_user_id;

END;  

