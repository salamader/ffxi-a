<?php 
require "config.php";
require "connect.php";

// Determining the URL of the page:
$url = 'http://'.$_SERVER['SERVER_NAME'].dirname($_SERVER["REQUEST_URI"]);

// Fetching the number and the sum of the donations:
list($number,$sum) = mysql_fetch_array(mysql_query("SELECT COUNT(*),SUM(amount) FROM dc_donations"));

// Calculating how many percent of the goal were met:
$percent = round(min(100*($sum/$goal),100));

// Building a URL with Google's Chart API:
$chartURL = 'http://chart.apis.google.com/chart?chf=bg,s,f9faf7&amp;cht=p&amp;chd=t:'.$percent.',-'.(100-$percent).'&amp;chs=200x200&amp;chco=b6dde7&amp;chp=1.57';


if (loggedIn()) 
{
?>
<!---START HTML CODE --->
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=0" />
	<title>FFXI-A</title>
	<link rel="shortcut icon" type="image/x-icon" href="css/images/favicon.ico" />
    
	<link rel="stylesheet" href="/css/style.css" type="text/css" media="all" />
	<link rel="stylesheet" href="/css/flexslider.css" type="text/css" media="all" />
	<link href='http://fonts.googleapis.com/css?family=Ubuntu:400,500,700' rel='stylesheet' type='text/css' />
	
	<script src="js/jquery-1.8.0.min.js" type="text/javascript"></script>
	<!--[if lt IE 9]>
		<script src="js/modernizr.custom.js"></script>
	<![endif]-->
	<script src="/js/jquery.flexslider-min.js" type="text/javascript"></script>
	<script src="/js/functions.js" type="text/javascript"></script>
    
</head>
<body >


<div id="wrapper">
		
		<!-- top-nav -->
		<nav class="top-nav">
			<div class="shell">
				<a href="#" class="nav-btn">HOMEPAGE<span></span></a>
				<span class="top-nav-shadow"></span>
				<ul>
					<li class="active"><span><a href="index.php">Home</a></span></li>
                   
                    <li><span onclick="javascript:Install_Guide();"><a href="#">Installation Guide</a></span></li>
                    <li><span onclick="javascript:Donations();"><a href="#">Donate</a></span></li>
                    <li><span onclick="javascript:Chat();"><a href="#">Live Chat</a></span></li>
          <li>
            <span onclick="javascript:Account();">
              <a href="#">Profile</a>
            </span>
          </li>
					<li><span><a href="login.php?action=logout">Logout</a></span></li>
          
				
				</ul>
			</div>
		</nav>
        <!-- header -->
			<header  id="header">
				<!-- shell -->
				<div class="shell">
					<div class="header-inner">
						<!-- header-cnt -->
						<div class="header-cnt">
							<h1 id="logo"><a href="#">FFXI-A</a></h1>		
							<p>
								<span class="desktop"> Welcome to our simple website. <?php echo $_SESSION["username"]?> We have connected our site to your in game account. So you can upgrade your account to any gm status you would like to have.</span>
							</p>
                            <a href="magnet:?xt=urn:btih:c7c768f005ad29184d13197e9c14e2cca1be764e&dn=FINAL+FANTASY+XI+Ultimate+Collection+-+Abyssea+Edition&tr=udp%3A%2F%2Ftracker.openbittorrent.com%3A80&tr=udp%3A%2F%2Ftracker.publicbt.com%3A80&tr=udp%3A%2F%2Ftracker.istole.it%3A6969&tr=udp%3A%2F%2Ftracker.ccc.de%3A80&tr=udp%3A%2F%2Fopen.demonii.com%3A1337" class="blue-btn">DOWNLOAD FFXI NOW</a>
              <p>
                
                
              </p>
						</div>
						<!-- end of header-cnt -->
						<!-- slider -->
						<div class="slider-holder">
<!------<iframe width="495" height="290" src="//www.youtube.com/embed/ow3-Txvu1pA" frameborder="0" allowfullscreen></iframe> ----->
<iframe width="495" height="290" src="//www.youtube.com/embed/Fh9yQEpKVC0" frameborder="0" allowfullscreen></iframe>
						<!----- 	<div class="flexslider">
								<ul class="slides">


									<li><img src="http://allpopasia.com/wp-content/uploads/2012/08/final-fantasy-xi-online-logo.jpg" alt="" /></li>
								
									<li><img src="http://www.explosion.com/wp-content/uploads/2013/03/41GBo3HlsKL._SL500_SS500_.jpg" alt="" /></li> 

									
								</ul>
							</div>----->
						</div>
						<!-- end of slider -->
						<div class="cl">&nbsp;</div>
					</div>
					<div class="cl">&nbsp;</div>
				</div>
				<!-- end of shell -->	
			</header>
			<!-- end of header -->
<!---END HTML CODE --->
 <?php 
}
else 
{ 
  ?>
<!---START HTML CODE --->
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=0" />
	<title>FFXI-A</title>
	<link rel="shortcut icon" type="image/x-icon" href="css/images/favicon.ico" />
	<link rel="stylesheet" href="/css/style.css" type="text/css" media="all" />
	<link rel="stylesheet" href="/css/flexslider.css" type="text/css" media="all" />
	<link href='http://fonts.googleapis.com/css?family=Ubuntu:400,500,700' rel='stylesheet' type='text/css' />
	<link rel="stylesheet" type="text/css" href="css/style3.css" />
	<link rel="stylesheet" type="text/css" href="css/animate-custom.css" />
	<script src="js/jquery-1.8.0.min.js" type="text/javascript"></script>
	<!--[if lt IE 9]>
		<script src="js/modernizr.custom.js"></script>
	<![endif]-->
	<script src="/js/jquery.flexslider-min.js" type="text/javascript"></script>
	<script src="/js/functions.js" type="text/javascript"></script>
</head>
<body >
<div id="wrapper">
		
		<!-- top-nav -->
		<nav class="top-nav">
			<div class="shell">
				<a href="#" class="nav-btn">HOMEPAGE<span></span></a>
				<span class="top-nav-shadow"></span>
				<ul>
					<li class="active"><span><a href="index.php">Home</a></span></li>
					<li><span><a href="register.php">Register</a></span></li>
          
					<li><span><a href="login.php">Login</a></span></li>
          
				
				</ul>
			</div>
		</nav>
<!-- header -->
			<header  id="header">
       
				
        <!-- shell -->
				<div class="shell">
					<div class="header-inner">
						<!-- header-cnt -->
						<div class="header-cnt">
							<h1 id="logo"><a href="#">FFXI-A</a></h1>		
							<p>
								<span class="desktop"> Welcome to our simple website. Register today to login to our Final Fantasy XI private server.</span>
							</p>
							<a href="magnet:?xt=urn:btih:c7c768f005ad29184d13197e9c14e2cca1be764e&dn=FINAL+FANTASY+XI+Ultimate+Collection+-+Abyssea+Edition&tr=udp%3A%2F%2Ftracker.openbittorrent.com%3A80&tr=udp%3A%2F%2Ftracker.publicbt.com%3A80&tr=udp%3A%2F%2Ftracker.istole.it%3A6969&tr=udp%3A%2F%2Ftracker.ccc.de%3A80&tr=udp%3A%2F%2Fopen.demonii.com%3A1337" class="blue-btn">DOWNLOAD FFXI NOW</a>
              <p>
               
               

              </p>
            </div>
						<!-- end of header-cnt -->
						<!-- slider -->
						<div class="slider-holder">
<iframe width="495" height="290" src="//www.youtube.com/embed/ow3-Txvu1pA" frameborder="0" allowfullscreen></iframe> 
<!------<iframe width="495" height="290" src="//www.youtube.com/embed/Fh9yQEpKVC0" frameborder="0" allowfullscreen></iframe>----->
						<!----- 	<div class="flexslider">
								<ul class="slides">


									<li><img src="http://allpopasia.com/wp-content/uploads/2012/08/final-fantasy-xi-online-logo.jpg" alt="" /></li>
								
									<li><img src="http://www.explosion.com/wp-content/uploads/2013/03/41GBo3HlsKL._SL500_SS500_.jpg" alt="" /></li> 

									
								</ul>
							</div>----->
						</div>
						<!-- end of slider -->
						<div class="cl">&nbsp;</div>
					</div>
					<div class="cl">&nbsp;</div>
				</div>
				<!-- end of shell -->	
			</header>
			<!-- end of header -->
<!---END HTML CODE --->
  <?php
 
} 
?>