
$fn=500;
$holeSize=5.5;

difference()
{
#cube([20,20,4], center=true);
translate([0,0,-4]) #cylinder(d=$holeSize,h=8);
}