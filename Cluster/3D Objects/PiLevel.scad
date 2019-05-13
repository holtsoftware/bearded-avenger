use <_level.scad>;
$fn=500;



difference()
{
	union()
	{
		cube([getWidth(),getLength(),getThickness()]);
	}
	levelStandOffHoles();
	#translate([6,20,-1]) piHoles();
	#translate([6,getLength()-68,-1]) piHoles();
	translate([14,0,0]) color("orange") cube([40,getLength(),4]);
	translate([getWidth()-10,29,0]) color("red") cube([10,getLength()-58,4]);
}
translate([10,0,0]) cube([4,getLength(),4]);
translate([getWidth()-14,0,0]) cube([4,getLength(),4]);
translate([0,25,0]) cube([getWidth(),4,4]);
translate([0,getLength()-30,0]) cube([getWidth(),4,4]);

