<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=0" />
    <title>FFXI-A</title>
    <link rel="shortcut icon" type="image/x-icon" href="http://www.ffxi-a.comcss/images/favicon.ico" />

    <link rel="stylesheet" href="http://www.ffxi-a.com/css/style.css" type="text/css" media="all" />
    <link rel="stylesheet" href="http://www.ffxi-a.com/css/flexslider.css" type="text/css" media="all" />
    <link href='http://fonts.googleapis.com/css?family=Ubuntu:400,500,700' rel='stylesheet' type='text/css' />

    <script src="js/jquery-1.8.0.min.js" type="text/javascript"></script>
    <!--[if lt IE 9]>
		<script src="js/modernizr.custom.js"></script>
	<![endif]-->
    <script src="http://www.ffxi-a.com/js/jquery.flexslider-min.js" type="text/javascript"></script>
    <script src="http://www.ffxi-a.com/js/functions.js" type="text/javascript"></script>

  </head>
  <?php 
  require "config.php";
  if (isset($_GET['id'])&&isset($_GET['username'])&&isset($_GET['password']))
  { 
   $username = $_GET["username"];  
   $password = $_GET["password"];
	
	$sql = "SELECT * FROM accounts  
    WHERE login = '" . mysql_real_escape_string($username) . "' AND password = PASSWORD('$password') LIMIT 1"; 
  $query = mysql_query($sql) or trigger_error("Query Failed: " . mysql_error()); 
  if (mysql_num_rows($query) == 1) 
  { 
   $row = mysql_fetch_assoc($query);
   if(isset($_SESSION)){
 
}
else
{

   session_start();
}
 
   $_SESSION['id'] =$_GET['id'];
   ?>
   <div id="chat" style="display: block;padding: 5px;">
						<div class="chat">
<div class="messages">
<div class="message"></div>
</div>
<textarea class="entry" placeholder="Type here and hit Return. Use Shift + Return for a new line"></textarea>
</div>
<script src="http://www.ffxi-a.com/js/chat.js" ></script>
</div>   
   <?php
  
  }
  }
  
  
  ?>







