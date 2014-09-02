difference()
{
cylinder(d1=31, d2=21, h=25, $fn=100);
cylinder(d1=29, d2=19, h=25, $fn=100);
}

translate([0,0,24]) cylinder(d=20, h=1, $fn=100);
translate([0,0,13]) difference()
{
cylinder(d=10,h=12, $fn=100);
cylinder(d=8,h=11, $fn=100);
}