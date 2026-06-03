<?php
include ('../includes/gChart.php');

$Data = array (
	'Houston' => array(
					'dataDate' => '4/16/2011',
					'mentions' => 4360,
					'population' => 2099451,
					'metroPopulation' => 6108060,
					'tidbit' => 'The number of mentions was off the map until I remembered to exclude "Whitney."'
				),
	'Baton Rouge' => array(
					'dataDate' => '4/16/2011',
					'mentions' => 612,
					'population' => 229553,
					'metroPopulation' => 802484,
					'tidbit' => ''
				),
	'New Orleans' => array(
					'dataDate' => '4/16/2011',
					'mentions' => 5030,
					'population' => 343829,
					'metroPopulation' => 1235650,
					'tidbit' => ''
				),

	'Natchitoches' => array(
					'dataDate' => '4/16/2011',
					'mentions' => 3,
					'population' => 17865,
					'metroPopulation' => 17865,
					'tidbit' => 'Wikipedia doesn\'t have a seperate metro area population mentioned.  Also, the three results that show up are all the same song.  That song is not Tab Benoit\'s "When a Cajun Man Gets the Blues," which is the only song I know that mentions Natchitoches.'	
				),
	'San Francisco' => array(
					'dataDate' => '4/16/2011',
					'mentions' => 2060,
					'population' => 805235,
					'metroPopulation' => 4335391,
					'tidbit' => 'The number of mentions seems awfully low to me.'	
				),
	'Nashville' => array(
					'dataDate' => '4/16/2011',
					'mentions' => 2510,
					'population' => 626681,
					'metroPopulation' => 1670891,
					'tidbit' => 'One of the first results was a song called "Nashville Pussy."  I\'m not familar with that particular number, but I\'ve made a mental note to check it out later.'	
				),
	'Detriot' => array(
					'dataDate' => '4/16/2011',
					'mentions' => 3280,
					'population' => 3863924,
					'metroPopulation' => 4296250,
					'tidbit' => 'I would have thought that Motown would have more mentions than this.'	
				),
	'Orlando' => array(
					'dataDate' => '4/16/2011',
					'mentions' => 559,
					'population' => 238300,
					'metroPopulation' => 2082628,
					'tidbit' => 'Is it really true that 80% of the city lives outside of the city proper?.'	
				),
	'Miami' => array(
					'dataDate' => '4/16/2011',
					'mentions' => 1710,
					'population' => 399457,
					'metroPopulation' => 5547051,
					'tidbit' => 'Had to also exclude "Miami Sound Machine."'	
				),
	'Dallas' => array(
					'dataDate' => '4/16/2011',
					'mentions' => 2940,
					'population' => 1197816,
					'metroPopulation' => 6477315,
					'tidbit' => ''	
				),
	'Seattle' => array(
					'dataDate' => '4/16/2011',
					'mentions' => 1140,
					'population' => 608660,
					'metroPopulation' => 3407848,
					'tidbit' => 'Thought its musical heritage might cause their number of mentions to be high, but I think that\'s balanced out by how hard it is to rhyme.'	
				),
	'Portland' => array(
					'dataDate' => '4/16/2011',
					'mentions' => 491,
					'population' => 583776,
					'metroPopulation' => 2226009,
					'tidbit' => 'I could tell that some of the song mentions were Portland, Maine, but I\'m just going to let that slide, since the number is so pitiful for a city that big and that cool.'	
				),
	'Columbus' => array(
					'dataDate' => '4/16/2011',
					'mentions' => 1010,
					'population' => 787033,
					'metroPopulation' => 1773120,
					'tidbit' => 'Tried to think of the most common city name, so the results would be really skewed.  Population figure is for the OH version.'	
				),
	'Indianapolis' => array(
					'dataDate' => '4/16/2011',
					'mentions' => 130,
					'population' => 829718,
					'metroPopulation' => 1834672,
					'tidbit' => 'For this one, I was trying to think of the most difficult big city name to rhyme.'	
				),
	'Starkville' => array(
					'dataDate' => '4/16/2011',
					'mentions' => 7,
					'population' => 23888,
					'metroPopulation' => 23888,
					'tidbit' => 'For this one, I was trying to think of the most difficult big city name to rhyme.'	
				),
	'Gainesville' => array(
					'dataDate' => '4/16/2011',
					'mentions' => 58,
					'population' => 114375,
					'metroPopulation' => 258555,
					'tidbit' => ''	
				),
	'New York' => array(
					'dataDate' => '4/16/2011',
					'mentions' => 19500,
					'population' => 8175133,
					'metroPopulation' => 18897109,
					'tidbit' => ''	
				),
	'Memphis' => array(
					'dataDate' => '4/19/2011',
					'mentions' => 6740,
					'population' => 646889,
					'metroPopulation' => 1280533,
					'tidbit' => 'Memphis was a huge oversight in my original list.  They blow away everyone else, which really isn\'t a surprise.'	
				)


	);

