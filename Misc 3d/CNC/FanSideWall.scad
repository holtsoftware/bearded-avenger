use <Bottom.scad>;
use <SideWall.scad>;

//$fn=500;
$fanSize=80;
$fanScrewSize=5;
$fanScrewOffset=1.9;
$fanHoleSize=77;

function getFanSize() = $fanSize;

module fanScrewHole(holeSize)
{
	translate([($fanScrewSize/2),($fanScrewSize/2),0]) #cylinder(d=holeSize,h=getWallThickness()*2);
}

module fanHoles(holeSize=$fanScrewSize)
{
	//cube([$fanSize,$fanSize,1]);
	translate([$fanScrewOffset,$fanScrewOffset,-1]) fanScrewHole(holeSize);
	translate([$fanSize-$fanScrewSize-$fanScrewOffset,$fanScrewOffset,-1]) fanScrewHole(holeSize);
	translate([$fanScrewOffset,$fanSize-$fanScrewSize-$fanScrewOffset,-1]) fanScrewHole(holeSize);
	translate([$fanSize-$fanScrewSize-$fanScrewOffset,$fanSize-$fanScrewSize-$fanScrewOffset,-1]) fanScrewHole(holeSize);
	translate([($fanHoleSize/2)+(($fanSize-$fanHoleSize)/2),($fanHoleSize/2)+(($fanSize-$fanHoleSize)/2),-1]) #cylinder(d=$fanHoleSize,h=getWallThickness()*2);
}

difference()
{
	sideWall();
	translate([(getBottomX()/2)-(getFanSize()/2),(getWallHeight()/2)-(getFanSize()/2)+5,0]) fanHoles($fanScrewSize);
}