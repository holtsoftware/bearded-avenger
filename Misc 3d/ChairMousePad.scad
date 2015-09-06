
translate([98,98,0]) cylinder(d=196,h=5,$fn=1000);
translate([98,72.25,5]) difference()
{
    union()
    {
        cylinder(d=84.5,h=60,$fn=1000);
        cylinder(d=95.5,h=19,$fn=1000);
    }
cylinder(d=78.5,h=60,$fn=1000);
}
