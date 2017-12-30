$fn=500;
width=17;
outerWidth=57;
wallWidth=2;
tabWidth=2;
hd=0.5; // holder distance

module centerCube()
{
	hull()
	{
		translate([2.25,2.25,18]) cube([10,10,1]);
		cube([14.5,14.5,5]);
	}
	
}


module mainCube()
{
	diff = outerWidth - width;
	offset = diff/2;
	innerWidth = width - (wallWidth*2);
	
	difference()
	{
		union()
		{
			translate([outerWidth/2,outerWidth/2,0]) cylinder(d=outerWidth,3);
		}
		
		
		translate([offset+1.25,offset+1.25,0]) centerCube();
		
	}
	
}

mainCube();



