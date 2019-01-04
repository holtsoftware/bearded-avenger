$fn=500;

$height=30;
$thickness=2;

module bottom()
{
	difference()
	{
		cube([76,145,$height]);
		translate([2,20,2]) cube([72,102,$height]);
		translate([2,2,2]) color("orange") cube([35,15,$height - $thickness]);
		translate([-0.5,9.5,8.5]) rotate([0,90,0]) cylinder(d=7.5,h=$height);

		translate([10,121,$thickness]) union()
		{
			translate([0,4,0]) cube([20,7,$height - $thickness]);
			translate([0,14,0]) cube([20,7,$height - $thickness]);
			translate([13,4,0]) cube([7,13,$height - $thickness]);
			cube([7,7,$height - $thickness]);
			translate([0,18,0]) cube([7,7,$height - $thickness]);
		}

		translate([45,10,2]) cube([4,10,$height - $thickness]);
		translate([30,4.5,2]) cube([20,10,$height - $thickness]);

		translate([70,140,0]) cylinder(d=2.5,h=$height + $thickness);
		translate([70,5,0]) cylinder(d=2.5,h=$height + $thickness);
		translate([5,140,0]) cylinder(d=2.5,h=$height + $thickness);
		translate([1.5,2,0]) #cylinder(d=2.5,h=$height+$thickness);
	}
	translate([1.5,2,0]) difference()
	{
		#cylinder(d=5,h=$height);
		cylinder(d=2.5,h=$height + $thickness);
	}
}

module top()
{
	difference()
	{
		union()
		{
			cube([76,145,3]);
			translate([1.5,2,0]) cylinder(d=5,h=3);
		}
		translate([70,140,0]) cylinder(d=3.5,h=16);
translate([70,5,0]) cylinder(d=3.5,h=16);
translate([5,140,0]) cylinder(d=3.5,h=16);
		
	translate([1.5,2,0]) cylinder(d=3.5,h=16);
	}
}

top();
//bottom();