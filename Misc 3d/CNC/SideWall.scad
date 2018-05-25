use <PowerHoles.scad>;
use <Bottom.scad>;
use <Piller.scad>;

module sideWall()
{
	difference()
	{
		union()
		{
			cube([getBottomX(),getWallHeight(),getWallThickness()]);
		}
		translate([getWallThickness()+(getPillerThickness()/2),zOffset2(),-1]) boltHole();
		translate([(getPillerThickness()/2)+getWallThickness(),getWallHeight()  - zOffset2(),-1]) boltHole();
		translate([getBottomX()-(getPillerThickness()/2)-getWallThickness(), zOffset2(),-1]) boltHole();
		translate([getBottomX()-(getPillerThickness()/2)-getWallThickness(),getWallHeight() - zOffset2(),-1]) boltHole();
	}
}

sideWall();