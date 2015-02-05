difference()
{

union()
{
color("blue") cube(size=[20,24,24], center=true);
color("red") translate([0,-36,0])  cube(size=[20, 48, 3], center=true);

color("DarkOrange") translate([0, -46,-6]) cube(size=[20, 5, 12], center=true);
color("DarkOrange") translate([0, -62,-5.25]) cube(size=[20, 5, 13.5], center=true);

}
cube(size=[25, 20, 20], center=true);
color("Indigo") translate([0,-53.5,-14]) cylinder(d=4.5, h=28, $fn=100);
color("Navy")  translate([0, 0, -16]) rotate([45,0,0]) cube([25, 20, 20], center=true);
}