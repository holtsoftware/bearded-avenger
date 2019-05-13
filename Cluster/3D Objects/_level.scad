$levelThickness=2;
$levelWidth=88;
$levelLength=180;
$seperation=78.75;

function getWidth() = $levelWidth;
function getThickness() = $levelThickness;
function getLength() = $levelLength;
function piHole() = 3.5;

module levelStandOffHoles()
{
	$x = ($levelWidth/2) - ($seperation/2);
	$offEdge=5;

	#translate([$x,$offEdge,-1]) union()
	{
		cylinder(d=piHole(),h=10);
		translate([$seperation,0,0]) cylinder(d=piHole(),h=10);
		translate([0,($levelLength-($offEdge*2)),0]) cylinder(d=piHole(),h=10);
		translate([$seperation,($levelLength-($offEdge*2)),0]) cylinder(d=piHole(),h=10);
	}
}

module piHoles()
{
	$xOffset=58;
	$yOffset=48;
	cylinder(d=piHole(),h=10);
	translate([$xOffset,0,0]) cylinder(d=piHole(),h=10);
	translate([0,$yOffset,0]) cylinder(d=piHole(),h=10);
	translate([$xOffset,$yOffset,0]) cylinder(d=piHole(),h=10);
}