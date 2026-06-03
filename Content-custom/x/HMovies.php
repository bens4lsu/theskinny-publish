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


	$sorttext = 'Sort By:  ';
	if ($sortopt == 'RU'){		//Rating Up
		$sqlList = mysql_query ("SELECT m.MovieID, m.Title, m.Rating, m.Comments FROM tblHMovies m order by Rating asc");
		$sorttext = $sorttext.'<a href=HMovies.php?sortopt=RD>Rating (Down)</a>   <a href=HMovies.php?sortopt=DD>Date (Down)</a>   <a href=HMovies.php?sortopt=DU>Date (Up)</a>';
	}
	else if ($sortopt == 'RD'){  //Rating Down
		$sqlList = mysql_query ("SELECT m.MovieID, m.Title, m.Rating, m.Comments FROM tblHMovies m order by Rating desc");
		$sorttext = $sorttext.'<a href=HMovies.php?sortopt=RU>Rating (Up)</a>   <a href=HMovies.php?sortopt=DD>Date (Down)</a>   <a href=HMovies.php?sortopt=DU>Date (Up)</a>';
	}
	else if ($sortopt == 'DU'){  //Date Up
		$sqlList = mysql_query ("SELECT m.MovieID, m.Title, m.Rating, m.Comments FROM tblHMovies m order by DateAdded asc");
		$sorttext = $sorttext.'<a href=HMovies.php?sortopt=RD>Rating (Down)</a>   <a href=HMovies.php?sortopt=RU>Rating (Up)</a>   <a href=HMovies.php?sortopt=DD>Date (Down)</a>';
	}
	else{ 				       //Date Down - default
		$sqlList = mysql_query ("SELECT m.MovieID, m.Title, m.Rating, m.Comments FROM tblHMovies m order by DateAdded desc");
		$sorttext = $sorttext.'<a href=HMovies.php?sortopt=RD>Rating (Down)</a>   <a href=HMovies.php?sortopt=RU>Rating (Up)</a>   <a href=HMovies.php?sortopt=DU>Date (Up)</a>';
	}

	print $sorttext;

	//output the grid
	$out = '<center><table cellpadding = 10><tr><td width=290><b>Title</b></td><td><b>Rating</b></td><td></td></tr>';
	while ($row = mysql_fetch_array ($sqlList)){
		$out = $out.'<tr><td width=290>'.$row[Title].'</td><td>'.$row[Rating].'</td>';
		$query = 'select 1 from tblComments where CommentTypeCode = \'M\' and CommentParentID = '.$row[MovieID];

		$addCommentSet = mysql_query ($query);
		$addCommentCount = mysql_num_rows ($addCommentSet);
		if ($addCommentCount > 0 or strlen($row[Comments]) > 0)
			$out = $out.'<td><a href=\'HMovieDetail.php?movieid='.$row[MovieID].'\'>Comments</a></td>';
		else
			$out = $out.'<td></td>';
		$out = $out.'</tr>';

	}
	$out = $out.'</table></center>';
	print $out;


	?>

	</div>
	<div class="rsb">
		<?php include("/home/users/web/b1051/sl.theskinn/public_html/googlead.php");  ?>
	</div>
</body>
</html>
