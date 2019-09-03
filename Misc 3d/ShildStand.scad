module base()
{
    cube([150,20,5]);
    cube([10,100,5]);
    translate([140, 0,0]) cube([10,100,5]);
    translate([0, 95,0]) cube([150,5,5]);
}

module holder()
{
    cube([150,13.1,5]);
    cube([150,2,10]);
    translate([0,11.1,0]) cube([150,2,20]);
    translate([0,11.1,0]) cube([30,5,100]);
    cube([15,2,100]);
    translate([0,2,0]) cube([5,9.1,50]);
    translate([140,11.1,0]) cube([10,5,100]);
}
base();
translate([0,0,3]) rotate([-10,0,0]) holder();
translate([0,46,0]) rotate([10,0,0]) cube([10,5,100]);
translate([140,46,0]) rotate([10,0,0]) cube([10,5,100]);