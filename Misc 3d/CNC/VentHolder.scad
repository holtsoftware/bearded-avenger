use <Bottom.scad>;
use <FanSideWall.scad>;

module ventHolder()
{
	difference()
	{
		cube([getFanSize(),getFanSize(),2]);
		fanHoles(getThroughHoleSize());
	}
}

$fn=500;
ventHolder();