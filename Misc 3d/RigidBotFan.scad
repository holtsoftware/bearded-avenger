
cube([80,147,0.3]);

translate([0,0,.3]) union()
{
difference()
{
cube([80,147,3]);
translate([40,40,0]) cylinder(h=3, d=78);
translate([4.5,4.5,0]) cylinder(h=3, d=5);
translate([75.5, 4.5,0]) cylinder(h=3,d=5);
translate([4.5,75.5, 0]) cylinder(h=3,d=5);
translate([75.5,75.5, 0]) cylinder(h=3,d=5);
translate([17.5,95,0]) cube([45,52,3]);
translate([67.5,140,0]) union()
{
	cylinder(h=2,d=8);
	cylinder(h=3,d=3);
}
translate([13.5, 140,0]) union()
{
	cylinder(h=2,d=7);
	cylinder(h=3,d=3);
}

translate([67.5,120,0]) union()
{
	cylinder(h=2,d=8);
	cylinder(h=3,d=3);
}

translate([67.5,87,0]) union()
{
	cylinder(h=3,d=8);
}
}
difference()
{
rotate(a=[12.6,0,0]) cube([80,82,3]);
translate([4.5,4.5,0]) cylinder(h=10, d=5);
translate([75.5, 4.5,0]) cylinder(h=10,d=5);
translate([4.5,75.5, 0]) cylinder(h=10,d=5);
translate([75.5,75.5,0]) cylinder(h=10,d=5);
}
difference()
{
cube([3,80,18]);
translate([0,0,3]) rotate(a=[12.6,0,0]) cube([3,82,21]);
translate([4.5,4.5,0]) cylinder(h=10, d=5);
translate([75.5, 4.5,0]) cylinder(h=10,d=5);
translate([4.5,75.5, 0]) cylinder(h=10,d=5);
translate([75.5,75.5,0]) cylinder(h=10,d=5);
}

translate([77,0,0]) difference()
{
cube([3,80,18]);
translate([0,0,3]) rotate(a=[12.6,0,0]) cube([3,82,21]);
translate([0,4.5,0]) cylinder(h=10,d=5);
translate([-1.5,75.5,0]) cylinder(h=10,d=5);
}

translate([39.5,0,0]) difference()
{
cube([1,80,18]);
translate([0,0,3]) rotate(a=[12.6,0,0]) cube([1,82,21]);
}

translate([58.25,0,0]) difference()
{
cube([1,80,18]);
translate([0,0,3]) rotate(a=[12.6,0,0]) cube([1,82,21]);
}

translate([18.75,0,0]) difference()
{
cube([1,80,18]);
translate([0,0,3]) rotate(a=[12.6,0,0]) cube([1,82,21]);
}
}


