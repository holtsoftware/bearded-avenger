difference()
{
union()
{
translate([5.5,1.5,0]) cylinder(d2=12.5, d1=20,h=35, $fn=1000);
translate([10.5,1.5,34]) rotate([0,90,0]) cylinder(d=3, h=1, $fn=100);
}
union()
{
translate([0,0,26.5]) cube([11, 3, 9]);
translate([1.25, .75, 16.5]) cube([8.5, 1.5, 10]);
translate([3, .25, 0]) cube([5, 2.5, 27]);
translate([1.5,-2.5,0]) cube([8,8,8]);
translate([3, -9,2]) cube([5,11, 2.5]);
}
}


