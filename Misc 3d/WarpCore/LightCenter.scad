$fn=50;
outerWidth=57;
wallWidth=4;
tabWidth=4;
hd=0.5; // holder distance
height = 43;



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
			cylinder(d=outerWidth-(wallWidth/2),h=tabWidth);
		}
		
	}
	
}

mainCube();



