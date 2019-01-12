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
		translate([2.25,2.25,0]) cube([10,10,1]);
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
			translate([outerWidth/2,outerWidth/2,0]) cylinder(d=outerWidth,4.25);
			color("blue") translate([offset,offset,0]) cube([width,width,7]);
		}
		
		
		translate([offset+1.25,offset+1.25,0]) centerCube();
		//translate([offset-wallWidth,offset+(wallWidth),6]) rotate([0,0,-45]) cube([wallWidth*3,wallWidth*5,15]);
		translate([offset,offset,4.25]) difference()
		{
		cube([width,width,3]);
		translate([wallWidth-0.5, wallWidth-0.5,0]) cube([width-(wallWidth*2)+1,width-(wallWidth*2)+1,3]);
		}
		translate([(outerWidth/2)-5,0,0]) cube([10,34,8]);
		
	}
	
}

mainCube();



