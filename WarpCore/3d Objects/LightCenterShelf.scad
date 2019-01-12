$fn=50;
outerWidth=57;
wallWidth=4;
tabWidth=4;
hd=0.5; // holder distance
height = 5;

shelfHeight=3;
shelfWidth=100;

module hole()
{
	translate([0,0,-1]) cylinder(d=outerWidth-(wallWidth*2),h=tabWidth*3);
	
}

module shelf()
{
	translate([0,0,shelfHeight+1]) cylinder(d=shelfWidth,h=shelfHeight);
	cylinder(d=outerWidth+wallWidth,h=shelfHeight+tabWidth);
}

module mainCube()
{
	innerWidth = outerWidth - wallWidth;
	offset = (outerWidth - innerWidth) /2;
	
	difference()
	{
		union()
		{
			cylinder(d=outerWidth,h=height);
		}
		cylinder(d=innerWidth,h=height);
		translate([0,0, height - tabWidth]) difference()
		{
			cylinder(d=outerWidth+0.5,h=tabWidth);
			cylinder(d=outerWidth-(wallWidth/2)+1,h=tabWidth);
		}
		
	}
	
}
module cut()
{
	translate([shelfWidth/2 * -1,0,0]) cube([shelfWidth,shelfWidth,shelfHeight+tabWidth+2]);
 rotate([0,0,-55]) cube([shelfWidth,shelfWidth,shelfHeight+tabWidth+2]);
}

difference()
{
shelf();
mainCube();
	hole();
cut();
}