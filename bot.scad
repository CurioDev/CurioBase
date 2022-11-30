 module phone() { 
 linear_extrude(height=3,center=true) translate([-40,-197-5]) import_dxf("bot.dxf",layer="phone");
 }
 
 module side() { 
 linear_extrude(height=3,center=true) translate([-100,-297+80]) import_dxf("bot.dxf",layer="side");
 }
 
 
translate([0,10.5,7]) rotate([83,0,0])  color("#F80") phone();
 
translate([42,0,0]) rotate([90,0,90]) side();
translate([-42,0,0])  rotate([90,0,90]) side();