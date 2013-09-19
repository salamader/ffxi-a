<?php 

include "header.php";
if (isset($_GET['action'])) 
   { //
   
   switch (strtolower($_GET['action'])) 
   {//
   case 'updatepass':
   {//
    if (isset($_POST['username']) && isset($_POST['password'])) 
	  {//
          if (updatePassword($_POST['username'], $_POST['password'])) 
              {//
			  
			  unset($_GET['action']);
                      
               }//
               else
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
							<p><strong>“</strong>Your password was update successfuly!.</p>
<p>in a few moments you will be redirected to your profile, and again Thank you for your patience.</p>
              <META http-equiv="refresh" content="10;URL=profile.php">
						</section>
						<!-- testimonial -->
					</div>
				<!-- end of shell -->
				</div>
				<!-- end of container -->
			</div>
			<!--
                  <?php
                 
                }
                
     
    
     }//
	 
   break;
   }//
   case 'updateemail':
   {//
    if (isset($_POST['username']) && isset($_POST['email'])) 
	  {//
          if (updateEmail($_POST['username'], $_POST['email'])) 
              {//
			  
			  unset($_GET['action']);
                      
               }//
               else
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
							<p><strong>“</strong>Your email was update successfuly!.</p>
<p>in a few moments you will be redirected to your profile, and again Thank you for your patience.</p>
              <META http-equiv="refresh" content="10;URL=profile.php">
						</section>
						<!-- testimonial -->
					</div>
				<!-- end of shell -->
				</div>
				<!-- end of container -->
			</div>
			<!--
                  <?php
                 
                }
                
     
    
     }//
	 
   break;
   }//
    case 'updategm':
   {//
    if (isset($_POST['username']) ) 
	  {//
          if (updateGm($_POST['username'])) 
              {//
			  
			  unset($_GET['action']);
                      
               }//
               else
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
							<p><strong>“</strong>Your gm status was update successfuly!.</p>
<p>in a few moments you will be redirected to your profile, and again Thank you for your patience.</p>
              <META http-equiv="refresh" content="10;URL=profile.php">
						</section>
						<!-- testimonial -->
					</div>
				<!-- end of shell -->
				</div>
				<!-- end of container -->
			</div>
			<!--
                  <?php
                 
                }
                
     
    
     }//
	 
   break;
   }//
   
   break;
   }//
   }//
   
   
 

 

if (loggedIn())
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
  $sUsername = $_SESSION['username']; 
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
     
      
   				
                
                   
                    
                       
                            
                             <form name="updatepass" method="post" action="<?php echo $_SERVER['PHP_SELF']?>?action=updatepass" >
                               
                                <h1> Change Profile Password </h1> 
                                <input id="usernamesignup" name="username"  required type="hidden" value="<?php echo $sUsername ?>" />
                                <p> 
                                    <label for="passwordsignup" class="youpasswd" data-icon="p">Your password </label>
                                    <input id="passwordsignup" name="password"  onkeyup="displayResult()" required type="text" value="" />
                       
                                </p>
                               
                                <p class="signin button"> 
									<input type="submit" name="submit" value="Update!"/> 
								</p>
                              
                            </form><br>

                            <form name="updateemail" method="post" action="<?php echo $_SERVER['PHP_SELF']?>?action=updateemail" >
                               
                                <h1> Change Profile Email </h1> 
                                <input id="usernamesignup" name="username"  required type="hidden" value="<?php echo $sUsername ?>" />
                                <p> 
                                    <label for="emailsignup" class="youemail" data-icon="p">Your email </label>
                                    <input id="emailsignup" name="email" onKeyUp="displayeResult()" required type="text" value="" />
                       
                                </p>
                               
                                <p class="signin button"> 
									<input type="submit" name="submit" value="Update!"/> 
								</p>
                              
                            </form><br>
                            
                            <form name="updategm" method="post" action="<?php echo $_SERVER['PHP_SELF']?>?action=updategm" >
                               
                                <h1> Change Profile To Gm Status </h1> 
                                <input id="usernamesignup" name="username"  required type="hidden" value="<?php echo $sUsername ?>" />
                                
                               
                                <p class="signin button"> 
									<input type="submit" name="submit" value="Update!"/> 
								</p>
                              
                            </form>
                        
                          <br>
<form name="updatepic" method="post" action="upload.php" >
                               
                                <h1> Change Profile Picture </h1> 
                               
                                
                               
                                <p class="signin button"> 
									<input type="submit" name="submit" value="Update!"/> 
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
   ?>
 <script type="text/javascript">
function displayResult()
{
	
var x=document.getElementById("passwordsignup").value;
showKeyCode(x);
}
function displayeResult()
{
	
var x=document.getElementById("emailsignup").value;
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
else
{
	
	?>
      <META http-equiv="refresh" content="0;URL=index.php">
        <?php
 

}

include "footer.php";
?>