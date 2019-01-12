module back()
{
	cube([2,5,14]);
	translate([0,15,0]) cube([2,5,14]);
}

module top()
{
	translate([0,20,14.5]) rotate([180,0,0]) bottom();
}

module bottom()
{
	cube([10,20,2]);
	rotate([0,45,0]) translate([0.25,0,2.25]) cube([2,20,2]);
}

back();
bottom();
top();