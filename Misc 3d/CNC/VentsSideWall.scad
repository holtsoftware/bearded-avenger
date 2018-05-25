use <Bottom.scad>;
use <SideWall.scad>;
use <FanSideWall.scad>;

$fn=500;

difference()
{
	sideWall();
	translate([(getBottomX()*0.3)-(getFanSize()/2),(getWallHeight()/2)-(getFanSize()/2),0]) fanHoles(getHoleSize());
	translate([(getBottomX()*0.7)-(getFanSize()/2),(getWallHeight()/2)-(getFanSize()/2),0]) fanHoles(getHoleSize());
}