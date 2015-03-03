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
		translate([5, 5, -1])	cylinder(d=6.25, h=3, $fn=100);
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
	cube([47.5, 18.5, 30]);
	translate([0,-1,1.25])	cube([47.5, 1, 27.5]);
}

module barConnector()
{
	difference()
	{
		color("blue") cube(size=[20,24,24]);
		translate([-2,2,2]) cube(size=[25, 20, 20]);
		color("Navy")  translate([-3, 12, -17]) rotate([45,0,0]) cube([25, 20, 20]);
	}

}