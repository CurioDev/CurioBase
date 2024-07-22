SIDETHICKNESS = 3;
PCBTHICKNESS = 1.6;
WIDTH = 84;

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
     color("#8FF") translate([0,87+offset,6+1.5]) roundedrect(70,162,10,9); // phone! 80,162
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
module topplate() { 
 color("#480") linear_extrude(height=1.6,center=true) rotate([0,0,90]) import("bot_topplate_flat.svg");
}
module sideplate() { 
 color("#840") rotate([90,90,0]) linear_extrude(height=SIDETHICKNESS,center=true) rotate([0,0,90]) import("bot_side_flat.svg");
}

module bumper() { 
 color("#f40") linear_extrude(height=SIDETHICKNESS,center=true) rotate([0,0,90]) import("bot_bumper.svg");
}

module motorfrontplate() { 
 color("#F80") rotate([0,90,0]) linear_extrude(height=PCBTHICKNESS,center=true) rotate([0,0,90]) import("bot_motorfront_flat.svg");
}

module motorbackplate() { 
 color("#F80") rotate([0,90,0]) linear_extrude(height=PCBTHICKNESS,center=true) rotate([0,0,90]) import("bot_motorback_flat.svg");
}
 
module phonebackplate() { 
 color("#0F8") rotate([0,90,0]) linear_extrude(height=SIDETHICKNESS,center=true) rotate([0,0,90]) import("bot_phone_back.svg");
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
//translate([0,0,25]) topplate();

translate([29,0,0]) motorfrontplate();
translate([-30.5,0,0]) motorbackplate();
translate([0,(WIDTH+SIDETHICKNESS-1)/2,0]) sideplate();
translate([0,-(WIDTH+SIDETHICKNESS+1)/2,0]) sideplate();

// phone vertical
//translate([36,0,0]) phonebackplate();
//translate([36,0,30]) rotate([90,0,90])phone();

// phone angled
//translate([38.54,0,1.2]) rotate([0,-10,0]) phonebackplate();
//translate([46,0,1.5]) rotate([0,-25,0]) phonebackplate();
//translate([56,0,2]) rotate([0,-40,0]) phonebackplate();
//translate([36,0,25]) rotate([60,0,90])phone();
//translate([66,0,8]) cube([3,WIDTH+5,4],center=true);
 
 //cube(10, center=true);
translate([0,9.5-(WIDTH/2),12]) motor();
translate([0,(WIDTH/2)-9.5,12]) rotate([180,0,0]) motor();
//translate([-18,23+WIDTH/2,12]) wheel();
//translate([-18,-23-WIDTH/2,12]) rotate([180,0,0]) wheel();
translate([70,0,-0.8]) rotate([0,0,90])  castor();

translate([-33,5.5,2.5]) bumper();
translate([-33,-5.5,2.5]) rotate([180,0,0]) bumper();
 
