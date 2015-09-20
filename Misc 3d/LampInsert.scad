include <coinCellHolder.scad>
include <switch.scad>

module switchPosition(){
translate([-7.7,0,2.5]) switch();
}

difference()
{
    union()
    {
    cylinder(d=29,h=5,$fn=1000);
    translate([0,0,2]) cylinder(d1=29,d2=30,h=3,$fn=1000);
    translate([0,0,5]) cylinder(d1=30.0,d2=29,h=2,$fn=1000);
    cylinder(d=36,h=2,$fn=1000);
        translate([-10,4.3,0]) cube([6,2,4]);
    }
    
    switchPosition();
    
    translate([2,2,2]) cube([20,20,7]);

translate([2,-22,2]) cube([20,20,7]);

translate([-22,-22,2]) cube([20,20,7]);

translate([-22,2,2]) cube([20,20,7]);


translate([0,0,2]) cylinder(d=20,h=5,$fn=1000);

}


difference()
{
    union()
    {
        translate([-10,4.3,0]) cube([6,2,4]);
        translate([-10.5,-6,0]) cube([6,2,4]);translate([-5.5,-2,0]) cube([2,4,6]);
    }
    switchPosition();
}



rotate([0,-90,0])translate([2,-12,-7]) coinCellHolder();
