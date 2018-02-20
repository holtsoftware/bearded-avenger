$fn=500;

difference()
{
	cube([76,145,15]);
	translate([2,20,2]) cube([72,102,15]);
	translate([2,2,2]) color("orange") cube([35,15,13]);
	translate([-0.5,9.5,8.5]) rotate([0,90,0]) cylinder(d=7.5,h=5);

translate([10,121,2]) union()
{
	translate([0,4,0]) cube([20,7,13]);
	translate([0,14,0]) cube([20,7,13]);
	translate([13,4,0]) cube([7,13,13]);
	cube([7,7,13]);
	translate([0,18,0]) cube([7,7,13]);
}

translate([45,10,2]) cube([4,10,13]);
translate([30,4.5,2]) cube([20,10,13]);

translate([70,140,0]) cylinder(d=2.5,h=16);
translate([70,5,0]) cylinder(d=2.5,h=16);
translate([5,140,0]) cylinder(d=2.5,h=16);
}
translate([3,3,0]) difference()
{
	cylinder(d=5,h=15);
	cylinder(d=2.5,h=16);
}