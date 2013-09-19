<?php
include "header.php"; 

if (isset($_GET['action'])) {
	 
  switch (strtolower($_GET['action'])) 
  { 
    case 'login':
	
      if (isset($_POST['username']) && isset($_POST['password'])) 
	  { 
        
        if (!validateUser($_POST['username'], $_POST['password'])) 
		{ 
          $_SESSION['error'] = "Bad username or password supplied."; 
          unset($_GET['action']); 
        } 
      }
	  else 
	  { 
        $_SESSION['error'] = "Username and Password are required to login."; 
        unset($_GET['action']);
		 
      }       
    break; 
    case 'logout': 
	
      if (loggedIn()) 
	  { 
	   
	   
        logoutUser();
		?> 
		
       <META http-equiv="refresh" content="0;URL=login.php"> 
             
            <?php
      }
	  else 
	  { 
        unset($_GET['action']);
		
      } 
    break; 
  } 
} 
 


if (loggedIn()) 
{ 

?>
<!-- main -->
		<META http-equiv="refresh" content="0;URL=index.php">
<?php
  
}
else
{
	
	if (!isset($_GET['action'])) 
{ 
?>
  <!-- main -->
			<div class="main">
				<span class="shadow-top"></span>
				<!-- shell -->
				<div class="shell">
					<div class="container">
					
                    <section>
					<?php	
  $sUsername = ""; 
  if (isset($_POST['username'])) 
  { 
    $sUsername = $_POST['username']; 
  } 
   
  $sError = ""; 
  if (isset($_SESSION['error'])) 
  { 
    echo '<span id="error">' . $_SESSION['error'] . '</span><br />'; 
  } 
   ?>
  			
                
                   
                            <form  name="login" method="post" action="login.php?action=login"> 
                                <h1>Log in</h1> 
                                <p> 
                                
                                    <label for="username" class="uname" data-icon="u" > Username </label>
                                    <input id="username" name="username"  type="text"  value="<?php echo $sUsername  ?>"/>
                                </p>
                                <p>
                                
                                    <label for="username" class="uname" data-icon="p"> Passowrd </label>
                                    <input id="password" name="password" type="password"  value="" /> 
                                </p>
                               
                                <p class="login button">
                               
                                    <input type="submit" name="submit" value="Login!" /> 
								</p>
                                
                            </form>
                        
                          
                        

                       
						
                   
                 
            </section>
                    
                        
					</div>
				<!-- end of shell -->
				</div>
				<!-- end of container -->
			</div>
			<!-- end of main -->
		</div>	
   <?php
  
} 
 
}
include "footer.php"; 
?>