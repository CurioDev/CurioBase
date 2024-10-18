digitalWrite([D5,D6],0) // motors  
digitalWrite([D4,D7],0) 


digitalWrite([D5,D6],1) // motors  
digitalWrite([D4,D7],1) 

D2.reset(); // LEDs on - BROKEN
print([D0.read(),D1.read()])
setInterval(function() {
  print([D0.read(),D1.read()]) // light sensors - BROKEN
}, 100);

D2.reset(); 
setWatch(print,D0,{repeat:true,edge:0})                                        
setWatch(print,D1,{repeat:true,edge:0}) 

D8.reset(); // LED

pinMode(D9,"input_pullup")
D9.read(); // button

require("neopixel").write(D10,[255,0,0,])

require("neopixel").write(D10,[255,0,0,255,0,0,0,255,0, 0,0,255, 255,0,0, 0,255,0, 0,0,255, 255,0,0]); // neopixels
require("neopixel").write(D10,new Uint8Array(24)); // off

D3.analog(); // buttons - ADC analog read currently broken!


// Seek based on position
var n = 100;
D2.reset(); 
setWatch(function() {
  n--;
  if (n<0) {
    digitalWrite([D5,D6],0);
  } else if (n<20) {
    analogWrite(D6,0.5 + (n/40)); 
  }
},D1,{repeat:true,edge:0})       
digitalWrite([D5,D6],1)

digitalWrite([ML1,ML2],2) 
digitalWrite([MR1,MR2],2) 
digitalWrite([ML1,ML2],1) 
digitalWrite([MR1,MR2],1) 
digitalWrite([ML1,ML2],0) 
digitalWrite([MR1,MR2],0) 

var lspeed = 0, rspeed = 0;
var lreq = 0, rreq = 0;
var lmotor, rmotor;
setWatch(function(e) {
  var d = e.time-(e.lastTime||0);
  if (d<0.01) return;
  lspeed = (lspeed*0.8) + (0.2/d);
}, IRL, {repeat:true, edge:0});
setWatch(function(e) {
  var d = e.time-(e.lastTime||0);
  if (d<0.01) return;
  rspeed = (rspeed*0.8) + (0.2/d);
}, IRR, {repeat:true, edge:0});

function go(l,r) {
  digitalWrite([ML1,ML2],0);
  if (l>0) {
    lmotor = MR1;
    analogWrite(ML1,l);
  } else  if (l<0) { 
    lmotor = MR2;  
    analogWrite(ML2,-l);  
  }
  lreq = Math.abs(r);  
  digitalWrite([MR1,MR2],0);
  if (r>0) {
    rmotor = MR1;
    analogWrite(MR1,r);
  } else  if (r<0) {
    rmotor = MR2;  
    analogWrite(MR2,-r);   
  }
  rreq = Math.abs(r);
}


E.setBootCode(`
led([0,0,0,2,2,2,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,0,0,0]);
var lspeed = 0, rspeed = 0;
var lreq = 0, rreq = 0;
var lmotor, rmotor;
setWatch(function(e) {
  var d = e.time-(e.lastTime||0);
  if (d<0.01) return;
  lspeed = (lspeed*0.8) + (0.2/d);
}, IRL, {repeat:true, edge:0});
setWatch(function(e) {
  var d = e.time-(e.lastTime||0);
  if (d<0.01) return;
  rspeed = (rspeed*0.8) + (0.2/d);
}, IRR, {repeat:true, edge:0});

function go(l,r) {
  digitalWrite([ML1,ML2],0);
  if (l>0) {
    lmotor = MR1;
    analogWrite(ML1,l);
  } else  if (l<0) { 
    lmotor = MR2;  
    analogWrite(ML2,-l);  
  }
  lreq = Math.abs(r);  
  digitalWrite([MR1,MR2],0);
  if (r>0) {
    rmotor = MR1;
    analogWrite(MR1,r);
  } else  if (r<0) {
    rmotor = MR2;  
    analogWrite(MR2,-r);   
  }
  rreq = Math.abs(r);
}`)
