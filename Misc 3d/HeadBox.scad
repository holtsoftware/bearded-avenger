$fn=300;
module box()
{
    difference()
    {
        wallSize=1.2;
        cube([82,82,60]);
        translate([wallSize,0,2]) cube([82-(wallSize*2),82-wallSize,59]);
    }
}

module spacer(){
    difference()
    {
        translate([-10,-4.5,1]) cube([20,9,11.75]);
    holes();

    color("green") translate([-1.5,-5,0.75]) cube([3,10,20]);
    }
}

module holes(){
    translate([-5,0,0]) cylinder(d=3,h=20);
    translate([5,0,0]) cylinder(d=3,h=20);
}

module completespacer(){
    translate([0, 15,0]) spacer();
translate([0, -35,0]) spacer();
}

module toSubtract(){
    cylinder(d=15,h=20);
    translate([0,15,0]) holes();
    translate([0,-35,0]) holes();
}

module detector()
{
    difference()
    {
        translate([0,-1,0]) cube([20.25,2,10]);
        translate([0,-1,0]) cube([19,2,10]);
    }
}

module detectorComplete()
{
    detector();
rotate([0,0,45]) detector();
rotate([0,0,90]) detector();
rotate([0,0,135]) detector();
rotate([0,0,180]) detector();
}


difference()
{
union()
{
box();
translate([40,60,0]) completespacer();
}
translate([40,60,0]) toSubtract();
translate([40,60,0]) detectorComplete();
}

