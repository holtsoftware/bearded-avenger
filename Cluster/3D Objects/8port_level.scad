use <_level.scad>;
$fn=500;

$holderOffset=80;
module MountHoles()
{
	$holeWidth=5;
	#translate([getWidth()/2,(getLength()/2)-($holderOffset/2),-1]) union()
	{
		cylinder(d=$holeWidth, h=10);
		translate([0, $holderOffset, 0]) cylinder(d=$holeWidth, h=10);
	}
}

difference()
{
	union()
	{
		cube([getWidth(),getLength(),getThickness()]);
		translate([10,0,0]) cube([4,getLength(),6]);
		translate([getWidth()-14,0,0]) cube([4,getLength(),6]);
		translate([0,(getLength()/2)-($holderOffset/2)+4,0]) cube([getWidth(),4,6]);
		translate([0,(getLength()/2)+($holderOffset/2)-8,0]) cube([getWidth(),4,6]);
	}
	levelStandOffHoles();
	MountHoles();
	translate([(getWidth()-28)-(getWidth()/2)-2,(getLength()/2) - (($holderOffset-16)/2),0]) color("orange") cube([getWidth()-28,($holderOffset-16),8]);
	translate([(getWidth()-28)-(getWidth()/2)-2,0,0]) color("blue") cube([getWidth()-28,35,8]);
	translate([(getWidth()-28)-(getWidth()/2)-2,getLength()-35,0]) color("blue") cube([getWidth()-28,35,8]);
}
