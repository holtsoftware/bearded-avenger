$powerHoleX=151;
$powerHoleY=25;

module powerScrewHole()
{
	translate([0,0,-1]) cylinder(d=4.5,h=10);
}

function getPowerHoleX() = $powerHoleX;
function getPowerHoleY() = $powerHoleY;

module powerHoles()
{
	powerScrewHole();
	translate([0,$powerHoleY,0]) powerScrewHole();
	translate([$powerHoleX,0,0]) powerScrewHole();
	translate([$powerHoleX,$powerHoleY,0]) powerScrewHole();
}

powerHoles();