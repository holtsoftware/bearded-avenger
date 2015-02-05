module screwHole()
{
	cylinder(d=4, h=10, $fn=100);
}

module tabFemale()
{
	difference()
	{
		cube([10, 10, 4]);
		translate([5, 5, -3]) screwHole();
		translate([5, 5, 2])	cylinder(d=6.25, h=2, $fn=100);
	}
}

module tabMale()
{
	difference()
	{
		union()
		{
			cube([10, 10, 4]);
			translate([5, 5, 4])	cylinder(d=5.75, h=2, $fn=100);
		}
		translate([5, 5, -3]) screwHole();
	}
}


module switchOutline()
{
	cube([47.5, 18.5, 29]);
	translate([0,-1.5,.75])	cube([47.5, 1.5, 27.5]);
}

