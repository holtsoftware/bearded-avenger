$fn=300;
difference()
{
union()
{
cube([14, 25, 3.5]);
translate([0,24,3.5]) cube([14, 8, 3.5]);
translate([0,12,0]) rotate([15,0,0]) cube([14,14,3.5]);
}

translate([7,17,3.5]) cylinder(d=10,h=4);
translate([7,17,-1]) cylinder(d=4.25,h=8);
translate([7,7,-1]) cylinder(d=4.25,h=8);
}