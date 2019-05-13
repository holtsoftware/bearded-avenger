$fn=500;
sectionWidth=59;
inserts=5;
screwHoleSize=3.5;

module bottom()
{
	union()
	{
		cylinder(d1=103,d2=110,h=6);
		translate([0,0,6]) cylinder(d1=110,d2=106,h=2);
		translate([0,0,8]) cylinder(d1=106,d2=120,h=15);
	}
}

module subtracts()
{
	#cylinder(d=sectionWidth,h=3);
	translate([-7,-7,0]) cube([14,14,35]);
	screwHoles();
	translate([0,0,8]) cylinder(d=90,h=15);
}

module screwHoles()
{
	translate([7-1.75,7-1.75,0]) #cylinder(d=screwHoleSize,h=35);
	translate([-7+1.75,-7+1.75,0]) #cylinder(d=screwHoleSize,h=35);
	translate([20,20,3]) #cylinder(d=inserts,h=20);
	translate([-20,20,3]) #cylinder(d=inserts,h=20);
	translate([-20,-20,3]) #cylinder(d=inserts,h=20);
	translate([20,-20,3]) #cylinder(d=inserts,h=20);
	for(i=[0:11])
	{
		if(i%4==0)
		{
			rotate(a=[0,0,i*30]) translate([44,0,0]) #cylinder(d=screwHoleSize,h=30);
			rotate(a=[0,0,i*30]) translate([44,0,8]) #cylinder(d=8,h=30);
		}
		else
		{
			rotate(a=[0,0,i*30]) translate([44,0,0]) #cylinder(d=screwHoleSize,h=2);
		}
	}
	
}

module screwHolders()
{
	translate([7-1.75,7-1.75,3]) #cylinder(d=6,h=5);
	translate([-7+1.75,-7+1.75,3]) #cylinder(d=6,h=5);
	translate([20,20,3]) #cylinder(d=10,h=20);
	translate([-20,20,3]) #cylinder(d=10,h=20);
	translate([-20,-20,3]) #cylinder(d=10,h=20);
	translate([20,-20,3]) #cylinder(d=10,h=20);
}

module wallMountHoles()
{
	rotate([0,90,0]) union()
	{
		cylinder(d=4.5,h=68);
		translate([0,0,68]) cylinder(d=6,h=12);
	}
}

module wallMount()
{
	rotate([0,90,0]) union()
	{
		difference()
		{
			cylinder(d=8,h=68);
			cylinder(d=4.5,h=68);
		}
		translate([0,0,68]) difference()
		{
			cylinder(d=10,h=12);
			cylinder(d=6,h=12);
		}
	}
}


union()
{
difference()
{
	bottom();
	subtracts();
	translate([-27,20,7]) wallMountHoles();
	translate([-27,-20,7]) wallMountHoles();
}
difference()
{
	screwHolders();
	screwHoles();
	translate([-27,20,7]) wallMountHoles();
	translate([-27,-20,7]) wallMountHoles();
}
difference()
{
	union()
	{
		translate([-27,20,7]) wallMount();
		translate([-27,-20,7]) wallMount();
	}
	screwHoles();
}
}
