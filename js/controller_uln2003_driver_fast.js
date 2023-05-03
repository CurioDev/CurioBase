var stepper = {
  pat : [0b0011,0b0110,0b1100,0b1001], //[0b0001,0b0010,0b0100,0b1000], 
  pinA : [  D28, D29, D24, D23 ].reverse(),
  pinB : [ D30, D31, D15, D14 ],
  pA : 0, pB : 0, // current position
  dA : 0, dB : 0, // current speed
  sC : 0, // step counter
  interval : null, interval2 : null,  cb : 0
};

function stepHandler(s,dw) { "jit"
  dw(s.pinA, s.pat[ (s.pA += s.dA) & 3 ]);
  dw(s.pinB, s.pat[ (s.pB += s.dB) & 3 ]);
  if (s.sC-- < 0) s.cb();
}

function go(a,b, stepsPerSec, callback) {
  // energise the steppers at the current step point
  digitalWrite(stepper.pinA, stepper.pat[ stepper.pA & 3 ]);
  digitalWrite(stepper.pinB, stepper.pat[ stepper.pB & 3 ]);
  // clear existing intervals
  if (stepper.interval) clearInterval(stepper.interval);
  stepper.interval = null;
  if (stepper.interval2) clearInterval(stepper.interval2);
  stepper.interval2 = null;
  // work out step rates
  if (stepsPerSec===undefined) stepsPerSec=400;
  var max = Math.max(Math.abs(a),Math.abs(b));
  var milliseconds = max*1000/stepsPerSec;
  var steps = Math.max(Math.abs(a),Math.abs(b));
  stepper.sC = steps;
  stepper.dA = a/steps;
  stepper.dB = b/steps;
  // called when stepping finishes...
  stepper.cb = function() {
    if (stepper.interval) clearInterval(stepper.interval);
    stepper.interval = null;
    if (stepper.interval2) clearInterval(stepper.interval2);
    stepper.interval2 = null;
    digitalWrite(stepper.pinA, 0);
    digitalWrite(stepper.pinB, 0);
    if (callback) callback();
  };
  if (steps) {
    var ms = milliseconds / steps;
  /*  if (ms<3) { // if we're going >333 steps/sec then so a smooth start
      var endms = ms;
      ms = 20; // 50 steps/sec
      stepper.interval2 = setInterval(function() {
        ms /= 1.2;
        if (ms<=endms) {
          ms = endms;
          clearInterval(stepper.interval2);
          stepper.interval2 = null;
        }
        changeInterval(stepper.interval, ms);
      }, 20);
    }*/
    // start the actual step interval
    stepper.interval = setInterval(stepHandler, ms, stepper, digitalWrite);
  } else stepper.cb();
}

/*t=getTime();go(50000,50000, 1000, function() {
  console.log("Done",1500 / (getTime()-t));
});*/

// ON/OFF
var ON = true;
LED.write(ON);
setWatch(function() {
  ON=!ON;
  LED.write(ON);
  if (ON) NRF.wake();
  else {
    go(0,0);
    NRF.sleep();
  }
}, BTN, {repeat:true, edge:"rising", debounce:20});