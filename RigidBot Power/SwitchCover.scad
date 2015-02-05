module tab(){
	difference()
	{
		union()
		{
			color("yellow") cube([10, 10, 3], center=true);
			//translate([-5,-5,1.4]) tabSupport();
			//translate([-5,4.2,1.4]) tabSupport();
		}
		cylinder(d=4,h=5,center=true, $fn=100);
	}
}

difference()
{
	cube([34, 52, 34], center=true);
	translate([0,-1,-1])  cube([30, 50, 32], center=true);
}

color("blue") translate([21.9, 21, -15.5]) tab();
color("orange") translate([-21.9, 21, -15.5]) tab();
color("green") translate([21.9, -21, -15.5]) tab();
color("red") translate([-21.9, -21, -15.5]) tab();
