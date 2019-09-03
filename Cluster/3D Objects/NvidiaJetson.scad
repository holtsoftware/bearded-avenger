use <_level.scad>;
$fn=500;


module jetsonHoles()
{
	$xOffset=58;
	$yOffset=86.5;
	cylinder(d=piHole(),h=10);
	translate([$xOffset,0,0]) cylinder(d=piHole(),h=10);
	translate([0,$yOffset,0]) cylinder(d=piHole(),h=10);
	translate([$xOffset,$yOffset,0]) cylinder(d=piHole(),h=10);
}

difference()
{
	union()
	{
		cube([getWidth(),getLength(),getThickness()]);
	}
	levelStandOffHoles();
//	#translate([6,20,-1]) piHoles();
	#translate([6,getLength()/2 - (86.5/2),-1]) jetsonHoles();
	translate([14,0,0]) color("orange") cube([40,getLength(),4]);
	translate([getWidth()-10,29,0]) color("red") cube([10,getLength()-58,4]);
}
translate([10,0,0]) cube([4,getLength(),4]);
translate([getWidth()-14,0,0]) cube([4,getLength(),4]);
translate([0,25,0]) cube([getWidth(),4,4]);
translate([0,getLength()-30,0]) cube([getWidth(),4,4]);

