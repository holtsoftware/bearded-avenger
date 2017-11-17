$fn=500;
module peg()
{
	translate([3.75,3.75,0]) union()
	{
		cylinder(d=5,h=3.5,center=false);
		translate([0,0,3.5]) cylinder(d1=5,d2=7.5,h=2.5,center=false);
	}
}

module hole()
{
	translate([2.75,2.75,-1])
	union()
	{
	cylinder(d=5.5,h=12);
	translate([0,14,0]) cylinder(d=5.5,h=12);
	translate([-2.75,0,0]) cube([5.5,14,12]);
	}
}

difference()
{
union()
{
cube([13,73,10]);
cube([118,13,10]);
translate([105,0,0]) cube([13,73,10]);
translate([3,51.5,10]) peg();
translate([107.5,51.5,10]) peg();

translate([45,0,0]) rotate([0,0,40]) cube([13,70,10]);
translate([63,10,0]) rotate([0,0,-40]) cube([13,70,10]);
}
translate([-1,21,0]) hole();

translate([108.5,21,0]) hole();
}


