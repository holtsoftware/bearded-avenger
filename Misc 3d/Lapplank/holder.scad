$fn=500;

difference()
{
	union()
	{
		cylinder(d=95,h=10);
		cylinder(d=85,h=26);
	}
	translate([0,0,10]) cylinder(d=65,h=16);
	translate([17,17,0]) cylinder(d=5.5,h=26);
	translate([-17,17,0]) cylinder(d=5.5,h=26);
	translate([17,-17,0]) cylinder(d=5.5,h=26);
	translate([-17,-17,0]) cylinder(d=5.5,h=26);
}