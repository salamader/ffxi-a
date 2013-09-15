<?php
require "config.php";
if (isset($_POST['username']) && isset($_POST['password'])) 
{
    $username = $_POST["username"];  
    $password = $_POST["password"];
	if (!validateUser($_POST['username'], $_POST['password'])) 
		{ 
         echo $_SESSION['error'] ="Username or Password is incorrect!"; 
         // unset($_GET['action']); 
        }
		else
		{ 
        echo $_SESSION['id'];
		}
}
?>
