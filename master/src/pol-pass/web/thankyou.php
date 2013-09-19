<?php 
include "header.php";

if (loggedIn()) 
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
							<h2>Thank you!</h2>
                            <h1>For your support <?php echo $_SESSION["username"] ?> your GM status is now ready to go! </h1>
							<p><strong>“</strong>Your support allowed us to continue running our server and we are very thankful to you <?php echo $_SESSION["username"] ?>.</p>
                            <div class="chart" style="background:url('<?php echo $chartURL?>');">
    	                    <h2>Our Goal Is To Reach $100.00 a Month!</h2>
                            </div>
    
                            <div class="donations">
    	                    <h3><?php echo $percent?>% done</h3>
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
function esc($str)
{
	global $link;
	
	if(ini_get('magic_quotes_gpc'))
			$str = stripslashes($str);
	
	return mysql_real_escape_string(htmlspecialchars(strip_tags($str)),$link);
}

function validateURL($str)
{
	return preg_match('/(http|ftp|https):\/\/[\w\-_]+(\.[\w\-_]+)+([\w\-\.,@?^=%&amp;:\/~\+#]*[\w\-\@?^=%&amp;\/~\+#])?/i',$str);
}
 include "footer.php";

?>
