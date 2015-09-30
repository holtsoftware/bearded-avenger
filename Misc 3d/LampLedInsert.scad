$fn=300;
module battery()
{
cylinder(d=14.15,h=50.5);
}

module ledTubeInside()
{
    cylinder(d=3,h=20);
}

module ledTube()
{
difference()
{
cylinder(d=5,h=20);
    ledTubeInside();
}
}








difference()
{
    union()
    {
        translate([0,0,4]) cylinder(d=23.6,h=5);
translate([0,0,-1])cube(size=[30,57,10],center=true);
cylinder(d=37,h=4.25);
        translate([-5,0,0]) rotate([0,45,0]) ledTube();
translate([5,0,0]) rotate([0,-45,0]) ledTube();
translate([0,5,0]) rotate([45,0,0]) ledTube();
translate([0,-5,0]) rotate([-45,0,0]) ledTube();
    }
hull()
{
    translate([7.075,25.25,-4]) rotate([90,0,0]) battery();
translate([-7.075,25.25,-4]) rotate([90,0,0]) battery();

}
translate([-5,0,0]) rotate([0,45,0]) ledTubeInside();
translate([5,0,0]) rotate([0,-45,0]) ledTubeInside();
translate([0,5,0]) rotate([45,0,0]) ledTubeInside();
translate([0,-5,0]) rotate([-45,0,0]) ledTubeInside();

translate([0,20.55,0]) cylinder(d=4.5,h=5);
translate([0,-20.55,0]) cylinder(d=4.5,h=5);
}