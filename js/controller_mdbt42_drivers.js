var StepperMotor = require("StepperMotor");

var motorA = new StepperMotor({
  pins: [  D29, D30, D31, D3 ].reverse()
});
var motorB = new StepperMotor({
  pins: [ D22, D20, D19, D18 ]
});

function go(a,b, stepsPerSec, callback) {
  if (stepsPerSec===undefined) stepsPerSec=200;
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