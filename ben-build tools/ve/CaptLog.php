<html>
<head>
<?php include ('../tracking.php') ?>

<title>The Velvet Elvis Captain's Log</title>
<meta name=description content="About the Sailing Vessel Velvet Elvis">
<meta name=keywords content="Velvet Elvis, Sailboat, Lake Ponchatrain, Rhodes22 Ben Schultz, Baton Rouge, LA">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="PUBLIC">
<link rel="stylesheet" href="https://theskinnyonbenny.com/style.css" type="text/css" media="screen" />
<script language="javascript" src="https://theskinnyonbenny.com/menu.js"></script>
<style type="text/css" media="screen">
	body { background: url("https://theskinnyonbenny.com/blog2/wp-content/themes/ben/images/bgcolor.jpg"); }
	#page { background: url("https://theskinnyonbenny.com/blog2/wp-content/themes/ben/images/bg.jpg") repeat-y top; border: none; }
	#header { background: url("https://theskinnyonbenny.com/img/headers/header-ve.jpg") no-repeat bottom center; }
	#footer { background: url("https://theskinnyonbenny.com/blog2/wp-content/themes/ben/images/footer.jpg") no-repeat bottom; border: none;}
	#header 	{ margin: 0 !important; margin: 0 0 0 1px; padding: 1px; height: 198px; width: 758px; }
	#headerimg 	{ margin: 7px 9px 0; height: 192px; width: 740px; }
</style>
</head>
<body>

<div class="topleft"><img src="https://theskinnyonbenny.com/img/BenPurpleGold.JPG"></div>
<div class="sb2"><?php include("/home/users/web/b1051/sl.theskinn/public_html/menu2.php"); ?></div>

<div id="page">
	<div id="header">
		<div id="headerimg"></div>
	</div>

	<div id="content" class="widecolumn">

			<img src="/img/ve/wheel1.jpg" align="left">

			This is a log of all of my voyages on the Beneteau Oceanis 41, <i>Velvet Elvis</i>.  I didn't keep up with this log very well for the Rhodes 22 Velvet Elvis, but the few entries I notched are still alive and well <a href="CaptLog2.php">over here</a>.
			<p>&nbsp;</p><p>&nbsp;</p><p>&nbsp;</p>
			<table border="1" cellpadding="5" width="92%" align="center" >
			<tr><td style="font-weight:bold;" align="center">Date</td><td style="font-weight:bold;" align="center">Route</td><td style="font-weight:bold;" align="center">Conditions</td><td style="font-weight:bold;" align="center">Crew</td></tr>

			<?php
			ini_set ('display_errors',1);
	$db_connection = mysql_connect ('162.209.78.149', 'theskinn_user', 'dN)h~H5AzrzLsT552d37880#9305') or die (mysql_error());
	$db_select = mysql_select_db ('sites_theskinny') or die (mysql_error());

			$sqlList = mysql_query ("SELECT `Date`, `Route`, `Conditions`, `Crew` FROM `tblCaptainsLog` where BoatID = 2 order by `Date` desc");

			$htext ='';
			while ($row = mysql_fetch_array ($sqlList)){
				$htext = $htext.'<tr><td style="font-size:9px;">'.$row[Date].'</td><td style="font-size:9px;">'.$row[Route].'</td><td style="font-size:9px;">'.$row[Conditions].'</td><td style="font-size:9px;">'.$row[Crew].'</td></tr>';
			}
			$htext = str_replace ("\n", "<br>", $htext);
			print $htext;

			?>

		</table>

	</div>

	<?php include("/home/users/web/b1051/sl.theskinn/public_html/indexFooter.php");	?>

</div>



	</div>
</body>
</html>
