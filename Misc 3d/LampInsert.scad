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
}

