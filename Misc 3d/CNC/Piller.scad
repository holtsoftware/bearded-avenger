use <Bottom.scad>;

function zOffset1() = getPillerThickness() * 1.5;
function zOffset2() = getPillerThickness() * 2;

module singlePiller()
{
	difference()
	{
		union()
		{
			translate([0,0,getWallHeight()/2]) cube([getPillerThickness(), getPillerThickness(), getWallHeight()], center=true);
		}

		cylinder(d=getHoleSize(),h=getWallHeight());
		translate([0,getPillerThickness()/2,zOffset1()]) rotate([90,0,0]) cylinder(d=getHoleSize(),h=getPillerThickness());
		translate([getPillerThickness()/2 * -1,0,zOffset2()]) rotate([0,90,0]) cylinder(d=getHoleSize(),h=getPillerThickness());
		translate([0,getPillerThickness()/2,getWallHeight() - zOffset1()]) rotate([90,0,0]) cylinder(d=getHoleSize(),h=getPillerThickness());
		translate([getPillerThickness()/2 * -1,0,getWallHeight() - zOffset2()]) rotate([0,90,0]) cylinder(d=getHoleSize(),h=getPillerThickness());
	}
}

module doublePiller()
{
	union()
	{
		singlePiller();
		translate([getPillerThickness(),0,0]) singlePiller();
	}
}

//doublePiller();
singlePiller();
