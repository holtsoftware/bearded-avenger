include <coinCellHolder.scad>

difference()
{
    union()
    {
    cylinder(d=29,h=5,$fn=1000);
    translate([0,0,2]) cylinder(d1=29,d2=30,h=3,$fn=1000);
    translate([0,0,5]) cylinder(d1=30.0,d2=29,h=2,$fn=1000);
    cylinder(d=36,h=2,$fn=1000);
        
    }
    
    translate([2,2,2]) cube([20,20,7]);

translate([2,-22,2]) cube([20,20,7]);

translate([-22,-22,2]) cube([20,20,7]);

translate([-22,2,2]) cube([20,20,7]);


translate([0,0,2]) cylinder(d=20,h=5,$fn=1000);

color("blue") translate([-4,-5,-10]) cube([2.75,10,30]);
color("orange") translate([3.25,0,-5]) cylinder(d=0.5,h=18,$fn=1000);

color("orange") translate([-0.75,0,-5]) cylinder(d=0.5,h=18,$fn=1000);
}


difference(){
    color("purple") translate([-0.75,-3,0]) cube([0.75,6,13]);
    
    color("orange") translate([-0.75,0,-5]) cylinder(d=0.5,h=18,$fn=1000);
}



rotate([0,-90,0])translate([2,-12,-7]) coinCellHolder();