<?php 
include "header.php"; 

?>

<?php
if (loggedIn()) 
{
$up_id = $_SESSION['id'];  
if ($_POST) {
mkdir("accounts/".$up_id."/", 0700);
//specify folder for file upload
$folder = "accounts/".$up_id."/";
//$folder1 = mkdir("accounts/".$up_id, 0700);
//specify redirect URL


$accept = array('jpg','png','gif','bmp');
$extension = substr($_FILES['file']['name'],strrpos($_FILES['file']['name'],'.')+1);

if(!in_array($extension,$accept)){
  // If the extension is not allowed show an error, else, the file type is valid
  
  $redirect = "upload.php?rejected";
}
else
{
	move_uploaded_file($_FILES["file"]["tmp_name"], "$folder" . md5($_FILES["file"]["name"]));
	$filename = "$folder" . md5($_FILES["file"]["name"]);
	mysql_query("UPDATE accounts SET pic = 'http://www.ffxi-a.com/".$filename."' WHERE id = '".$up_id."'");
	$redirect = "upload.php?success";
}
//

//do whatever else needs to be done (insert information into database, etc...)

//redirect user
header('Location: '.$redirect); die;
}
//

?>


<!--Progress Bar and iframe Styling-->
<link href="style_progress.css" rel="stylesheet" type="text/css" />

<!--Get jQuery-->
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.0/jquery.js" type="text/javascript"></script>

<!--display bar only if file is chosen-->
<script>

$(document).ready(function() { 
//

//show the progress bar only if a file field was clicked
	var show_bar = 0;
    $('input[type="file"]').click(function(){
		show_bar = 1;
    });

//show iframe on form submit
    $("#form1").submit(function(){

		if (show_bar === 1) { 
			$('#upload_frame').show();
			function set () {
				$('#upload_frame').attr('src','upload_frame.php?up_id=<?php echo $up_id; ?>');
			}
			setTimeout(set);
		}
    });
//

});

</script>

</head>

<body>
<h1>Upload your file </h1>

<div>
  <?php if (isset($_GET['success'])) 
  { 
  ?>
  <span class="notice">Your file has been uploaded.</span>
  <?php 
  }
  else
  {
	?>
  <span class="notice">Your file has been rejected.</span>
  <?php   
  }
  ?>
  <form action="" method="post" enctype="multipart/form-data" name="form1" id="form1">
  
    <h2>Choose a picture to upload</h2>

<!--APC hidden field-->
    <input type="hidden" name="APC_UPLOAD_PROGRESS" id="progress_key" value="<?php echo $up_id; ?>"/>
<!---->
     <input name="file" type="file" id="file" accept="image/gif, image/jpeg" />
    

<!--Include the iframe-->
    <br />
    <iframe id="upload_frame" name="upload_frame" frameborder="0" border="0" src="" scrolling="no" scrollbar="no" > </iframe>
    <br />
<!---->

    <input name="Submit" type="submit" id="submit" value="Submit" />
  </form>
  </div>

</body>

</html>
<?php

  
}
else
{
	?>
	<META http-equiv="refresh" content="0;URL=login.php">
    <?php
}
//process the forms and upload the files



include "footer.php"; 
?>
