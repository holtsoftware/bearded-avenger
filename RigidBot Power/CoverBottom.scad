include <library.scad>

module boardHoles(diam=2.5, height=9, zpos=0) 
{
	color("blue") union() // bread board holes
	{
		translate([44.5,64,zpos]) cylinder(d=diam, h=height, $fn=100);
		translate([0,64,zpos]) cylinder(d=diam, h=height, $fn=100);
		translate([44.5,0,zpos]) cylinder(d=diam, h=height, $fn=100);
		translate([0,0,zpos]) cylinder(d=diam, h=height, $fn=100);
	}
}

module powerMountHole(){
	cylinder(d=4.25, h=9, $fn=100);
}

boardTranslate = [15, 30, 0];

difference()
{
	color("red") union()
	{
		color("red") cube([130, 190, 32.25]);
		translate([1.75, 1.5, 0]) cube([126.5, 188.5, 33]);

	}
	translate([3,4,3]) cube([124, 189, 33]);
	translate(boardTranslate) boardHoles(zpos=-1);
	translate([75,1.5,4]) switchOutline();
	color("purple") translate([39.685,182,-1]) powerMountHole();
	color("purple") translate([90.315,182, -1]) powerMountHole();
	color("blue") translate([-1,175,13]) rotate([0,90,0]) powerMountHole();
	color("blue") translate([126,175,13]) rotate([0,90,0]) powerMountHole();
	color("darkgreen") translate([60,5,7]) rotate([90, 0,0]) cylinder(d=4, h=9, $fn=100);
	color("darkgreen") translate([60,5,25]) rotate([90, 0,0]) cylinder(d=4, h=9, $fn=100);
}
translate(boardTranslate) difference()
{
boardHoles(5, 6);
boardHoles(zpos=-1);
}

color("green") translate([-10, 160,28.25]) tabMale();
color("orange") translate([130, 160, 28.25]) tabMale();
color("purple") translate([-10, 0, 28.25]) tabMale();
color("lime") translate([130, 0, 28.25]) tabMale();






