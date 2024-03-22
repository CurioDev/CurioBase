 BOTW=100; // bot width
 BOTWH=BOTW/2; // half bot width
 
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
 color("#F80") linear_extrude(height=3,center=true) translate([-(BOTWH+1.5),offset]) import_dxf("bot_phoneholder.dxf");
     color("#8FF") translate([0,87+offset,6+1.5]) roundedrect(70,162,10,12); // phone! 80,162
     color("#F80") translate([-43,offset+4.5,11.5]) rotate([-90,0,0]) linear_extrude(height=3,center=true) import_dxf("bot_phonebase.dxf");
     color("#8FF") translate([-BOTWH,0,0]) rotate([0,90,0]) translate([-7.5,-7.5]) linear_extrude(height=3,center=true) import_dxf("bot_phone_axle.dxf");
     color("#8FF") translate([BOTWH,0,0]) rotate([0,90,0]) translate([-7.5,-7.5]) linear_extrude(height=3,center=true) import_dxf("bot_phone_axle.dxf");
 }
 
 module pcb() { 
     SX=38/2;SY=25/2;
     difference() {
       color("#8F8") translate([0,0,0.8]) roundedrect(46,33,2,1.6); 
       translate([SX,SY,0]) cylinder(r=1.5,h=5,center=true);
       translate([SX,-SY,0]) cylinder(r=1.5,h=5,center=true);
       translate([-SX,SY,0]) cylinder(r=1.5,h=5,center=true);
       translate([-SX,-SY,0]) cylinder(r=1.5,h=5,center=true);
     };
 } 
 
 module battery() { 
   difference() {
     union() {
     color("#F44") translate([0,0,17.5/2]) rotate([90,0,90])  roundedrect(26.5,17.5,4,46); 
     color("#822") translate([(46+7)/2,0,17.5/2]) rotate([90,0,90])  roundedrect(25,12,6,7); 
     }
     color("#000") translate([-46/2,0,4]) rotate([90,0,90])  roundedrect(8,3,1,7); 
   }
 } 
 
module castorholder() { 
 color("#F80") linear_extrude(height=3,center=true) translate([-(BOTWH+1),-15]) import_dxf("bot_castorholder.dxf");
 }
 
module topplate() { 
 color("#F80") linear_extrude(height=3,center=true) translate([-(BOTWH+1),-15]) import_dxf("bot_topplate.dxf");
 }
 
module baseplate() { 
 color("#F80") linear_extrude(height=3,center=true) rotate([0,0,180]) translate([-(BOTWH+1),-70]) import_dxf("bot_baseplate.dxf");
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

translate([0,7,45]) rotate([60,0,0]) phone();
//translate([0,10,30]) cube([120,2,2],center=true); // pivot
 

translate([BOTWH,0,0]) rotate([90,0,90]) side();
translate([-BOTWH,0,0])  rotate([90,0,90]) side();
 

translate([0,-33,14])  castor();
translate([0,-33,14+1.5]) castorholder();
translate([0,30,35+1.5]) topplate();
translate([0,10,14+1.5]) baseplate();

WHEELX=60;
WHEELY=30;
translate([-BOTWH+1.5,WHEELX,WHEELY]) rotate([90,-45,-90])  stepper();
translate([BOTWH-1.5,WHEELX,WHEELY]) rotate([90,45,90])  stepper();
translate([0,WHEELX+3,14+3])  pcb();
translate([-25,WHEELX-36,14+3.2])  battery();
//translate([7,WHEELX-36,30])  cylinder(r=1.5,h=40,center=true); // screw to hold battery in

translate([BOTWH+4,WHEELX,WHEELY])  rotate([90,0,90]) wheel();
//translate([-(BOTWH+4),WHEELX,WHEELY])  rotate([90,0,90]) wheel();


//roundedrect(80,162,10,12);