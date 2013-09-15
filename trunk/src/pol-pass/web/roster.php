<?php

echo '
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
	<META HTTP-EQUIV="PRAGMA" CONTENT="NO-CACHE">
    <title>DSP Online Roster</title>
<link rel="stylesheet" href="roster.css" type="text/css" />
    <script type="text/javascript" src="http://code.jquery.com/jquery-latest.pack.js"></script>
    <script type="text/javascript" src="include/pagebuild2.js"></script>
  </head>
  <body onload="loadStartPage()">

  <div id="banner">
  <image src="images/logo.png" alt="DSP Logo" title="DSP Logo">
  </div>
	<div id="MainFrame">
		<div id="Header">
		  <b><h1>Who\'s online:</h1></b>
		</div>
		<div id="Content">
			<div  id="PlayerList"></div>
		</div>
		<div id="Footer">
			
		</div>
	</div>
  </body>
</html>';
?>