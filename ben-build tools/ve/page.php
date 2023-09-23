<html>
<head>
<?php include ('../tracking.php') ?>

<title>The Velvet Elvis Page</title>
<meta name="description" content="About the Sailing Vessel Velvet Elvis"/>
<meta name="keywords" content="Velvet Elvis, Sailboat, Lake Ponchatrain, Rhodes22 Ben Schultz, Baton Rouge, LA"/>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
<meta http-equiv="cache-control" content="public"/>
<link rel="stylesheet" href="https://theskinnyonbenny.com/style.css" type="text/css" media="screen"/>
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


		<div class="topleft">
			<img src="https://theskinnyonbenny.com/img/BenPurpleGold.JPG" alt="" />
		</div>
		<div class="sb2">
			<?php include("../menu2.php"); ?>
		</div>
		<div id="page">
			<div id="header">
				<div id="headerimg"></div>
			</div>
			<div class="widecolumn" id="content">
				<?php 
					$fn = $_GET["fn"];
					include $fn; 
				?>
			</div>

			<?php
			  if ($fn != "ve_home.content" && $fn != "veb_home.content")
			     echo "<div style=\"text-align:right;\"><br/><br/><br/><a href=\"/ve/\"><i>Velvet Elvis</i> Home Page</a></div>";

			  include("../indexFooter.php");

			?>
		</div>
	</body>
</html>
