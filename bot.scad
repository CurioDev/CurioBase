 // centered rounded rect
 module roundedrect(x,y,r,t) {
   ix = x/2 - r;
   iy = y/2 - r;
   union() {
    translate([0,0,0]) cube([x-r*2,y,t], center=true);
    translate([0,0,0]) cube([x,y-r*2,t], center=true);
    translate([ix,iy,0]) cylinder(r=r,h=t, center=true);
    translate([-ix,iy,0]) cylinder(r=r,h=t, center=true);
    translate([ix,-iy,0]) cylinder(r=r,h=t, center=true);
    translate([-ix,-iy,0]) cylinder(r=r,h=t, center=true);
   }
 }
 
 module phone() { 
     offset = -35;
 color("#F80") linear_extrude(height=3,center=true) translate([-46,offset]) import_dxf("bot_phoneholder.dxf");
     color("#8FF") translate([0,87+offset,6+1.5]) roundedrect(70,162,10,12); // 80,162
     color("#F80") translate([-43,offset+4.5,11.5]) rotate([-90,0,0]) linear_extrude(height=3,center=true) import_dxf("bot_phonebase.dxf");
 }
 
 module castorholder() { 
 color("#F80") linear_extrude(height=3,center=true) translate([-46,-15]) import_dxf("bot_castorholder.dxf");
 }
 
  module baseplate() { 
 color("#F80") linear_extrude(height=3,center=true) rotate([0,0,180]) translate([-46,-30]) import_dxf("bot_baseplate.dxf");
 }
 
module side() { 
 linear_extrude(height=3,center=true) translate([0,0]) import_dxf("bot_side.dxf");
}
 
module wheel() { 
 color("#FF0") linear_extrude(height=3,center=true) translate([-30,-30]) import_dxf("bot_wheel.dxf");
}

module castor() { // descends 14mm
  color("#FF8") difference() {
   union() {
    translate([0,0,-1.25]) roundedrect(44,28, 10, 2.5);
    translate([0,0,5-14]) sphere(r=5);
       translate([0,0,-4]) cylinder(r=19.6/2,h=5,center=true);
   }; union() {
    translate([34/2,0,0]) cylinder(r=3.8/2,h=5, center=true); // 3.8mm holes
    translate([-34/2,0,0]) cylinder(r=3.8/2, h=5, center=true);
   }
  }
}
 
module stepper() {
  color("#F00") translate([0,-8,-19]) difference() { union() {
    cylinder(r=28/2, h=19);
    translate([0,8,19]) cylinder(r=9/2, h=1.5);
    translate([0,8,19]) cylinder(r=5/2, h=8);   // shaft
    translate([35/2,0,18]) cylinder(r=7/2, h=1);
    translate([-35/2,0,18]) cylinder(r=7/2, h=1);
    translate([0,0,18.5]) cube([35,7,1],center=true);
    translate([0,-14,19/2]) cube([15,6,19],center=true);
  }; union() {
    translate([35/2,0,17]) cylinder(r=4/2, h=3);
    translate([-35/2,0,17]) cylinder(r=4/2, h=3);
  }
  }
}

translate([0,10,40]) rotate([45,0,0]) phone();
//translate([0,10,30]) cube([120,2,2],center=true); // pivot
 

//translate([45,0,0]) rotate([90,0,90]) side();
translate([-45,0,0])  rotate([90,0,90]) side();
 

translate([0,-33,14])  castor();
translate([0,-33,14+1.5]) castorholder();
translate([0,30,32+1.5]) castorholder(); // just the top plate
translate([0,10,14+1.5]) baseplate();

WHEELX=60;
WHEELY=30;
translate([-45+1.5,WHEELX,WHEELY]) rotate([90,0,-90])  stepper();
translate([45-1.5,WHEELX,WHEELY]) rotate([90,0,90])  stepper();
//translate([49,WHEELX,WHEELY])  rotate([90,0,90]) wheel();
translate([-49,WHEELX,WHEELY])  rotate([90,0,90]) wheel();


//roundedrect(80,162,10,12);