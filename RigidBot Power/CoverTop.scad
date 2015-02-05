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

module powerMountHole(){
	cylinder(d=4.25, h=9, center=true, $fn=100);
}

difference()
{
color("red") translate([0, 1, 1]) cube([132, 135, 29.5], center=true);
translate([0,-2, ]) cube([125.25,134, 27.5], center=true);
translate([0, -53, 12]) color("orange") cube([120, 27, 20], center=true);
color("blue") translate([63, -51.75, .5]) rotate([0,90,0]) powerMountHole();
color("blue") translate([-63, -51.75, .5]) rotate([0,90,0]) powerMountHole();
translate([-60,-16.5,-11.25]) color("lime") cube([20,10, 5], center=true);
translate([60,-14,-11.25]) color("pink") cube([20,15, 5], center=true);
}







translate([-71,62.5,-12.25]) color("blue") tab();

translate([71,62.5,-12.25]) rotate([0,0,180]) color("green") tab();



translate([-71,-58.75,-12.25]) color("yellow") tab();

translate([71,-58.75,-12.25]) rotate([0,0,180]) color("orange") tab();




//color("brown") translate([0,-50,19.5]) cube([128.25, 5, 14], center=true);
//color("brown") translate([0,66,19.5]) cube([128.25, 5, 14], center=true);
//color("brown") translate([0,0,19.5]) cube([128.25, 5, 14], center=true);