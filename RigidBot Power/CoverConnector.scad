include <library.scad>
start=12;
difference()
{
union()
{
rotate([90,0,90]) translate([0,-24,-21]) barConnector();

rotate([90,0,90]) translate([0,59,-21]) barConnector();

cube([3, 20, 59]);
}


color("orange") translate([-2,10,start]) rotate([0, 90,0]) screwHole();
color("orange") translate([-2,10,start + 18.3]) rotate([0, 90,0]) screwHole();
color("orange") translate([-2,10,start + 18.3 + 20.5]) rotate([0, 90,0]) screwHole();
}

/*
Hole 1 to Hole 2 = 18.3
Hole 2 to Hole 3 = 20.5

Edge to Hole 1 = 17.2
Edge to Hole 3 = 11.5

Height of cover 58.25
*/