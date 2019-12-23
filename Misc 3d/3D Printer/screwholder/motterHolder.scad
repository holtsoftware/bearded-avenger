use <holder.scad>;
$fn=300;

//holder();

difference()
{
    cube([54.7,5,42]);
    #translate([11.85,0,5.5]) union()
    {
        translate([0,-1,0]) rotate([-90,0,0]) cylinder(d=3.5,h=10);
        translate([31,-1,0]) rotate([-90,0,0]) cylinder(d=3.5,h=10);
        translate([31,-1,31]) rotate([-90,0,0]) cylinder(d=3.5,h=10);
        translate([0,-1,31]) rotate([-90,0,0]) cylinder(d=3.5,h=10);
    }
    #translate([27.35,-1,21]) rotate([-90,0,0]) cylinder(d=31,h=10);
}


translate([0,18.5,36.5]) holder();
translate([0,0,42]) cube([54.7,17.5,3]);
translate([0,12.5,36.5]) cube([54.7,5,6]);
color("orange") translate([0,14,36.5]) cube([54.7,5,3]);