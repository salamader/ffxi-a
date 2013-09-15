<?php 

include "header.php";
 
  require_once('recaptchalib.php');
  $privatekey = "6LedLeYSAAAAAJOCNTQu1dBzz-cIe6uExNgOrlwe";
   if (isset($_GET['action'])) 
   { 
   
   switch (strtolower($_GET['action'])) 
   {
   case 'register':
   {
    if (isset($_POST['username']) && isset($_POST['password'])) 
	  {
    $resp = recaptcha_check_answer ($privatekey,
                                $_SERVER["REMOTE_ADDR"],
                                $_POST["recaptcha_challenge_field"],
                                $_POST["recaptcha_response_field"]);
               if (!$resp->is_valid) 
                {
                // What happens when the CAPTCHA was entered incorrectly
                ?>
                <div class="main">
				<span class="shadow-top"></span>
				<!-- shell -->
				<div class="shell">
					<div class="container">
					
                        <!-- testimonial -->
						<section class="testimonial">
							<h2>Final Fantasy XI Private Server!</h2>
							<p><strong>“</strong>Sorry but CAPTCHA was not enter in corectly try again.</p>
              <META http-equiv="refresh" content="10;URL=register.php">
						</section>
						<!-- testimonial -->
					</div>
				<!-- end of shell -->
				</div>
				<!-- end of container -->
			</div>
			<!-- end of main -->
		</div>	
                  <?php
                }
                else
                {
                   if (createAccount($_POST['username'], $_POST['password'])) 
                    {
                       ?>
                <div class="main">
				<span class="shadow-top"></span>
				<!-- shell -->
				<div class="shell">
					<div class="container">
					
                        <!-- testimonial -->
						<section class="testimonial">
							<h2>Final Fantasy XI Private Server!</h2>
							<p><strong>“</strong>So Awesome to have you here with us, Thank You for joining.</p>
<p>in a few moments you will be redirected to login, and again Thank you for your patience.</p>
              <META http-equiv="refresh" content="10;URL=login.php">
						</section>
						<!-- testimonial -->
					</div>
				<!-- end of shell -->
				</div>
				<!-- end of container -->
			</div>
			<!-- end of main -->
		</div>	
                  <?php
     
                    }
                    else
                    {
                    unset($_GET['action']); 
                    }
                }
     
    
    }
   break;
   }
   
   break;
   }
   }
   
   
 

 

if (loggedIn())
 { 
 
  ?>
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
     
      
   				
                
                   
                    
                       
                            
                            <CENTER><form name="register" method="post" action="<?php echo $_SERVER['PHP_SELF']?>?action=register" >
                               
                                <h1> Sign up </h1> 
                                <p> 
                                <img src="images/userexample.png"> </br>
                                  <label for="username" class="uname" data-icon="u">Username</label>
                                    <input id="usernamesignup" name="username" required type="text" value="<?php echo $sUsername ?>" />
                                </p>
                                <p>
								<?php
          
          $publickey = "6LedLeYSAAAAABOQy0QkWwOsXXkphRV__NBNGtou"; // you got this from the signup page
          echo recaptcha_get_html($publickey);
        ?></p>
                                <p> 
                                <img src="images/passexample.png"> </br>
                                    <label for="passwordsignup" class="youpasswd" data-icon="p">Your password </label>
                                    <input id="passwordsignup" name="password"  onkeyup="displayResult()" required type="text" value="" />
                       
                                </p>
                               
                                <p class="signin button"> 
									<input type="submit" name="submit" value="Register!"/> 
								</p>
                              
                            </form></CENTER>
                        
                          
                          

                       
						
                   
                 
            </section>
          
                    
					</div>
				<!-- end of shell -->
				</div>
				<!-- end of container -->
			</div>
			<!-- end of main -->
		</div>	
   <?php
   ?>
 <script type="text/javascript">
function displayResult()
{
	
var x=document.getElementById("passwordsignup").value;
showKeyCode(x);
}

function showKeyCode(e) {
	//alert( "keyCode for the key pressed: " + e.keyCode + "\n" );
	if(e.keyCode == 32)
	{
		//alert( "Sorry but your unable to use spaced passwords!\n" );
		
		document.getElementById("passwordsignup").value='ERROR_NO_SPACE';
	}
	
}

</script>
</head>

<body onkeydown="showKeyCode(event);">


   <?php 
} 
 

}

include "footer.php";
?>