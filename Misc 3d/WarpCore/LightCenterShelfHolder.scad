$fn=50;

shelfWidth=100;

module shelf()
{
	
	difference()
	{
		union()
		{
		cylinder(d=shelfWidth,h=2);
		cylinder(d=shelfWidth-6,h=12);
		}
		cylinder(d=shelfWidth-10,h=12);
	}
}

module rod()
{
	translate([0,0,6]) cube([shelfWidth+4,15,12],center=true);
}

module rods()
{
	difference()
	{
		cylinder(d=(shelfWidth),h=12);
		cylinder(d=shelfWidth-4,h=12);
		for(i=[0:20:160])
		{
			rotate([0,0,i]) rod();
		}
	}
}

module cut()
{
	rotate([0,0,1]) translate([0,shelfWidth/2 * -1,0]) cube([shelfWidth,shelfWidth,12]);
	rotate([0,0,9]) translate([shelfWidth/2 * -1,0,0]) cube([shelfWidth,shelfWidth,12]);
}

difference()
{
union()
{
	shelf();
	rods();
}
cut();
}