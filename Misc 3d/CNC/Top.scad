use <Bottom.scad>;

$fn=500;

module topAttachHole(bottomZ)
{
	translate([0,0,-1]) #cylinder(d=5.5,h=bottomZ*3);
	translate([0,0,bottomZ]) #cylinder(d=9,h=bottomZ*3);
}

module topBase(bottomZ)
{
	cube([getBottomX(),getBottomY()/2,bottomZ]);
	translate([getWallThickness(),getWallThickness(),0]) cube([getWallThickness(),(getBottomY()/2)-getWallThickness(),getPillerThickness()]);
	translate([getBottomX()-getPillerThickness()+getWallThickness(),getWallThickness(),0]) cube([getWallThickness(),(getBottomY()/2)-getWallThickness(),getPillerThickness()]);
	translate([getWallThickness(),getWallThickness(),0]) cube([getBottomX()-(getWallThickness()*2),getPillerThickness(),getPillerThickness()]);
}

module topBoltHole(bottomZ)
{
	translate([0,0,(bottomZ-1)*-1]) boltHole();
}


module topFront(bottomZ=getBottomZ())
{
	difference()
	{
		topBase(bottomZ);
		translate([(getPillerThickness()/2)+getWallThickness(),(getPillerThickness()/2)+getWallThickness(),0]) #topBoltHole(bottomZ);
		translate([(getPillerThickness()/2)+getWallThickness(),(getBottomY()/2)-(getPillerThickness()/2),0]) #topBoltHole(bottomZ);
		translate([getBottomX()-((getPillerThickness()/2)+getWallThickness()),(getPillerThickness()/2)+getWallThickness(),0]) #topBoltHole(bottomZ);
		translate([getBottomX()-(getPillerThickness()/2)-getWallThickness(),(getBottomY()/2)-(getPillerThickness()/2),0]) #topBoltHole(bottomZ);
		translate([30,10,0]) topAttachHole(bottomZ);
		translate([getBottomX()-30,10,0]) topAttachHole(bottomZ);
	}
	translate([(getBottomX()*0.25)-(getConnectorWidth()/2),(getBottomY()/2)-(getConnectorLength()/2),0]) #cube([getConnectorWidth(), getConnectorLength(),bottomZ]);
	translate([(getBottomX()*0.75)-(getConnectorWidth()/2),(getBottomY()/2)-(getConnectorLength()/2),0]) #cube([getConnectorWidth(), getConnectorLength(),bottomZ]);
}

module topBack(bottomZ=getBottomZ())
{
	difference()
	{
		topBase(bottomZ);
		translate([(getPillerThickness()/2)+getWallThickness(),(getPillerThickness()/2)+getWallThickness(),0]) #topBoltHole(bottomZ);
		translate([(getPillerThickness()/2)+getWallThickness(),(getBottomY()/2)-(getPillerThickness()/2),0]) #topBoltHole(bottomZ);
		translate([getBottomX()-((getPillerThickness()/2)+getWallThickness()),(getPillerThickness()/2)+getWallThickness(),0]) #topBoltHole(bottomZ);
		translate([getBottomX()-(getPillerThickness()/2)-getWallThickness(),(getBottomY()/2)-(getPillerThickness()/2),0]) #topBoltHole(bottomZ);
		translate([30,10,0]) topAttachHole(bottomZ);
		translate([getBottomX()-30,10,0]) topAttachHole(bottomZ);
		translate([(getBottomX()*0.25)-(getConnectorWidth()/2),(getBottomY()/2)-(getConnectorLength()/2),0]) #cube([getConnectorWidth(), getConnectorLength(),bottomZ]);
		translate([(getBottomX()*0.75)-(getConnectorWidth()/2),(getBottomY()/2)-(getConnectorLength()/2),0]) #cube([getConnectorWidth(), getConnectorLength(),bottomZ]);
	}
}

topBack(3);
//topFront(3);
