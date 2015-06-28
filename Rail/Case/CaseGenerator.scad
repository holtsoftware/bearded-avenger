length=150;
height=45;
generateTrack=false;
bottomOnly=false;
topOnly=false;

// dont modify numbers below

width=35;

if(length <= 100){
    length = 100;
}

module bottom(){
    translate([2,0,0]) cube([width-4,length,4]);
    // 1.33 /2 = 0.665
    // .66 /2 = .33
    difference()
    {
    union()
    {
        color("orange") translate([11.82,0,4]) cube([1.2,length,3.7]);
    color("orange") translate([21.78,0,4]) cube([1.2,length,3.75]);
    }
    if(!generateTrack){
        translate([0,0,4]) cube([width,125.5,3.75]);
    }
}
    if(!generateTrack){
        color("blue") translate([9.275, 7.9, 0]) cube([2.45, 2.45, 6]);
        color("blue") translate([23.075, 7.9, 0]) cube([2.45, 2.45, 6]);

        color("blue") translate([9.275, 95.85, 0]) cube([2.45, 2.45, 6]);
        color("blue") translate([23.075, 95.85, 0]) cube([2.45, 2.45, 6]);
    }
}

module sideHole()
{
    color("green") resize([5,10,height-12]) rotate([0,90,0]) cylinder(d=10, h=5, $fn=100);
}

module side(){
    number=floor(length/20);
    
    difference()
    {
    union(){
    color("blue") cube([2,length,height]);
      translate([0,5,height]) stackCircle();
        translate([0,75,height]) stackCircle();
    }
        translate([0, -8,0]) union()
        {
            for(i=[1:number]){
                translate([-1, 20 * i,height/2]) sideHole();    
            }
        }
    
        
        translate([-0.75,5,0]) stackCircle(4.5);
        translate([-0.75,75,0]) stackCircle(4.5);
    }
}

module back(){
    color("red") translate([0,length-2,0]) cube([width,2,height/2]);
}

module supports(){
    translate([2,0,height-3]) color("purple") rotate([-90,0,0]) cylinder(d=4,h=8,$fn=100);
    translate([width-2,0,height-3]) color("purple") rotate([-90,0,0]) cylinder(d=4,h=8,$fn=100);
    
    translate([2,(length/2) - 4,height-3]) color("purple") rotate([-90,0,0]) cylinder(d=4,h=8,$fn=100);
    translate([width-2,(length/2) - 4,height-3]) color("purple") rotate([-90,0,0]) cylinder(d=4,h=8,$fn=100);
}

module latch(){
    difference()
    {
        union()
        {
    cube([2.5,2.5,3]);
    translate([0,1,-.4]) rotate([0,90,0]) cylinder(d=4,h=2.5,$fn=100);
        }
    translate([0,-1.1,-2])color("green") cube([2.5,1,5]);
    }
}

module top(){
    
    if(topOnly){
       translate([2.25,0,height-3]) cube([width-4.5,length,2]);
    }
    else{
        translate([2,0,height-3]) cube([width-4,length,2]);
    }
    
    if(topOnly){
       translate([0,length-3,height-2]) rotate([0,90,0]) cylinder(d=2,h=width,$fn=100);
    }
    else{
        translate([0,length-3,height-2]) rotate([0,90,0]) cylinder(d=2.75,h=width,$fn=100);
    }
    
    if(topOnly){
        translate([2.25,0, height-4]) latch();
        translate([width-4.75,0,height-4]) latch();
    }
    else{
        translate([2,0,height-4]) latch();
        translate([width-4.5,0,height-4]) latch();
    }
}

module stackCircle(size=2){
    color("orange") resize([size,8,8]) rotate([-0,90,0]) cylinder(d=4,h=2,$fn=100);
}

if(!topOnly)
{
bottom();
}
if(!bottomOnly && !topOnly)
{
    difference()
    {
    union()
    {
side();
translate([width -2,0,0]) side();
    back();
    supports();
    }
    top();
}
}
if(topOnly)
{
top();
}