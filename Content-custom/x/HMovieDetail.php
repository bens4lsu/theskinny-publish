<html>
<head>
<?php include ('../tracking.php') ?>

<title>Movie Reviews on theskinnyonbenny.com</title>
<meta name=description content="Heather Schultz, Movie Reviews, Ben Schultz, Baton Rouge, LA ">
<meta name=keywords content="Movies, Reviews">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="PUBLIC">
<link rel="stylesheet" type="text/css" href="http://theskinnyonbenny.com/skinnystyle2.css">
<script language="javascript" src="http://theskinnyonbenny.com/menu.js"></script>
</head>
<body>
	<div class="corner"><img border="0" src="/img/heather.jpg" width="178" height="109"></div>
	<div class="banner"><img border="0" src="/img/BannerH.gif" width="617" height="111"></div>
	<div class="sb2"><?php include("/home/users/web/b1051/sl.theskinn/public_html/menu2.php"); ?></div>
	<div class="mb2">

	<p class="caption"> This content contributed and maintained by <a href="mailto:heather@theskinnyonbenny.com">Mrs. theskinnyonbenny</a>.</p><p></p>

	<?php
	ini_set ('display_errors',1);
	$db_connection = mysql_connect ('162.209.78.149', 'theskinn_user', 'dN)h~H5AzrzLsT552d37880#9305') or die (mysql_error());
	$db_select = mysql_select_db ('sites_theskinny') or die (mysql_error());


	$sqlMainData = mysql_query ("SELECT m.MovieID, m.Title, m.Rating, m.Comments FROM tblHMovies m where MovieID =".$movieid);
	$maindata = mysql_fetch_array($sqlMainData);

	$tstr = "SELECT Name, Email, Homepage, Comments, DateAdded FROM tblComments WHERE CommentTypeCode = 'M' and CommentParentID = ".$movieid." ORDER BY DateAdded";
	$sqlList = mysql_query($tstr);

	print '<h1>'.$maindata[Title].'</h1>';
	print '<p>Rating: '.$maindata[Rating].' out of 10</p>';
	if (strlen($maindata[Comments]) > 0){
		print '<p><b>Comments:</b></p>';
		print '<p>'.str_replace ("\n", "<br>", $maindata[Comments]).'</p>';
	}

	while ($row = mysql_fetch_array ($sqlList)){
		print '<p class=mainbox size="-2">Posted by ';
		if (strlen ($row[Homepage]) > 0)
			print '<b><a href='.$row[Homepage].'>'.$row[Name].'</a></b> at <b>'.$row[DateAdded].'</b></p>';
		else if (strlen ($row[Email]) > 0)
			print '<b><a href=mailto:'.$row[Email].'>'.$row[Name].'</a></b> at <b>'.$row[DateAdded].'</b></p>';
		else
			print '<b>'.$row[Name].'</b> at <b>'.$row[DateAdded].'</b></p>';
		print '<p class=mainbox size="-2">'.str_replace ("\n", "<br>", $row[Comments]).'</p>';
	}

	?>

	</div>
	<div class="rsb">
		<?php include("/home/users/web/b1051/sl.theskinn/public_html/googlead.php");  ?>
	</div>
</body>
</html>