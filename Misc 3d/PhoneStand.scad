difference()
{
union()
{
cube([160,20,3]);
cube([5, 70, 5]);
translate([0,65,0]) cube([155,5,5]);
translate([155,0,0]) cube([5, 70, 5]);
translate([75,0,0]) cube([5, 70, 5]);
translate([145,15,0]) rotate([60,0,0]) cube([15, 80, 3]);
translate([0,15,0]) rotate([60,0,0]) cube([15, 80, 3]);
translate([70,15,0]) rotate([60,0,0]) cube([15, 80, 3]);
translate([146,0,0]) rotate([60,0,0]) cube([14, 75, 3]); // front light blocker
rotate([60,0,0]) translate([159,2,-10]) cube([1, 35, 10]); // phone stop
translate([0, 50,0]) cube([5,5,69]); // support
translate([155, 50,0]) cube([5,5,69]); // support
translate([75, 50,0]) cube([5,5,69]); // support
translate([155, 59, 5]) cube([5,5, 20]); // charge holder
cube([160,3, 7]);
}
translate([0, 3, 2]) cube([159,9.75, 3]);
translate([0,12.7,2]) rotate([60,0,0]) cube([159, 80, 3]);
translate([0,-5,0]) cube([160,5,6]);
translate([0,0,-10]) cube([160,50,10]);
}







