<html>
<head>
<?php include ('../tracking.php') ?>

<title>Tyler's Haikus on theskinnyonbenny.com</title>
<meta name=description content="Haikus, Tyler Cummings, Ben Schultz, Baton Rouge, LA ">
<meta name=keywords content="Haikus, Comedy, Funny, Deep Thoughts">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="PUBLIC">
<link rel="stylesheet" href="http://theskinnyonbenny.com/style.css" type="text/css" media="screen" />
<link rel="shortcut icon" href="/img/headers/favicon.ico" type="image/x-icon" />
<script language="javascript" src="http://theskinnyonbenny.com/menu.js"></script>
<style type="text/css" media="screen">
	body { background: url("http://theskinnyonbenny.com/blog2/wp-content/themes/ben/images/bgcolor.jpg"); }
	#page { background: url("http://theskinnyonbenny.com/blog2/wp-content/themes/ben/images/bg.jpg") repeat-y top; border: none; }
	#header { background: url("http://theskinnyonbenny.com/img/headers/header-haikus.jpg") no-repeat bottom center; }
	#footer { background: url("http://theskinnyonbenny.com/blog2/wp-content/themes/ben/images/footer.jpg") no-repeat bottom; border: none;}
	#header 	{ margin: 0 !important; margin: 0 0 0 1px; padding: 1px; height: 198px; width: 758px; }
	#headerimg 	{ margin: 7px 9px 0; height: 192px; width: 740px; }
</style>
</head>
<body>

<div class="topleft"><img src="http://theskinnyonbenny.com/img/tyler.jpg"></div>
<div class="sb2"><?php include("../menu2.php"); ?></div>

<div id="page">
	<div id="header">
		<div id="headerimg"></div>
	</div>

	<div id="content" class="widecolumn">


	<p class="caption"> This content contributed and maintained by <a href="mailto:tylerdrew@gmail.com">Tyler Cummings</a></p><p></p>

	<?php
	ini_set ('display_errors',1);
	$db_connection = mysql_connect ('162.209.78.149', 'theskinn_user', 'dN)h~H5AzrzLsT552d37880#9305') or die (mysql_error());
	$db_select = mysql_select_db ('sites_theskinny') or die (mysql_error());

	$sqlList = mysql_query ("SELECT `HaikuText`, `Title` FROM `tblHaikus` ORDER BY `DateAdded` DESC");

	while ($row = mysql_fetch_array ($sqlList)){
		$htit = '<p style="margin-left:8em;"><b>'.$row[Title].'</b></p>';
		$htext = '<p style="margin-left:10em;">'.$row[HaikuText].'</p><p>&nbsp;</p>';
		$htext = str_replace ("\n", "<br>", $htext);
		print $htit;
		print $htext;
	}



	?>

	</div>


	<?php include("../indexFooter.php");	?>

</div>
</body>
</html>
