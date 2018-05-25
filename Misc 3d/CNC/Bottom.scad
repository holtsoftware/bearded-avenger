use <PowerHoles.scad>;
use <CircuitHolder.scad>;

$bottomX=241.3;
$bottomY=260.35;
$bottomZ=5;
$wallThickness=3;
$pillerThickness=10;
$connectorLength=20;
$connectorWidth=10;
$holeSize=3.9;
$throughHoleSize=4.5;
$wallHeight=116;


function getWallThickness() = $wallThickness;
function getHoleSize() = $holeSize;
function getWallHeight() = $wallHeight;
function getPillerThickness() = $pillerThickness;
function getBottomX() = $bottomX;
function getBottomY() = $bottomY;
function getBottomZ() = $bottomZ;
function getConnectorLength() = $connectorLength;
function getConnectorWidth() = $connectorWidth;
function getThroughHoleSize() = $throughHoleSize;

module boltHole()
{
	union()
	{
		cylinder(d=$throughHoleSize,h=20);
		translate([0,0,$pillerThickness]) cube([$pillerThickness,$pillerThickness,$pillerThickness], center=true);
	}
}

// Bottom cube
module bottomFront(bottomZ=$bottomZ)
{
	union()
	{
		difference()
		{
			cube([$bottomX,$bottomY/2,bottomZ]);
			translate([($pillerThickness/2)+$wallThickness,($pillerThickness/2)+$wallThickness,0]) boltHole();
			translate([($pillerThickness/2)+$wallThickness,($bottomY/2)-($pillerThickness/2),0]) boltHole();
			translate([$bottomX-(($pillerThickness/2)+$wallThickness),($pillerThickness/2)+$wallThickness,0]) boltHole();
			translate([$bottomX-($pillerThickness/2)-$wallThickness,($bottomY/2)-($pillerThickness/2),0]) boltHole();
			translate([($bottomX/2) + (getPowerHoleX()/2*-1),(($bottomY/2)*0.25)+20,0]) powerHoles();
		}
		translate([($bottomX*0.25)-($connectorWidth/2),($bottomY/2)-($connectorLength/2),0]) cube([$connectorWidth, $connectorLength,bottomZ]);
		translate([($bottomX*0.75)-($connectorWidth/2),($bottomY/2)-($connectorLength/2),0]) cube([$connectorWidth, $connectorLength,bottomZ]);
	}
}

module bottomBack(bottomZ=$bottomZ)
{
	union()
	{
		difference()
		{
			cube([$bottomX,$bottomY/2,bottomZ]);
			translate([($pillerThickness/2)+$wallThickness,($pillerThickness/2)+$wallThickness,0]) #boltHole();
			translate([($pillerThickness/2)+$wallThickness,($bottomY/2)-($pillerThickness/2),0]) #boltHole();
			translate([$bottomX-(($pillerThickness/2)+$wallThickness),($pillerThickness/2)+$wallThickness,0]) #boltHole();
			translate([$bottomX-($pillerThickness/2)-$wallThickness,($bottomY/2)-($pillerThickness/2),0]) #boltHole();
			translate([($bottomX*0.25)-($connectorWidth/2),($bottomY/2)-($connectorLength/2),0]) #cube([$connectorWidth, $connectorLength,bottomZ]);
			translate([($bottomX*0.75)-($connectorWidth/2),($bottomY/2)-($connectorLength/2),0]) #cube([$connectorWidth, $connectorLength,bottomZ]);
			translate([($bottomX*0.5) + (getCircuitHolderX()/2*-1),($bottomY*0.25) + (getCircuitHolderY()/2*-1),0]) #circuitHolderHoles();
		}
		translate([($bottomX*0.5) + (getCircuitHolderX()/2*-1),($bottomY*0.25) + (getCircuitHolderY()/2*-1),0]) #circuitHolder();
	}
}


bottomBack();