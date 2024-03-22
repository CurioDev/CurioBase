//var StepperMotor = require("StepperMotor");

function StepperMotor(obj) {
  this.pins = obj.pins;
  this.pattern = obj.pattern || [0b0001,0b0010,0b0100,0b1000];
  this.offpattern = obj.offpattern || 0;
  this.pos = 0;
  this.stepsPerSec = obj.stepsPerSec || 100;
  this.onstep = obj.onstep || 0;
}


/** Set the current position to be home (0) */
StepperMotor.prototype.setHome = function() {
  this.pos = 0;
};

/** Get the current position */
StepperMotor.prototype.getPosition = function() {
  return this.pos;
};

/** Stop movement, and if `turnOff` is true turn off the coils */
StepperMotor.prototype.stop = function(turnOff) {
  if (this.interval) {
    clearInterval(this.interval);
    this.interval = undefined;
  }
  if (turnOff)
    digitalWrite(this.pins, this.offpattern);
};

function stepHandler(stepper, pos, callback) { "jit"
  // remove interval if needed
  if (stepper.pos == pos) {
    callback();
  } else {
    // move onwards
    stepper.pos += (pos < stepper.pos) ? -1 : 1;
    // now do step
    digitalWrite(stepper.pins, stepper.pattern[ stepper.pos & (stepper.pattern.length-1) ]);
  }
  if (stepper.onstep) stepper.onstep(stepper.pos);
};

/** Move to a specific position in the time given. If no time
is given, it will be calculated based on this.stepsPerSec.
`callback` will be called when the movement is complete,
and if `turnOff` is true the coils will be turned off */
StepperMotor.prototype.moveTo = function(pos, milliseconds, callback, turnOff) { 
  pos = 0|pos; // to int
  if (milliseconds===undefined)
    milliseconds = Math.abs(pos-this.pos)*1000/this.stepsPerSec;
  this.stop(turnOff);
  if (pos != this.pos) {
    var stepper = this;
    function finalCallback() {
      // callback when finished
      stepper.stop(turnOff);
      if (callback) callback();
    }
    this.interval = setInterval(stepHandler, milliseconds / Math.abs(pos-this.pos), stepper, pos, finalCallback);
    stepHandler(stepper,pos, finalCallback);
  } else {
    if (callback)
      setTimeout(callback, milliseconds);
  }
};


var motorA = new StepperMotor({
  pins: [  D28, D29, D24, D23 ].reverse()
});
var motorB = new StepperMotor({
  pins: [ D30, D31, D15, D14 ]
});

function go(a,b, stepsPerSec, callback) {
  if (stepsPerSec===undefined) stepsPerSec=400;
  var max = Math.max(Math.abs(a),Math.abs(b));
  var milliseconds = max*1000/stepsPerSec;
  motorA.moveTo(a, milliseconds);
  motorB.moveTo(b, milliseconds, function() {
    motorA.stop(true); // off
    motorB.stop(true); // off
    motorA.setHome();
    motorB.setHome();
    if (callback) callback();
  });
}

go(500,500);