$fn=500;

$wallWidth = 3;
$innerWidth = 99;
$innerHeight = 42.5;
$length = 120;
$pWidth=27.5;

module powerPlug()
{
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

difference()
{
	cube([$innerWidth+($wallWidth*2), $length+$wallWidth, $innerHeight+($wallWidth*2)]);
	#translate([$wallWidth,$wallWidth,$wallWidth]) cube([$innerWidth, $length, $innerHeight]);
	#translate([9.5+$wallWidth,$length-10,-1]) cylinder(d=3,h=10);
	#translate([$innerWidth + $wallWidth - 9.5,$length-10,-1]) cylinder(d=3, h=10);
	#translate([$innerWidth - $wallWidth,$length-46.5,$wallWidth+20.5]) rotate([0,90,0]) cylinder(d=3,h=10);
	#translate([($innerWidth/2)-($pWidth/2)-7,5,($innerHeight/2)-$wallWidth-5]) rotate([90,0,0]) powerPlug();
	#translate([($innerWidth/2)+$wallWidth+9.75,20,$innerHeight]) cylinder(d=6,h=10);
	#translate([($innerWidth/2)+$wallWidth-9.75,20,$innerHeight]) cylinder(d=6,h=10);
	#translate([($innerWidth/2)+$wallWidth,30,$innerHeight]) cylinder(d=8, h=10);

	#translate([$wallWidth+10,$wallWidth+5,$innerHeight]) cylinder(d=2.5,h=10);
	#translate([$innerWidth+$wallWidth-10,$wallWidth+5,$innerHeight]) cylinder(d=2.5,h=10);
	#translate([$innerWidth+$wallWidth-10,$length+$wallWidth - 30,$innerHeight]) cylinder(d=2.5,h=10);
	#translate([$wallWidth+10,$length+$wallWidth - 30,$innerHeight]) cylinder(d=2.5,h=10);
}


