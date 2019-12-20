$fn=500;

module holes()
{
    translate([-1,0,0])cylinder(d=5,h=21);
    translate([25,0,0]) cylinder(d=5,h=21);
    translate([12,0,2]) difference()
    {
        cylinder(d=9,h=22);
    }

}

module moterHoles()
{
    translate([5.5, 5.5,0]) cylinder(d=3.25,h=5);
    translate([36.5, 5.5,0]) cylinder(d=3.25,h=5);
    translate([5.5, 36.5,0]) cylinder(d=3.25,h=5);
    translate([36.5, 36.5,0]) cylinder(d=3.25,h=5);

    translate([21,21,0]) cylinder(d=22.5,h=5);
}

module poles()
{
    translate([12,0,0]) difference()
    {
        cylinder(d=12,h=21);
        translate([0,0,2]) cylinder(d=9,h=22);
    }
}

difference()
{
    union()
    {
        translate([9,11.5,0]) poles();
        cube([42,42+23,4]);
    }
    translate([9,11.5,0]) holes();
    translate([0,23, 0]) moterHoles();
}
