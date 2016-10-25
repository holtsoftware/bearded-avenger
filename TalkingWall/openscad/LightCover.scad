difference()
{
    cylinder(d=7,h=12, $fn=100);
    translate([0,0,0]) cylinder(d=5,h=12,$fn=100);
}

difference()
{
translate([0,0,12]) cylinder(d1=7,d2=0,h=4, $fn=100);
translate([0,0,12]) cylinder(d1=5,d2=0,h=2, $fn=100);
}