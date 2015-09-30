$fn=300;

difference()
{
union()
{
        cylinder(d=45,h=3);
        cylinder(d=9,h=7);
    
}
    
    translate([0,0,2]) cylinder(d=6,h=6);
    translate([0,0,-1]) cylinder(d=2,h=6);
}
difference()
{
color("purple") translate([12,0,2]) rotate([0,90,0]) cylinder(d=5,h=4);
    translate([-22.5,-22.5,-2,]) cube([45,45,2]);
}
