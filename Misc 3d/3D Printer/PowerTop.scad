use <variables.scad>;
$fn=500;
$width=130;
$length=225;
$sideHeight=20;

difference()
{
	union()
	{
		cube([$width, $length, getWallThickness() * 2]);
		translate([0,0,getWallThickness() * 2]) cube([$width,$length,$sideHeight]);
	}
	#translate([getWallThickness(), 0, getWallThickness() * 2]) cube([$width - (getWallThickness() * 2), $length, $sideHeight]);
	#translate([0,38.3,(getWallThickness() * 2) + 13]) rotate([0,90,0]) cylinder($d=getThroughHoleSize(), h=20);
	#translate([0,198.3,(getWallThickness() * 2) + 13]) rotate([0,90,0]) cylinder($d=getThroughHoleSize(), h=20);
	#translate([$width - 10,38.3,(getWallThickness() * 2) + 13]) rotate([0,90,0]) cylinder($d=getThroughHoleSize(), h=20);
	#translate([$width - 10,198.3,(getWallThickness() * 2) + 13]) rotate([0,90,0]) cylinder($d=getThroughHoleSize(), h=20);
}