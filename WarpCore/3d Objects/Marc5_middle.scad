$fn=25;
sectionWidth=40;
outterWidth=133.5;

module outter()
{
	cylinder(d1=128,d2=126,h=10);
	translate([0,0,10]) cylinder(d1=126,d2=128,h=9);
	translate([0,0,19]) cylinder(d=outterWidth,h=15.75);
}

module middle()
{
	translate([0,0,3]) cylinder(d=115,h=17);
	cylinder(d=sectionWidth, h=3);
	translate([0,0,19]) cylinder(d=117.5,h=15.75);
}

module screwHoles()
{
	translate([20,20,0]) #cylinder(d=3.5,h=20);
	translate([-20,20,0]) #cylinder(d=3.5,h=20);
	translate([-20,-20,0]) #cylinder(d=3.5,h=20);
	translate([20,-20,0]) #cylinder(d=3.5,h=20);
}

module rod(width=10.35)
{
	sides = [
		[0,0,0], // 0
		[(width/2) * -1, (outterWidth / 2), 0], // 1
		[(width/2), (outterWidth/2),0], // 2
		[(width/2), (outterWidth/2),8.75], // 3
		[(width/2) * -1, (outterWidth/2),8.75], // 4
		[0,0,8.75] // 5
	];

	f = [
		[0,2,1],
		[5,4,3],
		[1,2,3,4],
		[1,4,5,0],
		[2,0,5,3],
	];
	polyhedron(points=sides, faces=f);
}

difference()
{
	outter();
	middle();
	screwHoles();
}
	rod();
	translate([0,0,26]) rotate([0,0,15 + 3.86]) rod(9);
//	translate([-4.5,0,26]) rotate([0,0,15]) cube([9,70,8.75]);
//	translate([-4.5,0,26]) rotate([0,0,-15]) cube([9,70,8.75]);
	for(i=[1:8])
	{
//		translate([-5.175,0,26]) rotate([0,0,15 + (13.46 * i)]) cube([10.35,70,8.75]);
	}