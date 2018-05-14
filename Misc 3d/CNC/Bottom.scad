
$bottomX=241.3;
$bottomY=260.35;
$bottomZ=5;

module boltHole()
{
	cylinder(d=4.5,h=20);
	translate([0,0,5]) cube([10,10,10], center=true);
}

// Bottom cube
cube([$bottomX,$bottomY,$bottomZ]);
translate([5,5,0]) boltHole();

