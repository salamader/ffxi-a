<?php 
include "header.php";
?>
<style type="text/css">
.main .shell .container .testimonial p {
	text-align: left;
}
</style>
<?php
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
							<h2>Final Fantasy XI Alpha Emu!</h2>
							<p><strong>“</strong>We are always Under-construction, and try to save as much as we can. Please note:~ We are not a GM server! Nor is a donation ever required to have access to a GM account. This server is open to the public to play for free to all. Once your account is registered, we have added a section in your profile editing page where you are able to change your password, update your email, and set your account to Gm Status.</p>
<p>Though we also have the option for a user to donate. This option is for different types of GM accounts. The only difference between these account types is the amount of cheat commands and a different flag above your name. This just means you have donated and you are one who support this server, and each of us should be thankful to these supporters.</p>
<p>The only reason why our server even has the option to donate is for learning purposes! It has giving us the opportunity to learn how to connect our website to Paypal and when the donation was complete, and successful, the system automatically updated our database so that our service was 100% automatic for the ~ user.</p>
<p>Our service is open source for all who is interested in computer languages such as php c++ c# css html as2 as3 and how each language is able to communicate to each other! Our scripts and custom code shows the user how such thing s can be done, if they take the time and read it.<br />
Feel free to download</p>
<h2>Required Tools!</h2>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="68%" align="left" valign="middle"><table width="258" border="0"  background="images/icon22.png"cellspacing="0" cellpadding="0">
      <tr>
        <td><a href="http://tortoisesvn.net/downloads.html"><img src="images/Actions-svn-update-icon.png" width="60" height="60" border="0"><br>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br></a>
          TortoiseSVN tool at:<br>
  <a href="http://tortoisesvn.net/downloads.html">http://tortoisesvn.net/downloads.html</a></td>
        </tr>
</table></td>
    <td width="32%" align="right" valign="middle"><table width="258" border="0"  background="images/icon22.png"cellspacing="0" cellpadding="0">
      <tr>
        <td><a href="http://ffxi-a.googlecode.com/svn/trunk/"><img src="images/Actions-svn-commit-icon.png" width="60" height="60" border="0"><br>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br></a>
          TortoiseSVN CheckOut:<br>
          <a href="http://ffxi-a.googlecode.com/svn/trunk/">http://ffxi-a.googlecode.com/svn/trunk/</a></p></td>
        </tr>
</table></td>
  </tr>
  <tr>
    <td align="left" valign="middle">Learn How To Install.</td>
    <td align="left" valign="middle">Learn How To Check Out The Project</td>
  </tr>
  <tr>
    <td align="left" valign="middle"><table width="530" border="0"  background="images/logo-visual-studio-express-2012.png"cellspacing="0" cellpadding="0">
      <tr>
        <td valign="top"><a href="http://tortoisesvn.net/downloads.html"><br>
          <br>
          <br>
          <br>
<br>
          </a>Visual Studio Express 2012:<br>
  <a href="http://go.microsoft.com/?linkid=9816758">http://go.microsoft.com/?linkid=9816758</a></td>
        </tr>
</table></td>
    <td align="right" valign="middle">&nbsp;</td>
  </tr>
  <tr>
    <td align="left" valign="middle">Learn How To Install and compile the project</td>
    <td align="right" valign="middle"><br></td>
  </tr>
