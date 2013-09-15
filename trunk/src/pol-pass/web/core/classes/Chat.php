<?php 
class Chat extends Core {
public function fetchMessages() {
	//
	$this->query("
	SELECT `chat`.`message`,
	       `accounts`.`login`,
		   `accounts`.`id`,
		   `accounts`.`pic`
	FROM    `chat`
	JOIN     `accounts`
	ON       `chat`.`user_id`=`accounts`.`id`
	ORDER BY   `chat`.`message_id`
	DESC LIMIT 30
	");
	return $this->rows();
}
public function throwMessages($user_id, $message){
	$this->query("
	INSERT INTO `chat` (`user_id`, `message`)
	VALUES (". (int)$user_id .", '" . $this->db->real_escape_string(htmlentities($message)) ."')
	");
}
}