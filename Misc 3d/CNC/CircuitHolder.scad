//$fn=500;

$yOffset=77.5;
$xOffset=75.5;

function getCircuitHolderX() = $xOffset;
function getCircuitHolderY() = $yOffset;

module circuitHole()
{
	difference()
	{
		cylinder(d=8,h=10);
		circuitHoleCenter();
	}
}

module circuitHoleCenter()
{
	translate([0,0,-1]) cylinder(d=5.25,h=11);
}

module circuitHolder()
{
	circuitHole();
	translate([$xOffset,0,0]) circuitHole();
	translate([$xOffset,$yOffset,0]) circuitHole();
	translate([0,$yOffset,0]) circuitHole();
}

module circuitHolderHoles()
{
	circuitHoleCenter();
	translate([$xOffset,0,0]) circuitHoleCenter();
	translate([$xOffset,$yOffset,0]) circuitHoleCenter();
	translate([0,$yOffset,0]) circuitHoleCenter();
}

/*difference()
{
	cube([95,95,0.5]);
	translate([5,5,0]) circuitHolderHoles();
}*/
//translate([5,5,0]) circuitHolder();
