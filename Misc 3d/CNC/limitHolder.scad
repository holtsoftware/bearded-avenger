

$fn=500;
$xWallThickness=4;
$yWallThickness=2;
$xSize=19;
$ySize=15;
$zSize=20;
$rodD=8;
$screwSize=2.3;
$screwSeperator=9.5;

module holes($size=$screwSize)
{
	union()
	{
		rotate([0,90,0]) cylinder(d=$size,h=$zSize+($xWallThickness*2));
		translate([0,0,$screwSeperator]) rotate([0,90,0]) cylinder(d=$size,h=$zSize+($xWallThickness*2));
	}
}

difference()
{
	cube([$xSize+($xWallThickness*2),$ySize+($yWallThickness*2),$zSize+$yWallThickness]);
	translate([$xWallThickness,$yWallThickness,$yWallThickness]) cube([$xSize,$ySize,$zSize]);
	translate([($xSize/2)+$xWallThickness,-1,14]) rotate([-90,0,0]) cylinder(d=$rodD,h=$zSize);
	translate([($xSize/2),-1,14]) cube([$rodD, $ySize+10,$zSize-10]);
	translate([-1,$ySize+($yWallThickness*2)-9,5]) holes();
	translate([$xSize*0.3,-1,5]) rotate([0,0,90]) holes();
	translate([$xSize*1.1,-1,5]) rotate([0,0,90]) holes();
}

