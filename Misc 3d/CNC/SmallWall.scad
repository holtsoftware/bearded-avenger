use <PowerHoles.scad>;
use <Bottom.scad>;
use <Piller.scad>;

module smallWall()
{
	difference()
	{
		union()
		{
			cube([getBottomY()/2-getWallThickness(),getWallHeight(),getWallThickness()]);
		}
		translate([(getPillerThickness()/2),zOffset1(),-1]) boltHole();
		translate([(getPillerThickness()/2),getWallHeight()  - zOffset1(),-1]) boltHole();
		translate([(getBottomY()/2) - getWallThickness() - (getPillerThickness()/2), zOffset1(),-1]) boltHole();
		translate([(getBottomY()/2) - getWallThickness() - (getPillerThickness()/2),getWallHeight() - zOffset1(),-1]) boltHole();
	}
}

smallWall();