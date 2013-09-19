<?php
require '../core/init.php';
if (isset($_POST['method']) === true && empty($_POST['method']) ===false){
	
	$chat  = new Chat();
	$method = trim($_POST['method']);
	if($method === 'fetch') {
		///
		$messages = $chat->fetchMessages();
		if(empty($messages)=== true) {
			echo 'No Messages';
		}
		else {
			
			foreach($messages as $message) {
				?>
                 
<div class="message">
  <div class="pic"><img src="<?php echo $message['pic']; ?>" width="70px" height="70px"/></div>
  <a href="#"><?php echo $message['login']; ?></a> says:
                <p><?php echo nl2br($message['message']); ?></p>
                </div>
                <?php
			}
		}
	}
	else if ($method === 'throw' && isset($_POST['message']) === true) {
		$message = trim($_POST['message']);
		if(empty($message) === false) {
		$chat->throwMessages($_SESSION['id'], $message);
		}
		
	}
}
?>