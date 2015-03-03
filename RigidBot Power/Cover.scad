include <library.scad>

module boardHoles(diam=2, height=9, zpos=0) 
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

module innerCube(){
	translate([3,4,3]) cube([126, 189, 50.25]);
}

module vent()
{
cube([44, 2.5, 10]);
translate([0, 1.25, 0]) cylinder(d=2.5, h=10, $fn=100);
translate([44, 1.25, 0]) cylinder(d=2.5, h=10, $fn=100);
}

module localSwitchOutline()
{
	translate([75,1,4]) switchOutline();
}

module bottom(){
boardTranslate = [15, 30, 0];


difference()
{
	color("red") union()
	{
		color("red") cube([132, 190, 32.25]);
		translate([1.75, 1.5, 0]) cube([128.5, 188.5, 33]);

	}
	innerCube();
	translate(boardTranslate) boardHoles(zpos=-1);
	localSwitchOutline();
	color("purple") translate([39.685,182,-1]) powerMountHole();
	color("purple") translate([90.315,182, -1]) powerMountHole();
	color("blue") translate([-1,175,16.5]) rotate([0,90,0]) powerMountHole();
	color("blue") translate([126,175,16.5]) rotate([0,90,0]) powerMountHole();
	color("darkgreen") translate([60,5,7]) rotate([90, 0,0]) cylinder(d=4, h=9, $fn=100);
	color("darkgreen") translate([60,5,25]) rotate([90, 0,0]) cylinder(d=4, h=9, $fn=100);
}
translate(boardTranslate) difference()
{
boardHoles(5, 6);
boardHoles(zpos=-1);
}

color("green") translate([-10, 160,28.25]) tabMale();
color("orange") translate([132, 160, 28.25]) tabMale();
color("purple") translate([-10, 0, 28.25]) tabMale();
color("lime") translate([132, 0, 28.25]) tabMale();
}



module top(){
difference(){
	color("cyan") translate([0,0, 32.25]) cube([132, 190, 24.25]);
	color("blue") translate([-1,175,41.5]) rotate([0,90,0]) powerMountHole();
	color("blue") translate([126,175,41.5]) rotate([0,90,0]) powerMountHole();
	innerCube();
	color("red") translate([1.5, 1.5, 0]) cube([129, 188.5, 33.25]);
	localSwitchOutline();
	color("blue") translate([13,161,36]) cube([106, 30, 22]);
	color("darkgreen") translate([60,5,45]) rotate([90, 0,0]) cylinder(d=4, h=9, $fn=100);

	color("red") translate([128,114,32.25]) cube([5,15.5,8]);

	color("orange") translate([-1,34,32.25]) cube([5, 12, 2]);

	for(y=[0:13])
	{
		color("purple") translate([15, (y*5) + 28, 50]) vent();
	}
}

	color("orange") translate([-10, 160,32.25]) tabFemale();
	color("green") translate([132, 160, 32.25]) tabFemale();
	color("lime") translate([-10, 0, 32.25]) tabFemale();
	color("purple") translate([132, 0, 32.25]) tabFemale();
	
}


//bottom();
//translate([0,0,-32.25]) 
top();











