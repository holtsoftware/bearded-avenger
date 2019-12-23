$fn=300;
module hole()
{
    cylinder(d=4.4,h=7);
    translate([0,0,3.75]) cylinder(d1=4.4,d2=9,h=2.25);
}

difference()
{
    union()
    {
        cube([30.3,59.5,6]);
        translate([0,15,6]) cube([30.3,15,9]);
        translate([27.3,15,6]) cube([3,35,9]);
    }
    translate([15.5,29.75,6]) cylinder(d=25.5,h=6.8);
    translate([15.5,7,0]) hole();
    translate([15.5,52.5,0]) hole();
}
