module coinCellHolder()
{
difference()
{
cube([14,24,12]);

color("blue") translate([0,9.5,3.4]) cube([30,5,3.5]);
union()
{
color("orange") translate([-5,9.5,6.5]) cube([30,5,4]);
color("orange") translate([-5,7,8.5]) cube([30,10,2.5]);
}


color("green") translate([12,12,4.1]) cylinder(d=22,h=2.75,$fn=1000);
color("red") translate([12,1,4.1]) cube([10,22,2.75]);
}
}