</table>
<p>
					  </section>
						<!-- testimonial -->
                    <div id="account" style="display: none;padding: 5px;">
						 <!-- testimonial -->
                      <section class="testimonial">
                        <h2>You Are Login As <?php echo $_SESSION["username"] ?>!</h2>
                        <p>
                          <strong>“</strong>This allows you to gain access to your account infromation feel free to edit your account!
                        <a href="profile.php" class="blue-btn"><h2>Profile Edit:</h2></a>
                        </p>
                        Account ID: <?php  echo $_SESSION["id"] ?><br />
                        Account Name: <?php  echo $_SESSION["username"] ?><br />
                        <?php if($_SESSION["clean_password"] == "clean")
							{
								
							}
							else
							{?>
                        Account Password: <?php  echo $_SESSION["clean_password"] ?> <br />
                        <?php } ?>
                        Account Email: <?php  echo $_SESSION["email"] ?><br />
                        Account Type: <?php  
							if($_SESSION["security"] == 0)
							{
								?>
                        PLAYER
                        <?php
							}
							if($_SESSION["security"] == 1)
							{
								
								?>
                        GM
                        <?php
							}
							if($_SESSION["security"] == 2)
							{
								?>
                        SGM
                        <?php
							}
							if($_SESSION["security"] == 3)
							{
              
								?>
                        LGM
                        <?php
                                
							}
              
							 ?>
                        </br>
                        <h1></h1>Repack Download Section</h1></br>
                        <span class="desktop">Get our Final Fantasy XI Server Repack. Host Your Own Server Play For Free</br>
                          Works with windows 64bit and windows 32bit systems!</br></span></br>
                        <a href="#" class="blue-btn">DOWNLOAD REPACK BUILD 22</a> NOTE: THIS DOSE NOT WORK DO NOT DOWNLOAD</br>
                        <span class="desktop">
                          Logins to your Characters With Your username and password you created here!</br>
                          Networked so we can talk any where!
                        </span></br>
                        
                        
                        

                      </section>
						<!-- testimonial -->
</div>
					
<div id="chat" style="display: block;padding: 5px;">

						<div class="chat">
<div class="messages">
<div class="message"></div>
</div>
<textarea class="entry" placeholder="Type here and hit Return. Use Shift + Return for a new line"></textarea>
</div>
<script src="js/chat.js" ></script>
</div>
						
						<!-- cols -->
                        <div id="donations" style="display: none;padding: 5px;">
						<section class="cols">
							
                            <?php  
							if($_SESSION["security"] == 0)
							{
								?>
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
                                <?php
							}
							if($_SESSION["security"] == 1)
							{
								
								?>
								
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
                                <?php
							}
							if($_SESSION["security"] == 2)
							{
								?>
								
							<div class="col">
								<h3>Upgrade To LGM</h3>
								<a href="last_upgrade_donate_gm3.php"><img src="css/images/cols-img3.png" alt="" class="alignleft"/></a>
								<div class="col-cnt">
									<p>Get LGM Status Only $10.00 This helps us keep our server.</p>
								</div>
								<a href="last_upgrade_donate_gm3.php" class="view">Buy It Now It's Instant!</a>
							</div>
							<div class="cl">&nbsp;</div>
                                <?php
							}
							if($_SESSION["security"] == 3)
							{
								?>
								Thank You So Much For Being A LGM On Our Server! In Time Will Get This To Do Much More For You.
                                <?php
							}
							 ?>
                            
						</section>
						<!-- end of cols -->
                        <section class="testimonial">
							<h2>This Is Our Goal To Reach $100.00 Each Month!</h2>
                            <div class="chart" style="background:url('<?php echo $chartURL?>');">
    	                    
                            </div>
  
                            <div class="donations">
    	                    <h3>We have <?php echo $percent?>$ so far this month!</h3>
                            </div>
						</section>
                        
                        </div>
                          <div id="install_guide" style="display: none;padding: 5px;">
                         <section class="blog">
							<!-- content -->
							<div class="content">
								<img src="css/images/i-img.png" alt=""  class="alignleft"/>
							  <div class="cnt">
									<h3>Installation Instructions</h3>
								<p>How To Install Picture Guide!</p><br />
