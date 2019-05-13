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
			translate([outerWidth/2,outerWidth/2,0]) cylinder(d=outerWidth,6);
			color("blue") translate([offset,offset,0]) cube([width,width,19]);
			translate([offset - tabWidth - hd,offset + (wallWidth*2),0 ])cube([tabWidth,tabWidth,8]);
			translate([offset + (wallWidth*2),offset - tabWidth - hd,0 ])cube([tabWidth,tabWidth,8]);
			translate([offset + width - tabWidth, offset - tabWidth - hd,0]) cube([tabWidth,tabWidth,8]);
			translate([offset - tabWidth - hd,offset + width - tabWidth,0]) cube([tabWidth,tabWidth,8]);
			translate([offset,offset + width + hd,0]) cube([tabWidth,tabWidth,8]);
			translate([offset + width + hd,offset,0]) cube([tabWidth,tabWidth,8]);
			translate([offset + width - tabWidth,offset + width + hd,0]) cube([tabWidth,tabWidth,8]);
			translate([offset + width + hd,offset + width - tabWidth,0]) cube([tabWidth,tabWidth,8]);
			translate([(outerWidth/2) - (width/2) + tabWidth + 1,(outerWidth/2) + (width/2) - tabWidth - 1,0]) cylinder(d=5.5,h=width);
			translate([(outerWidth/2) + (width/2) - tabWidth - 1,(outerWidth/2) - (width/2) + tabWidth + 1,0]) cylinder(d=5.5,h=width);
		}
		
		
		translate([(outerWidth/2) - (width/2) + tabWidth + 1,(outerWidth/2) + (width/2) - tabWidth - 1,0]) cylinder(d=3.5,h=width+3);
		translate([(outerWidth/2) + (width/2) - tabWidth - 1,(outerWidth/2) - (width/2) + tabWidth + 1,0]) cylinder(d=3.5,h=width+3);
		translate([offset+1.25,offset+1.25,0]) centerCube();
		translate([offset-wallWidth,offset+(wallWidth),6]) rotate([0,0,-45]) cube([wallWidth*3,wallWidth*5,15]);
		translate([offset,offset,16]) difference()
		{
			cube([width,width,3.5]);
			translate([wallWidth-0.5, wallWidth-0.5,0]) cube([width-(wallWidth*2)+1,width-(wallWidth*2)+1,3.5]);
		}
		//translate([-5,0,0]) rotate([0,0,-45]) cube([10,45,1]);
		
	}

	difference()
	{
		rods();
		translate([offset,offset,16]) difference()
		{
			cube([width,width,3.5]);
			translate([wallWidth-0.5, wallWidth-0.5,0]) cube([width-(wallWidth*2)+1,width-(wallWidth*2)+1,3.5]);
		}
	}
	
}

module rods()
{
	difference()
	{
		translate([(outerWidth/2) - (width/2) + tabWidth + 1,(outerWidth/2) + (width/2) - tabWidth - 1,5]) cylinder(d=5.5,h=width-3);
		translate([(outerWidth/2) - (width/2) + tabWidth + 1,(outerWidth/2) + (width/2) - tabWidth - 1,5]) cylinder(d=3.5,h=width-3);
	}
	difference()
	{
		translate([(outerWidth/2) + (width/2) - tabWidth - 1,(outerWidth/2) - (width/2) + tabWidth + 1,5]) cylinder(d=5.5,h=width-3);
		translate([(outerWidth/2) + (width/2) - tabWidth - 1,(outerWidth/2) - (width/2) + tabWidth + 1,5]) cylinder(d=3.5,h=width-3);
	}

}

mainCube();



