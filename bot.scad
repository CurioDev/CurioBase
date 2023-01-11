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
 color("#F80") linear_extrude(height=3,center=true) translate([-43,-4.5]) import_dxf("bot_phoneholder.dxf");
 color("#8FF") translate([0,81,6+1.5]) roundedrect(80,162,10,12);
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
    translate([34/2,0,0]) cylinder(r=3.8/2,h=5, center=true);
    translate([-34/2,0,0]) cylinder(r=3.8/2, h=5, center=true);
   }
  }
}
 
translate([0,10.5,7]) rotate([83,0,0]) phone();
 
translate([42,0,0]) rotate([90,0,90]) side();
translate([-42,0,0])  rotate([90,0,90]) side();
 
translate([45,50,25])  rotate([90,0,90]) wheel();
translate([-45,50,25])  rotate([90,0,90]) wheel();

translate([0,0,14])  castor();

//roundedrect(80,162,10,12);