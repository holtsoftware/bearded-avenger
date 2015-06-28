difference()
{
cylinder(d=84,h=54, $fn=1000);
translate([0,0,-1]) cylinder(d=78,h=55, $fn=1000);
}

translate([0,0,54])
difference()
{
    cylinder(d=94,h=4,$fn=1000);
    translate([17,17,0]) cylinder(d=4.5,h=5,$fn=1000);
    translate([-17,17,0]) cylinder(d=4.5,h=5,$fn=1000);
    translate([-17,-17,0]) cylinder(d=4.5,h=5,$fn=1000);
    translate([17,-17,0]) cylinder(d=4.5,h=5,$fn=1000);
}
translate([-2,-41,0]) cube([4,82,54]);

translate([-41,-2,0]) cube([82,4,54]);