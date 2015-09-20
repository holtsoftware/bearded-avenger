module coinCellHolder()
{
    translate([14,2,1.2]) union()
{
cube([0.4,2,0.4]);
translate([0,0.8,-0.8]) cube([0.4,0.4,2]);
}
difference()
{
cube([14,24,8]);

color("blue") translate([0,9.5,2.4]) cube([31,5,4]);


color("green") translate([12,12,3.1]) cylinder(d=22,h=2.75,$fn=1000);
color("red") translate([12,1,3.1]) cube([10,22,2.75]);
    color("purple") translate([13.5,9.5,]) cube([0.5,5,8]);
}
}