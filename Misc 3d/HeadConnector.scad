$fn=300;

difference()
{
union()
{
    difference()
    {
        cylinder(d=45,h=3);
        color("orange") translate([-2,0,2.5]) cube([4,22.5,0.5]);
    }
        cylinder(d=9,h=6);
    
}
    
    translate([0,0,2]) cylinder(d=6.5,h=4);
    cylinder(d=2,h=6);
}