$height= 580;  //in pixels
$width= 425;




/*  Build Charts  */
ksort($Data);
$count = count($Data);

foreach ($Data as $key => $Value){
	$City[] = $key;
	$Mentions[] = $Value['mentions'];
	$Ratio[] = ($Value['metroPopulation'] == 0) ? 0 : $Value['mentions'] / $Value['metroPopulation'] * 10000;
	$t = ($Value['tidbit'] == '') ? '' : '<img src="/img/tidbit.gif" class="alignright" alt="more info (hover)" style="height:1em;">';
	$Line[] = '<tr><td class="label"><span title="'.$Value['tidbit'].'">'.$key.$t.'</span></td><td><span title="'.$Value['dataDate'].'">'.$Value['mentions'].'</span></td><td>'.$Value['population'].'</td><td>'.$Value['metroPopulation'].'</td><td>'.round($Value['mentions']*1000/$Value['population'], 3).'</td><td>'.round ($Value['mentions']*10000/$Value['metroPopulation'], 3).'</td></tr>';
}
rsort ($City);

/* Chart # of mentions */
$barChart = new gBarChart($width,$height,'g','h');
$barChart->addDataSet($Mentions);
$barChart->setDataRange(0, 6800);
$barChart->setColors(array("ff3344"));
$barChart->setVisibleAxes(array('x','y'));
$barChart->addAxisLabel(1,$City);
$barChart->addAxisRange(0, 0, 6500);
$barChart->setGradientFill('c',0,array('FFE7C6',0,'76A4FB',1));


/* Chart mentions/population   */
$barChart2 = new gBarChart($width,$height,'g','h');
$barChart2->addDataSet($Ratio);
$barChart2->setDataRange(0, 55);
$barChart2->setColors(array("ff3344"));
$barChart2->setVisibleAxes(array('x','y'));
$barChart2->addAxisLabel(1,$City);
$barChart2->addAxisRange(0, 0, 45);
$barChart2->setGradientFill('c',0,array('FFE7C6',0,'76A4FB',1));

?>

<html>
<head>
<?php include ('../tracking.php') ?>

<title>How much are they singing about your city?</title>
<meta name=description content="Shelly Williams, Seton Hall, NJ">
<meta name=keywords content="Shelly Williams, Seton Hall, NJ, Baton Rouge">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="PUBLIC">
<link rel="stylesheet" href="http://theskinnyonbenny.com/style.css" type="text/css" media="screen" />
<link rel="shortcut icon" href="/img/headers/favicon.ico" type="image/x-icon" />
<script language="javascript" src="http://theskinnyonbenny.com/menu.js"></script>
<style type="text/css" media="screen">
	body { background: url("http://theskinnyonbenny.com/blog2/wp-content/themes/ben/images/bgcolor.jpg"); }
	#page { background: url("http://theskinnyonbenny.com/blog2/wp-content/themes/ben/images/bg.jpg") repeat-y top; border: none; }
	#header { background: url("http://theskinnyonbenny.com/img/headers/header-theskinnyonbenny.jpg") no-repeat bottom center; }
	#footer { background: url("http://theskinnyonbenny.com/blog2/wp-content/themes/ben/images/footer.jpg") no-repeat bottom; border: none;}
	#header 	{ margin: 0 !important; margin: 0 0 0 1px; padding: 1px; height: 198px; width: 758px; }
	#headerimg 	{ margin: 7px 9px 0; height: 192px; width: 740px; }

	#content img {margin-top: 20px; margin-bottom:20px;}
	#content table {border:1px solid black; margin: 10px;}
	#content th {font-size:75%; text-align:right; vertical-align:bottom; padding-left:10px;}
	#content td {border-top:1px solid gray; padding:6px 2px 1px 3px; text-align:right;}
	#content .label {font-weight:bold; text-align:left;}
