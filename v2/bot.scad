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
     color("#8FF") translate([0,87+offset,6+1.5]) roundedrect(70,162,10,12); // phone! 80,162
}
module motor() {
    translate([0,0,0]) rotate([90,0,0]) import("objs/motor-tt.stl");
}
module wheel() {
    translate([0,0,0]) rotate([90,0,0]) import("objs/wheel.stl");
}
module baseplate() { 
 color("#8F0") linear_extrude(height=1.6,center=true) rotate([0,0,90]) import("bot_baseplate_flat.svg");
}
module sideplate() { 
 color("#840") rotate([90,90,0]) linear_extrude(height=3,center=true) rotate([0,0,90]) import("bot_side_flat.svg");
}

module motorfrontplate() { 
 color("#F80") rotate([0,90,0]) linear_extrude(height=1.6,center=true) rotate([0,0,90]) import("bot_motorfront_flat.svg");
}

module motorbackplate() { 
 color("#F80") rotate([0,90,0]) linear_extrude(height=1.6,center=true) rotate([0,0,90]) import("bot_motorback_flat.svg");
}
 
module phonebackplate() { 
 color("#0F8") rotate([0,90,0]) linear_extrude(height=3,center=true) rotate([0,0,90]) import("bot_phone_back.svg");
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
 

baseplate(); 
translate([29,0,0]) motorfrontplate();
translate([-30.5,0,0]) motorbackplate();
translate([0,50,0]) sideplate();
translate([0,-50,0]) sideplate();

// phone vertical
//translate([36,0,0]) phonebackplate();
//translate([36,0,30]) rotate([90,0,90])phone();

// phone angled
translate([52,0,0]) rotate([0,-30,0]) phonebackplate();
translate([38,0,25]) rotate([60,0,90])phone();
translate([66,0,8]) cube([3,105,6],center=true)
 
 //cube(10, center=true);
translate([0,-40,12]) motor();
translate([0,40,12]) rotate([180,0,0]) motor();
translate([-18,70,12]) wheel();
translate([-18,-70,12]) rotate([180,0,0]) wheel();
translate([82,0,-0.8]) rotate([0,0,90])  castor();
 