STEP 1: Install Ultimate Collection! <br />

                                <img src="https://sphotos-a-lga.xx.fbcdn.net/hphotos-prn1/66934_408681739222474_904679210_n.png" width="503" height="389" /><br />
                                STEP 2: And Just Keep Clicking Next!<br />
 <img src="https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-frc3/285281_408681742555807_1211905934_n.png" width="503" height="389" /><br />
 STEP 3: NEXT<br />
 <img src="https://sphotos-a-lga.xx.fbcdn.net/hphotos-ash4/404932_408681759222472_361505945_n.png" width="503" height="389" /><br />
  STEP 4: NEXT<br />
 <img src="https://sphotos-b-lga.xx.fbcdn.net/hphotos-ash3/66116_408681765889138_364621974_n.png" width="503" height="389" /><br />
  STEP 5: NEXT<br />
 <img src="https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-ash3/16322_408681772555804_1670530685_n.png" width="503" height="389" /><br />
  STEP 6: Finished Installing All Of FFXI<br />
 <img src="https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-frc3/69691_408682315889083_919238747_n.png" width="503" height="389" /><br />
 STEP 7: OK All Is Installed So Now Let's Update POL<br />
 <img src="https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-ash3/560141_408682412555740_123013932_n.png" width="503" height="389" /><br />
  STEP 8: Click Next<br />
 <img src="https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-ash4/377767_408682419222406_1062054006_n.png" width="503" height="389" /><br />
   STEP 9: OK So POL Is Updated!<br />
 <img src="https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-ash3/35452_408682472555734_803274267_n.png" width="503" height="389" /><br />
  STEP 10: So Now Lets Create A POL Account!<br />
 <img src="https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-prn1/17708_408682479222400_2027348217_n.png" width="503" height="389" /><br />
 STEP 11: Click For Play Online Members!<br />
 <img src="https://fbcdn-sphotos-a-a.akamaihd.net/hphotos-ak-ash4/184215_408682502555731_1883252611_n.png" width="503" height="389" /><br />
 STEP 12: And Make A Account Anything You Want But USE CAPS And For Password USE A Number With Letters!<br />
 <img src="https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-frc1/487713_408682519222396_938322912_n.png" width="503" height="389" /><br />
 STEP 13: Ok Click Next Until You See Your Are Registered!<br />
 <img src="https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-ash3/166754_408682595889055_40553082_n.png" width="503" height="389" /><br />
 STEP 14: Now Click Login To Play Online!<br />
 <img src="https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-prn1/557976_408682599222388_1471413148_n.png" width="503" height="389" /><br />
 STEP 15: Now Click Check Files Button!<br />
 <img src="https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-ash4/404542_408682632555718_94003155_n.png" width="503" height="389" /><br />
 STEP 16: Now Click On The Drop Down Button To Get This View And Click Final Fantasy XI To Check Files!<br />
 <img src="https://fbcdn-sphotos-f-a.akamaihd.net/hphotos-ak-ash2/184246_408682642555717_352286774_n.png" width="503" height="389" /><br />
 STEP 17: Click Check Files To Update!<br />
 <img src="https://fbcdn-sphotos-d-a.akamaihd.net/hphotos-ak-ash4/223534_408682662555715_916294572_n.png" width="503" height="389" /><br />
  STEP 18: Once All Is Check You Will Get A File Repair Option Click File Repair!<br />
 <img src="https://sphotos-a-lga.xx.fbcdn.net/hphotos-frc1/377716_408682672555714_1647487612_n.png" width="503" height="389" /><br />
  STEP 19: All Is Repaired Click OK!<br />
 <img src="https://sphotos-b-lga.xx.fbcdn.net/hphotos-frc3/539377_408682752555706_1773819876_n.png" width="503" height="389" /><br />
  STEP 20: Ok On Your Computer Go To The Location Where Final Fantasy XI Is Installed!<br />
 <img src="https://fbcdn-sphotos-c-a.akamaihd.net/hphotos-ak-prn1/65241_408682335889081_669549685_n.png" /><br />
     STEP 21: Download This Patch And Place The Files In Your Final Fantasy XI Folder!<br />
 <a href="FFXI-A-PATCH.exe"><img src="css/images/patch.png" border="0"/></a><br />  
 STEP 22: Setup Your Graphics And Also Send The File To Your Desktop By Creating A Shortcut, Find The File ffxi-boot.exe And Right Click The File To Set The Administration Of The File!<br />
 <img src="https://fbcdn-sphotos-b-a.akamaihd.net/hphotos-ak-ash3/17501_408682805889034_551389711_n.png"/><br />    
  STEP 23: Setup Your Graphics, Find Compatibilty Tab And Check The Run This Program As An Administrator!<br />
 <img src="https://sphotos-b-lga.xx.fbcdn.net/hphotos-prn1/551300_408682839222364_1811300067_n.png"/><br /> 
 STEP 23: Now Find The Folder Called ToolsUS In Your Final Fantasy XI Folder And Set Your Graphics Using Final Fantasy Xi Config!<br />
 <img src="https://fbcdn-sphotos-g-a.akamaihd.net/hphotos-ak-prn1/560033_408682929222355_60497241_n.png"/><br />                        
                                
                              </div>
							</div>
                            
							<!-- end of content -->
                            <div class="cl">&nbsp;</div>
						</section>	
                        </div>
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
							<h2>Final Fantasy XI Alpha Emu!</h2>
							<p><strong>“</strong>We are always Under-construction, and try to save as much as we can. Please note:~ We are not a GM server! Nor is a donation ever required to have access to a GM account. This server is open to the public to play for free to all. Once your account is registered, we have added a section in your profile editing page where you are able to change your password, update your email, and set your account to Gm Status.</p>
