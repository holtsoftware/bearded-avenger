$fn=500;
$moterX=42;
$moterY=42;
$moterZ=10;
$wallWidth=2;
$tabSize=10;
$screwSize=2.3;
$partHeight=14;
$raiseAmount=20;
$offset=32;

module moter()
{
	cube([($wallWidth*2)+$moterX,($wallWidth*2)+$moterY,($wallWidth)+$moterZ]);
}

module moterDifference()
{
	union()
	{
		translate([$wallWidth,$wallWidth,0]) cube([$moterX,$moterY,$moterZ]);
		translate([$tabSize+$wallWidth,0,0]) cube([$moterX-($tabSize*2),$moterY+($wallWidth*5), $moterZ]);
		translate([0,$tabSize+$wallWidth,0]) cube([$moterX+($wallWidth*2),$moterY-($tabSize*2), $moterZ]);
		translate([$wallWidth+($tabSize/2),0,$moterZ/2]) rotate([-90,0,0]) cylinder(d=$screwSize,h=$moterY+($wallWidth*2));
		translate([$wallWidth+$moterX-($tabSize/2),0,$moterZ/2]) rotate([-90,0,0]) cylinder(d=$screwSize,h=$moterY+($wallWidth*2));
		translate([0,$wallWidth+($tabSize/2),$moterZ/2]) rotate([0,90,0]) cylinder(d=$screwSize,h=$moterY+($wallWidth*2));
		translate([0,$wallWidth+$moterY-($tabSize/2),$moterZ/2]) rotate([0,90,0]) cylinder(d=$screwSize,h=$moterY+($wallWidth*2));
	}
}

module femaleLink()
{
	translate([33,20,0]) rotate([0,0,180]) import("femaleFixedLinkV2.stl");
}

module part()
{
	union()
	{
		difference()
		{
			hull()
			{
				translate([($moterX/2)+$wallWidth,$moterY+$wallWidth, $wallWidth+$moterZ+$raiseAmount]) cylinder(d=$moterX/2,h=$partHeight);
				//translate([($moterX*0.25)+$wallWidth,$moterY-($moterY/2)+($wallWidth*2),$wallWidth+$moterZ+$raiseAmount]) cube([$moterX/2,$moterY/2,$partHeight]);
				moter();
			}
			moterDifference();
		}
		translate([$wallWidth*4,$moterY+($wallWidth*2)+$offset,$wallWidth+$moterZ+$raiseAmount]) femaleLink();
		translate([($moterX*0.25)+$wallWidth,$moterY+($wallWidth*2),$wallWidth+$moterZ+$raiseAmount]) cube([$moterX/2,$offset,$partHeight]);
	}
}

difference()
{
	part();
	translate([$wallWidth+($moterX/2),5,$wallWidth+$moterZ+$raiseAmount+($partHeight/2)]) rotate([-90,0,0]) cylinder(d=12,h=$moterY+$offset+5);
	translate([0,$wallWidth+($moterY*0.9),$wallWidth+$moterZ+($partHeight/2)+15]) rotate([0,90,0]) cylinder(d=12,h=$moterY+$offset+5);
	translate([$wallWidth+($moterX/2),5,$wallWidth+$moterZ+$raiseAmount-6]) rotate([-90,0,0]) cylinder(d=12,h=$moterY+$offset+5);
	hull()
	{
	translate([$wallWidth+($moterX/2),$wallWidth+($moterY*0.9),0]) cylinder(d=12,h=$moterY+$offset+5);
	translate([$wallWidth+($moterX/2),$wallWidth+($moterY/2),0]) cylinder(d=12,h=$moterY+$offset+5);
	}
}