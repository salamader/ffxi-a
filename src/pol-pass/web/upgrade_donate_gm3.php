<?php 
include "header.php";

if (loggedIn()) 
{
?>
<!---START HTML CODE --->

<?php 
if($_SESSION["security"] == 1)
{

?>
<!-- main -->
			<div class="main">
				<span class="shadow-top"></span>
				<!-- shell -->
				<div class="shell">
					<div class="container">
					

						
						
						<!-- cols -->
						<section class="cols">
							<div class="col">
								<h3>Upgrade To SGM</h3>
								<a href="upgrade_donate_gm2.php"><img src="css/images/cols-img2.png" alt="" class="alignleft"/></a>
								<div class="col-cnt">
									<p>Get SGM Status Only $5.00 This helps us keep our server.</p>
								</div>
								<a href="upgrade_donate_gm2.php" class="view">Buy It Now It's Instant!</a>
							</div>
                            <div class="col">
								<h3>Upgrade To LGM</h3>
								<a href="upgrade_donate_gm3.php"><img src="css/images/cols-img3.png" alt="" class="alignleft"/></a>
								<div class="col-cnt">
									<p>Get LGM Status Only $15.00 This helps us keep our server.</p>
								</div>
								<a href="upgrade_donate_gm3.php" class="view">Buy It Now It's Instant!</a>
							</div>
							<div class="cl">&nbsp;</div>
                         </section>
						<!-- end of cols -->
                         <!-- testimonial -->
						<section class="testimonial">
							<h2>Donation For LGM Status!</h2>
							<p><strong>“</strong>Donate now by clicking the donate button below.</p>
                             <!-- The PayPal Donation Button -->
        
      <form action="<?php echo $payPalURL?>" method="post" class="payPalForm">
        
            <input type="hidden" name="cmd" value="_donations" />
            <input type="hidden" name="item_name" value="Donation" />

            <!-- Your PayPal email: -->
            <input type="hidden" name="business" value="<?php echo $myPayPalEmail?>" />

            <!-- PayPal will send an IPN notification to this URL: -->
            <input type="hidden" name="notify_url" value="<?php echo $url.'/ipn3.php'?>" /> 

            <!-- The return page to which the user is navigated after the donations is complete: -->
            <input type="hidden" name="return" value="<?php echo $url.'/thankyou.php'?>" /> 

            <!-- Signifies that the transaction data will be passed to the return page by POST -->
            <input type="hidden" name="rm" value="2" /> 


			

            <input type="hidden" name="no_note" value="1" />
            <input type="hidden" name="cbt" value="Go Back To The Site" />
            <input type="hidden" name="no_shipping" value="1" />
            <input type="hidden" name="lc" value="US" />
            <input type="hidden" name="currency_code" value="USD" />


			
<input type="hidden" name="amount" value="15" />
			

            <input type="hidden" name="bn" value="PP-DonationsBF:btn_donate_LG.gif:NonHostedGuest" />

            <!-- You can change the image of the button: -->
            <input type="image" src="https://www.paypal.com/en_US/i/btn/btn_donate_LG.gif" name="submit" alt="PayPal - The safer, easier way to pay online!" />

          <img alt="" src="https://www.paypal.com/en_US/i/scr/pixel.gif" width="1" height="1" />
        
        </form>
                           
                            <h2>This Is Our Goal To Reach $100.00 Each Month!</h2>
                            <div class="chart" style="background:url('<?php echo $chartURL?>');">
    	                    
                            </div>
    
                            <div class="donations">
    	                    <h3>We have <?php echo $percent?>$ so far this month!</h3>
                            </div>
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
if($_SESSION["security"] == 2)
{

?>
<!-- main -->
			<div class="main">
				<span class="shadow-top"></span>
				<!-- shell -->
				<div class="shell">
					<div class="container">
					

						
						
						<!-- cols -->
						<section class="cols">
							
                            <div class="col">
								<h3>Upgrade To LGM</h3>
								<a href="last_upgrade_donate_gm3.php"><img src="css/images/cols-img3.png" alt="" class="alignleft"/></a>
								<div class="col-cnt">
									<p>Get LGM Status Only $10.00 This helps us keep our server.</p>
								</div>
								<a href="last_upgrade_donate_gm3.php" class="view">Buy It Now It's Instant!</a>
							</div>
							<div class="cl">&nbsp;</div>
                         </section>
						<!-- end of cols -->
                         <!-- testimonial -->
						<section class="testimonial">
							<h2>Donation For LGM Status!</h2>
							<p><strong>“</strong>Donate now by clicking the donate button below.</p>
                             <!-- The PayPal Donation Button -->
        
      <form action="<?php echo $payPalURL?>" method="post" class="payPalForm">
        
            <input type="hidden" name="cmd" value="_donations" />
            <input type="hidden" name="item_name" value="Donation" />

            <!-- Your PayPal email: -->
            <input type="hidden" name="business" value="<?php echo $myPayPalEmail?>" />

            <!-- PayPal will send an IPN notification to this URL: -->
            <input type="hidden" name="notify_url" value="<?php echo $url.'/ipn3.php'?>" /> 

            <!-- The return page to which the user is navigated after the donations is complete: -->
            <input type="hidden" name="return" value="<?php echo $url.'/thankyou.php'?>" /> 

            <!-- Signifies that the transaction data will be passed to the return page by POST -->
            <input type="hidden" name="rm" value="2" /> 


			

            <input type="hidden" name="no_note" value="1" />
            <input type="hidden" name="cbt" value="Go Back To The Site" />
            <input type="hidden" name="no_shipping" value="1" />
            <input type="hidden" name="lc" value="US" />
            <input type="hidden" name="currency_code" value="USD" />


			
<input type="hidden" name="amount" value="10" />
			

            <input type="hidden" name="bn" value="PP-DonationsBF:btn_donate_LG.gif:NonHostedGuest" />

            <!-- You can change the image of the button: -->
            <input type="image" src="https://www.paypal.com/en_US/i/btn/btn_donate_LG.gif" name="submit" alt="PayPal - The safer, easier way to pay online!" />

          <img alt="" src="https://www.paypal.com/en_US/i/scr/pixel.gif" width="1" height="1" />
        
        </form>
                           
                            <h2>This Is Our Goal To Reach $100.00 Each Month!</h2>
                            <div class="chart" style="background:url('<?php echo $chartURL?>');">
    	                    
                            </div>
    
                            <div class="donations">
    	                    <h3>We have <?php echo $percent?>$ so far this month!</h3>
                            </div>
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
if($_SESSION["security"] == 3)
{

?>

			<!-- main -->
			<div class="main">
				<span class="shadow-top"></span>
				<!-- shell -->
				<div class="shell">
					<div class="container">
					
                        <!-- testimonial -->
						<section class="testimonial">
							<h2>Final Fantasy XI Private Server!</h2>
							<p><strong>“</strong>Thank You So Much For Being A LGM On Our Server! In Time Will Get This To Do Much More For You.</p>
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
if($_SESSION["security"] == 0)
{
	?>
    
  <!-- main -->
			<div class="main">
				<span class="shadow-top"></span>
				<!-- shell -->
				<div class="shell">
					<div class="container">
					

						
						
						<!-- cols -->
						<section class="cols">
							
                           
								 <div class="col">
								<h3>Donate For GM</h3>
								<a href="donate_gm1.php"><img src="css/images/cols-img.png" alt="" class="alignleft"/></a>
								<div class="col-cnt">
									<p>Get GM Status Only $5.00 This helps us keep our server.</p>
								</div>
								<a href="donate_gm1.php" class="view">Buy It Now It's Instant!</a>
							</div>
							<div class="col">
								<h3>Donate For SGM</h3>
								<a href="donate_gm2.php"><img src="css/images/cols-img2.png" alt="" class="alignleft"/></a>
								<div class="col-cnt">
									<p>Get GM Status Only $10.00 This helps us keep our server.</p>
								</div>
								<a href="donate_gm2.php" class="view">Buy It Now It's Instant!</a>
							</div>
							<div class="col">
								<h3>Donate For LGM</h3>
								<a href="donate_gm3.php"><img src="css/images/cols-img3.png" alt="" class="alignleft"/></a>
								<div class="col-cnt">
									<p>Get GM Status Only $20.00 This helps us keep our server.</p>
								</div>
								<a href="donate_gm3.php" class="view">Buy It Now It's Instant!</a>
							</div>
							<div class="cl">&nbsp;</div>
                            
							
							
                            
						</section>
						<!-- end of cols -->
                         <!-- testimonial -->
						<section class="testimonial">
							<h2>Donation For GM Status!</h2>
							<p><strong>“</strong>Donate now by clicking the donate button below.</p>
                             <!-- The PayPal Donation Button -->
        
      <form action="<?php echo $payPalURL?>" method="post" class="payPalForm">
        
            <input type="hidden" name="cmd" value="_donations" />
            <input type="hidden" name="item_name" value="Donation" />

            <!-- Your PayPal email: -->
            <input type="hidden" name="business" value="<?php echo $myPayPalEmail?>" />

            <!-- PayPal will send an IPN notification to this URL: -->
            <input type="hidden" name="notify_url" value="<?php echo $url.'/ipn1.php'?>" /> 

            <!-- The return page to which the user is navigated after the donations is complete: -->
            <input type="hidden" name="return" value="<?php echo $url.'/thankyou.php'?>" /> 

            <!-- Signifies that the transaction data will be passed to the return page by POST -->
            <input type="hidden" name="rm" value="2" /> 


			

            <input type="hidden" name="no_note" value="1" />
            <input type="hidden" name="cbt" value="Go Back To The Site" />
            <input type="hidden" name="no_shipping" value="1" />
            <input type="hidden" name="lc" value="US" />
            <input type="hidden" name="currency_code" value="USD" />


			
<input type="hidden" name="amount" value="5" />
			

            <input type="hidden" name="bn" value="PP-DonationsBF:btn_donate_LG.gif:NonHostedGuest" />

            <!-- You can change the image of the button: -->
            <input type="image" src="https://www.paypal.com/en_US/i/btn/btn_donate_LG.gif" name="submit" alt="PayPal - The safer, easier way to pay online!" />

          <img alt="" src="https://www.paypal.com/en_US/i/scr/pixel.gif" width="1" height="1" />
        
        </form>
                            <h2>This Is Our Goal To Reach $100.00 Each Month!</h2>
                            <div class="chart" style="background:url('<?php echo $chartURL?>');">
    	                    
                            </div>
    
                            <div class="donations">
    	                    <h3>We have <?php echo $percent?>$ so far this month!</h3>
                            </div>
						</section>
						<!-- testimonial -->
					</div>
				<!-- end of shell -->
				</div>

				<!-- end of container -->
			</div>
			<!-- end of main -->
		</div>	

<!---END HTML CODE --->
	<?php 
}
		?>

<!---END HTML CODE --->
 <?php 
}
else 
{ 
  ?>
<!---START HTML CODE --->


<!-- main -->
			<div class="main">
				<span class="shadow-top"></span>
				<!-- shell -->
				<div class="shell">
					<div class="container">
					
                        <!-- testimonial -->
						<section class="testimonial">
							<h2>Final Fantasy XI Private Server!</h2>
							<p><strong>“</strong>Sorry but your not login to view this page.</p>
						</section>
						<!-- testimonial -->
					</div>
				<!-- end of shell -->
				</div>
				<!-- end of container -->
			</div>
			<!-- end of main -->
		</div>	




<!---END HTML CODE --->
  <?php
 
} 

 include "footer.php";

?>




    
    
        
       

  
    
   
    
    
    
    
  