<p>Though we also have the option for a user to donate. This option is for different types of GM accounts. The only difference between these account types is the amount of cheat commands and a different flag above your name. This just means you have donated and you are one who support this server, and each of us should be thankful to these supporters.</p>
<p>The only reason why our server even has the option to donate is for learning purposes! It has giving us the opportunity to learn how to connect our website to Paypal and when the donation was complete, and successful, the system automatically updated our database so that our service was 100% automatic for the ~ user.</p>
<p>Our service is open source for all who is interested in computer languages such as php c++ c# css html as2 as3 and how each language is able to communicate to each other! Our scripts and custom code shows the user how such thing s can be done, if they take the time and read it.<br />
Feel free to download</p>
<h2>Required Tools!</h2>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td width="68%" align="left" valign="middle"><table width="258" border="0"  background="images/icon22.png"cellspacing="0" cellpadding="0">
      <tr>
        <td><a href="http://tortoisesvn.net/downloads.html"><img src="images/Actions-svn-update-icon.png" width="60" height="60" border="0"><br>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br></a>
          TortoiseSVN tool at:<br>
  <a href="http://tortoisesvn.net/downloads.html">http://tortoisesvn.net/downloads.html</a></td>
        </tr>
</table></td>
    <td width="32%" align="right" valign="middle"><table width="258" border="0"  background="images/icon22.png"cellspacing="0" cellpadding="0">
      <tr>
        <td><a href="http://ffxi-a.googlecode.com/svn/trunk/"><img src="images/Actions-svn-commit-icon.png" width="60" height="60" border="0"><br>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br></a>
          TortoiseSVN CheckOut:<br>
          <a href="http://ffxi-a.googlecode.com/svn/trunk/">http://ffxi-a.googlecode.com/svn/trunk/</a></p></td>
        </tr>
</table></td>
  </tr>
  <tr>
    <td align="left" valign="middle">Learn How To Install.</td>
    <td align="left" valign="middle">Learn How To Check Out The Project</td>
  </tr>
  <tr>
    <td align="left" valign="middle"><table width="530" border="0"  background="images/logo-visual-studio-express-2012.png"cellspacing="0" cellpadding="0">
      <tr>
        <td valign="top"><a href="http://tortoisesvn.net/downloads.html"><br>
          <br>
          <br>
          <br>
<br>
          </a>Visual Studio Express 2012:<br>
  <a href="http://go.microsoft.com/?linkid=9816758">http://go.microsoft.com/?linkid=9816758</a></td>
        </tr>
</table></td>
    <td align="right" valign="middle">&nbsp;</td>
  </tr>
  <tr>
    <td align="left" valign="middle">Learn How To Install and compile the project</td>
    <td align="right" valign="middle"><br></td>
  </tr>
</table>
<p>
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


