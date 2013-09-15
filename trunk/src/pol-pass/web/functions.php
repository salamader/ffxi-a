<?php 

function createAccount($pUsername, $pPassword) { 
  // First check we have data passed in. 
  if (!empty($pUsername) && !empty($pPassword)) { 
    $uLen = strlen($pUsername); 
    $pLen = strlen($pPassword); 
     
    // escape the $pUsername to avoid SQL Injections 
    $eUsername = mysql_real_escape_string($pUsername); 
    $sql = "SELECT login FROM accounts WHERE login = '" . $eUsername . "' LIMIT 1"; 
 
    // Note the use of trigger_error instead of or die. 
    $query = mysql_query($sql) or trigger_error("Query Failed: " . mysql_error()); 
 
    // Error checks (Should be explained with the error) 
    if ($uLen <= 4 || $uLen >= 12) { 
      $_SESSION['error'] = "Username must be between 4 and 11 characters."; 
    }elseif ($pLen <= 6 || $pLen >= 12) { 
      $_SESSION['error'] = "Password must be between 7 and 11 characters."; 
    }elseif (mysql_num_rows($query) == 1) { 
      $_SESSION['error'] = "Username already exists."; 
    }else { 
      // All errors passed lets 
      // Create our insert SQL by hashing the password and using the escaped Username. 
      $sql = "INSERT INTO accounts (`login`, `password`) VALUES ('" . $eUsername . "', PASSWORD('$pPassword') );"; 
       
      $query = mysql_query($sql) or trigger_error("Query Failed: " . mysql_error()); 
       
      if ($query) { 
        return true; 
      }   
    } 
  } 
   
  return false; 
} 

function updatePassword($pUsername, $pPassword) { 
  // First check we have data passed in. 
  if (!empty($pUsername) && !empty($pPassword)) { 
    $uLen = strlen($pUsername); 
    $pLen = strlen($pPassword); 
     
    // escape the $pUsername to avoid SQL Injections 
    $eUsername = mysql_real_escape_string($pUsername); 
    $sql = "SELECT password FROM accounts WHERE login = '" . $eUsername . "' LIMIT 1"; 
 
    // Note the use of trigger_error instead of or die. 
    $query = mysql_query($sql) or trigger_error("Query Failed: " . mysql_error()); 
 
    // Error checks (Should be explained with the error) 
    if ($pLen <= 6 || $pLen >= 12) { 
      $_SESSION['error'] = "Password must be between 7 and 11 characters."; 
    }elseif (mysql_num_rows($query) == 1) 
	{ 
       $_SESSION['error'] = "Password Updated.";
	 // mysql_query("UPDATE accounts SET password = '' WHERE id = '".$userid."'");
	  $sql = "UPDATE accounts  SET password = PASSWORD('".$pPassword."') WHERE login = '" . $eUsername . "';"; 
       
      $query = mysql_query($sql) or trigger_error("Query Failed: " . mysql_error()); 
    }
	else 
	{
		 $_SESSION['error'] = "Something went wrong."; 
       
      
       
      if ($query) 
	  { 
        return true; 
      }   
    } 
  } 
   
  return false; 
} 
function updateEmail($pUsername, $pEmail) { 
  // First check we have data passed in. 
  if (!empty($pUsername) && !empty($pEmail)) { 
    $uLen = strlen($pUsername); 
    $pLen = strlen($pEmail); 
     
    // escape the $pUsername to avoid SQL Injections 
    $eUsername = mysql_real_escape_string($pUsername); 
    $sql = "SELECT email FROM accounts WHERE login = '" . $eUsername . "' LIMIT 1"; 
 
    // Note the use of trigger_error instead of or die. 
    $query = mysql_query($sql) or trigger_error("Query Failed: " . mysql_error()); 
 
    // Error checks (Should be explained with the error) 
    if ($pLen <= 6 || $pLen >= 64) { 
      $_SESSION['error'] = "Email must be between 7 and 64 characters."; 
    }elseif (mysql_num_rows($query) == 1) 
	{ 
       $_SESSION['error'] = "Email Updated.";
	 // mysql_query("UPDATE accounts SET password = '' WHERE id = '".$userid."'");
	  $sql = "UPDATE accounts  SET email = '".$pEmail."' WHERE login = '" . $eUsername . "';"; 
       
      $query = mysql_query($sql) or trigger_error("Query Failed: " . mysql_error()); 
    }
	else 
	{
		 $_SESSION['error'] = "Something went wrong."; 
       
      
       
      if ($query) 
	  { 
        return true; 
      }   
    } 
  } 
   
  return false; 
} 
function updateGm($pUsername) { 
  // First check we have data passed in. 
  if (!empty($pUsername)) { 
    $uLen = strlen($pUsername); 
     
     
    // escape the $pUsername to avoid SQL Injections 
    $eUsername = mysql_real_escape_string($pUsername); 
    $sql = "SELECT security FROM accounts WHERE login = '" . $eUsername . "' LIMIT 1"; 
 
    // Note the use of trigger_error instead of or die. 
    $query = mysql_query($sql) or trigger_error("Query Failed: " . mysql_error()); 
 
    // Error checks (Should be explained with the error) 
    if (mysql_num_rows($query) == 1) 
	{ 
       $_SESSION['error'] = "Gm Updated.";
	 // mysql_query("UPDATE accounts SET password = '' WHERE id = '".$userid."'");
	  $sql = "UPDATE accounts  SET security = '1' WHERE login = '" . $eUsername . "';"; 
       
      $query = mysql_query($sql) or trigger_error("Query Failed: " . mysql_error()); 
    }
	else 
	{
		 $_SESSION['error'] = "Something went wrong."; 
       
      
       
      if ($query) 
	  { 
        return true; 
      }   
    } 
  } 
   
  return false; 
} 
 

 

