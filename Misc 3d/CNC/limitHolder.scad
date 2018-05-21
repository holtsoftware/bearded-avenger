

$fn=500;
$wallThickness=4;
$xSize=18;
$ySize=14;
$zSize=26;
$rodD=8;
$screwSize=2.3;
$screwSeperator=9.5;

difference()
{
	cube([$xSize+($wallThickness*2),$ySize+($wallThickness*2),$zSize+$wallThickness]);
	translate([$wallThickness,$wallThickness,$wallThickness]) cube([$xSize,$ySize,$zSize]);
	translate([($xSize/2)+$wallThickness,-1,14]) rotate([-90,0,0]) cylinder(d=$rodD,h=$zSize);
	translate([($xSize/2),-1,14]) cube([$rodD, $ySize+10,$zSize-10]);
	translate([-1,$ySize+($wallThickness*2)-9,5]) union()
	{
		rotate([0,90,0]) cylinder(d=2.3,h=$wallThickness*2);
		translate([0,0,$screwSeperator]) rotate([0,90,0]) cylinder(d=2.3,h=$wallThickness*2);
	}
}



