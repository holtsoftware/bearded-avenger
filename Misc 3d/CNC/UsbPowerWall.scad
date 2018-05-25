use <Bottom.scad>;
use <Piller.scad>;
use <SmallWall.scad>;

$fn=500;
$powerSwitchSize=13;
$passThrewHole=16;
$usbWidth=13.5;
$usbHeight=4.8;
$usbLength=12;
$screwSize=2.3;
$usbHoleZ=8;

module powerPlug()
{
	$pWidth=27.5;
	$pHeight=19.5;
	$pLength=14;
	$pHoleOffset=6.5;
	$pHoleD=4;

	translate([$pHoleOffset+($pHoleD/2),0,0]) union()
	{
		translate([$pHoleOffset*-1,$pHeight/2,0]) cylinder(d=$pHoleD,h=$pLength);
		translate([$pHoleOffset + $pWidth,$pHeight/2,0]) cylinder(d=$pHoleD,h=$pLength);
		cube([$pWidth,$pHeight,$pLength]);
	}
}

module usbPowerWall()
{
	difference()
	{
		smallWall();
		translate([getPillerThickness()*3,getWallHeight()/2,-1]) cylinder(d=$powerSwitchSize,h=getWallThickness()*2);
		translate([(getBottomY()/2) - getWallThickness() - (getPillerThickness()*2) - $usbWidth, zOffset1(),0]) cube([$usbWidth,$usbHeight,$usbLength]);
		translate([getPillerThickness()*2,zOffset1(),-1]) powerPlug();
		translate([(getBottomY()/2)* 0.75,getWallHeight() * .8,-1]) cylinder(d=$passThrewHole,h=getWallThickness()*2);
	}
	translate([(getBottomY()/2) - getWallThickness() - (getPillerThickness()*2) - $usbWidth, zOffset1()-$usbHeight,0]) 
	difference()
	{
		cube([$usbWidth,$usbHeight,$usbLength]);
		translate([2,-1,$usbHoleZ]) rotate([-90,0,0]) cylinder(d=$screwSize,h=$usbWidth);
		translate([$usbWidth-2,-1,$usbHoleZ]) rotate([-90,0,0]) cylinder(d=$screwSize,h=$usbWidth);
	}
}

difference()
{
	usbPowerWall();
//	translate([0,0,1]) cube([getBottomY()/2-getWallThickness(),getWallHeight(),getWallThickness()*8]);
}