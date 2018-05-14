$fn=500;
module screwHole()
{
	translate([0,0,-1]) cylinder(d=4.5,h=4);
}

module powerHoles()
{
	screwHole();
	translate([0,25,0]) screwHole();
	translate([151,0,0]) screwHole();
	translate([151,25,0]) screwHole();
}

difference()
{
	cube([175,40,1]);
	translate([5,5,0]) powerHoles();
	
}