<?php
session_start(); 
// Fill your PayPal email below.
// This is where you will receive the donations.

$myPayPalEmail = 'clarity-understanding@hotmail.com';


// The paypal URL:
$payPalURL = 'https://www.paypal.com/cgi-bin/webscr';


// Your goal in USD:
$goal = 100;

require ( "connect.php"); 

 
// require the function file
require_once ( "functions.php"); 

 
// default the error variable to empty. 
$_SESSION['error'] = ""; 
 
// declare $sOutput so we do not have to do this on each page. 
$sOutput=""; 
// Demo mode is set - set it to false to enable donations.
// When enabled PayPal is bypassed.

$demoMode = false;

if($demoMode)
{
	$payPalURL = 'demo_mode.php';
}
?>

