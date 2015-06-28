
difference()
{
union()
{
translate([2, 0,42]) color("orange") cube([31, 148.5, 3]);
translate([0, 145, 43]) rotate([0,90,0]) color("green") cylinder(d=2,h=35, $fn=100);

color("blue") translate([2,0,41])
union()
{
cube([2,2,4]);
translate([0,1,0]) rotate([0,90,0])  cylinder(d=3,h=2, $fn=100);
}

color("black") translate([31,0,41])
union()
{
cube([2,2,4]);
translate([0,1,0]) rotate([0,90,0])  cylinder(d=3,h=2, $fn=100);
}

}
translate([5, 5, 41])cylinder(d=1.5,h=5,$fn=100);
     translate([30, 5, 41])cylinder(d=1.5,h=5,$fn=100);
}

// 8.5
// 35 // 17.5
// 11.2 // 5.6

// 87.35