</style>
</head>
<body>

<div class="topleft"><img src="http://theskinnyonbenny.com/img/BenPurpleGold.JPG"></div>
<div class="sb2"><?php include("../menu2.php"); ?></div>

<div id="page">
	<div id="header">
		<div id="headerimg"></div>
	</div>

	<div id="content" class="widecolumn">

		<h2>The Question</h2>
		
		<p>Once upon a time, I noticed that it seems like Baton Rouge gets more song mentions than you would think it would.  There's no history of great bands from here, and there's nothing espcially songworthy here.  I suspected that it's because it's on the way to New Orleans, and songwriters might just be passing through as they find they need something to rhyme with "gets the blues."</p>

		<p>But I'm also open to the possibility that it just jumps out at me more because that's where I live.  So I decided to apply some science and find out the answer.</p>

		<p>For a number of cities, I checked the number of google results from lyrics.wikia.com, excluding the hometown.  For example, I searched "site:lyrics.wikia.com Nashville -hometown" to find the number of times "Nashville" appeared in song lyrics.  This wasn't as easy as it sounds.  I had to eliminate "Whitney" from the Houston search and "Miama Sound Machine" from the Miami search.  I don't know how to get results for Austin (lots of last name Austin songwriting credits) or for Phoenix, Boston, or Chicago (how do I eliminate the ones that were just performed by those bands?).</p>

		<h2>Result Set 1</h2>
		
		<p>This first chart plots the number of mentions for each city.  As I expected, Baton Rouge is unusually high.</p>

		<img src="<?php print $barChart->getUrl();  ?>" alt="chart" class="centered" />

		<p class="caption" style="margin-left:8em;">Note:  the number of mentions for New York is so far off the chart (19,500) that it made the rest of the cities look similar in scale.  So understand that it's bar continues to go way off to the right.</p>

		<h2>Result Set 2</h2>
		
		<p>Next, I decided to go a step deeper and figure out the number of mentions per person in the city.  That wasn't as easy as it seems either.  I started with the city population, but then I noticed that Orlando has about the same population as Baton Rouge, and Miami has not much more than that.  So that's clearly not the number that I wanted.  I switched the Metro Area Population.  I used the numbers from Wikipedia, so they could be extremely flawed.</p>  


		<img src="<?php print $barChart2->getUrl();  ?>" alt="chart2" class="centered" />

		<h2>Data</h2>
		<p>Here's the raw information behind the two charts that you see.  If you see something that looks completely wrong, or if you have another city that you would like to see added, let me know (email link to the left), and I'll update this page from time to time.</p>

		<p>The little balloon means that I had some little tidbit of info that struck me as interesting when doing the exercise for that city.  You can hover over the city name to see it.  Also, you can hover over the number of mentions to see the date that I looked up the numbers for that city.</p>

		<table class="centered">
			<tr><th class="label">City</th><th># of Mentions</th><th>Population</th><th>Metro Area Population</th><th>Mentions per 1000 Population</th><th>Mentions per 10,000 in Metro Area</th></tr>

		<?php
			for ($i=0; $i<$count; $i++){
				echo $Line[$i];
			}
		?>

		</table>

	</div>

	<?php include("../indexFooter.php");	?>

</div>
</body>
</html>



		