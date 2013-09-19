<?php 
if (loggedIn()) 
{
?>
<!---START HTML CODE --->


<!-- footer-push -->
		<div id="footer-push"></div>
		<!-- end of footer-push -->
	
	<!-- end of wrapper -->
	<!-- footer -->
	<div  id="footer">
		<span class="shadow-bottom"></span>
		<!-- footer-cols -->
		<div class="footer-cols">
			<!-- shell --><!-- end of shell -->
		</div>
		<!-- end of footer-cols -->
		<div class="footer-bottom">
			<div class="shell">
			  <p class="copy">&copy; Copyright 2012<span>|</span>www.ffxi-a.com. Design by <a href="http://ffxi-a.com" target"_blank">ffxi-a.com</a></p>
			</div>
		</div>
	</div>
	<!-- end of footer -->

<!---END HTML CODE --->

 <?php 
}
else 
{ 
  ?>
<!---START HTML CODE --->

<!-- footer-push -->
		<div id="footer-push"></div>
		<!-- end of footer-push -->
	
	<!-- end of wrapper -->
	<!-- footer -->
	<div  id="footer">
		<span class="shadow-bottom"></span>
		<!-- footer-cols -->
		<div class="footer-cols">
			<!-- shell --><center>
            <a href="#"><img src="http://s10.flagcounter.com/count/TTGL/bg_FFFFFF/txt_000000/border_CCCCCC/columns_8/maxflags_250/viewers_3/labels_1/pageviews_1/flags_1/" alt="Flag Counter" border="0"></a></center><!-- end of shell -->
		</div>
		<!-- end of footer-cols -->
		<div class="footer-bottom">
			<div class="shell">
			  <p class="copy">&copy; Copyright 2012<span>|</span>www.ffxi-a.com. Design by <a href="http://ffxi-a.com" target"_blank">ffxi-a.com</a></p>
			</div>
		</div>
	</div>
	<!-- end of footer -->

<!---END HTML CODE --->
  <?php
 
} 
?>
<script type="text/javascript">
function Install_Guide() 
  {
   if(document.getElementById('install_guide').style.display=='none')
   {
    //THIS IS SHOWING THE DIV TAG 
            div = document.getElementById('install_guide');
            div.style.display = "block";
			div = document.getElementById('donations');
            div.style.display = "none";
			div = document.getElementById('chat');
            div.style.display = "none";
			div = document.getElementById('account');
            div.style.display = "none";
  
  }
   else
   {
    //THIS IS HIDING THE DIV TAG IF YOU CLICK IT TWICE IT OPENS IT SHUTS 
    div = document.getElementById('install_guide');
            div.style.display = "none";
			div = document.getElementById('account');
            div.style.display = "block";
   }
  
  }
function Donations() 
  {
   if(document.getElementById('donations').style.display=='none')
   {
    //THIS IS SHOWING THE DIV TAG 
            div = document.getElementById('donations');
            div.style.display = "block";
			div = document.getElementById('install_guide');
            div.style.display = "none";
			div = document.getElementById('chat');
            div.style.display = "none";
			div = document.getElementById('account');
            div.style.display = "none";
  
  }
   else
   {
    //THIS IS HIDING THE DIV TAG IF YOU CLICK IT TWICE IT OPENS IT SHUTS 
    div = document.getElementById('donations');
            div.style.display = "none";
			div = document.getElementById('account');
            div.style.display = "block";
   }
  
  }
  function Chat() 
  {
   if(document.getElementById('chat').style.display=='none')
   {
    //THIS IS SHOWING THE DIV TAG 
	div = document.getElementById('chat');
            div.style.display = "block";
            div = document.getElementById('donations');
            div.style.display = "none";
			div = document.getElementById('install_guide');
            div.style.display = "none";
			div = document.getElementById('account');
            div.style.display = "none";
  
  }
   else
   {
    //THIS IS HIDING THE DIV TAG IF YOU CLICK IT TWICE IT OPENS IT SHUTS 
    div = document.getElementById('chat');
            div.style.display = "none";
			div = document.getElementById('account');
            div.style.display = "block";
   }
  
  }
  function Account() 
  {
   if(document.getElementById('account').style.display=='none')
   {
    //THIS IS SHOWING THE DIV TAG 
	div = document.getElementById('account');
            div.style.display = "block";
	div = document.getElementById('chat');
            div.style.display = "none";
            div = document.getElementById('donations');
            div.style.display = "none";
			div = document.getElementById('install_guide');
            div.style.display = "none";
  
  }
   else
   {
    //THIS IS HIDING THE DIV TAG IF YOU CLICK IT TWICE IT OPENS IT SHUTS 
    div = document.getElementById('account');
            div.style.display = "none";
			div = document.getElementById('chat');
            div.style.display = "block";
   }
  
  }
 
</script>
</body>
</html>