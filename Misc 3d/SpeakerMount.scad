$fn=500;
module peg()
{
	translate([3.75,3.75,-10]) union()
	{
		cylinder(d=2.5,h=10,center=false);
		//translate([0,0,3.5]) cylinder(d1=5,d2=7.5,h=2.5,center=false);
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

module rod()
{
difference()
{
cube([13,5,60]);
translate([6.5,-0.5,22]) rotate([-90,0,0]) cylinder(d=4,h=6);
translate([6.5,3,22]) rotate([-90,0,0]) cylinder(d=9,h=5);
}
}

difference()
{
union()
{
cube([13,73,10]);
cube([118,13,10]);
translate([105,0,0]) cube([13,73,10]);


translate([45,0,0]) rotate([0,0,40]) cube([13,70,10]);
translate([63,10,0]) rotate([0,0,-40]) cube([13,70,10]);
}

translate([3,51.5,10]) peg();
translate([107.5,51.5,10]) peg();

translate([-1,21,0]) hole();

translate([108.5,21,0]) hole();
}

rod();
translate([105,0,0]) rod();