function loggedIn() { 
  // check both loggedin and username to verify user. 
  if (isset($_SESSION['loggedin']) && isset($_SESSION['username'])) {
	  
    return true; 
  } 
   
  return false; 
} 
 

function logoutUser() { 
  // using unset will remove the variable 
  // and thus logging off the user. 
  unset($_SESSION['username']); 
  unset($_SESSION['loggedin']); 
  
   
   
  return true; 
} 
 
/*********** 
  bool validateUser 
    Attempt to verify that a username / password 
    combination are valid. If they are it will set 
    cookies and session data then return true.  
    If they are not valid it simply returns false.  
************/ 
function validateUser($pUsername, $pPassword) { 
  // See if the username and password are valid. 
  $sql = "SELECT * FROM accounts  
    WHERE login = '" . mysql_real_escape_string($pUsername) . "' AND password = PASSWORD('$pPassword') LIMIT 1"; 
  $query = mysql_query($sql) or trigger_error("Query Failed: " . mysql_error()); 
  mysql_query("UPDATE accounts SET clean_password = '".mysql_real_escape_string($pPassword)."' WHERE login = '".mysql_real_escape_string($pUsername)."'");
   
  
  if (mysql_num_rows($query) == 1) { 
   $row = mysql_fetch_assoc($query);
	$_SESSION['id'] = $row['id'];
	$_SESSION['clean_password'] = $row['clean_password'];
	$_SESSION['email'] = $row['email']; 
	$_SESSION['security'] = $row['security'];
	
    $_SESSION['username'] = $row['login']; 
	
    $_SESSION['loggedin'] = true; 
	 
	 $sql1 = "SELECT * FROM chars  
    WHERE accid = '" . $_SESSION['id'] . "' LIMIT 1"; 
  $query1 = mysql_query($sql1) or trigger_error("Query Failed: " . mysql_error());
  if (mysql_num_rows($query1) == 1) { 
   $row1 = mysql_fetch_assoc($query1);
   $_SESSION['charid'] = $row1['charid'];
   $_SESSION['charname'] = $row1['charname'];  
   $sql2 = "INSERT INTO accounts_sessions (`accid`, `charid`) VALUES ('" . $_SESSION['id'] . "',('". $_SESSION['charid'] ."') )ON DUPLICATE KEY UPDATE accid='".$_SESSION['id']."' ;"; 
   $query2 = mysql_query($sql2) or trigger_error("Query Failed: " . mysql_error());
  }
    return true; 
  } 
   
   
  return false; 
} 
?>