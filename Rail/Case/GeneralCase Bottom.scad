
difference()
{
union()
{
cube([35, 148.5, 4]);
translate([9.275, 7.9, 0]) cube([2.45, 2.45, 6]);
translate([23.075, 7.9, 0]) cube([2.45, 2.45, 6]);

translate([9.275, 95.85, 0]) cube([2.45, 2.45, 6]);
translate([23.075, 95.85, 0]) cube([2.45, 2.45, 6]);

cube([2, 148.5, 45]);
translate([33, 0, 0]) cube([2, 148.5, 45]);

translate([2, 8, 42]) rotate([90,0,0]) cylinder(d=4,h=8,$fn=100);

translate([33, 8, 42]) rotate([90,0,0]) cylinder(d=4,h=8,$fn=100);
    
translate([2, 85, 42]) rotate([90,0,0]) cylinder(d=4,h=8,$fn=100);

translate([33, 85, 42]) rotate([90,0,0]) cylinder(d=4,h=8,$fn=100);

translate([0, 146.5, 0])cube([35, 2, 20]);
    
    translate([0,10,38]) rotate([45,0,0]) color("blue") cube([1,10,10]);
    
    translate([0,100,38]) rotate([45,0,0]) color("blue") cube([1,10,10]);
    
    translate([34,10,38]) rotate([45,0,0]) color("blue") cube([1,10,10]);
    
    translate([34,100,38]) rotate([45,0,0]) color("blue") cube([1,10,10]);
}


 

union()
{
translate([0,10,-7]) rotate([45,0,0]) color("blue") cube([1,10,10]);
    
    translate([0,100,-7]) rotate([45,0,0]) color("blue") cube([1,10,10]);
    
    translate([34,10,-7]) rotate([45,0,0]) color("blue") cube([1,10,10]);
    
    translate([34,100,-7]) rotate([45,0,0]) color("blue") cube([1,10,10]);
    translate([5, 5, 0])cylinder(d=1.5,h=5,$fn=100);
     translate([30, 5, 0])cylinder(d=1.5,h=5,$fn=100);

translate([32, 115, 20]) color("green") resize([5,10,30])  rotate([0,90,0])  cylinder(d=10,h=5,$fn=100);

translate([32, 95, 20]) color("green") resize([5,10,30])  rotate([0,90,0])  cylinder(d=10,h=5,$fn=100);

translate([32, 75, 20]) color("green") resize([5,10,30])  rotate([0,90,0])  cylinder(d=10,h=5,$fn=100);

translate([32, 55, 20]) color("green") resize([5,10,30])  rotate([0,90,0])  cylinder(d=10,h=5,$fn=100);

translate([32, 35, 20]) color("green") resize([5,10,30])  rotate([0,90,0])  cylinder(d=10,h=5,$fn=100);

translate([-1, 115, 20]) color("orange") resize([5,10,30])  rotate([0,90,0])  cylinder(d=10,h=5,$fn=100);

translate([-1, 95, 20]) color("orange") resize([5,10,30])  rotate([0,90,0])  cylinder(d=10,h=5,$fn=100);

translate([-1, 75, 20]) color("orange") resize([5,10,30])  rotate([0,90,0])  cylinder(d=10,h=5,$fn=100);

translate([-1, 55, 20]) color("orange") resize([5,10,30])  rotate([0,90,0])  cylinder(d=10,h=5,$fn=100);

translate([-1, 35, 20]) color("orange") resize([5,10,30])  rotate([0,90,0])  cylinder(d=10,h=5,$fn=100);
 
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
}
// 8.5
// 35 // 17.5
// 11.2 // 5.6

// 87.35