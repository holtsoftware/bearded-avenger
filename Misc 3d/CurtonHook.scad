$fn=500;

difference()
{
union()
{
difference()
{
    union()
    {
    cylinder(h=20, d=40);
        cube([20,20,20]);
    }
    cylinder(h=20, d=33);
    translate([-24,-40,0]) cube([40,40,20]);
}
translate([18.5,0,10]) cube([5,40,20],true);
}




translate([13,-10,10]) rotate([0,90,0]) cylinder(h=10, d=3);
}