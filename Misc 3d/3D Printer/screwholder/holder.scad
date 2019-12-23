module holder()
{
    difference()
    {
        union()
        {
            color("blue") cube([54.7,22.05,25.05]);
            color("blue") cube([54.7,35.05,3]);
            color("purple") polyhedron(points=[
                [13,22.05,3], // 0
                [13,22.05,25.05], // 1
                [13,35.05,3], // 2
                [41.7,22.05,3], // 3
                [41.7,22.05,25.05], // 4
                [41.7,35.05,3] // 5
            ],
            faces=[
                [0,2,5,3],
                [0,3,4,1],
                [1,4,5,2],
                [1,2,0],
                [4,3,5]
            ]);
        }
        #color("red") translate([-1,-1,3]) cube([60,20.05,19.05]);
        #color("yellow") translate([6.225,28.5,-1]) union()
        {
            cylinder(d=5.25,h=27);
            translate([42.25,0,0]) cylinder(d=5.25,h=27);
        }

        #color("yellow") translate([14.6,9.525,-1]) union()
        {
            cylinder(d=4.25,h=27);
            translate([25.5,0,0]) cylinder(d=4.25,h=27);
        }
    }
}
holder();