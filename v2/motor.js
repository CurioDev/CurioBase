led([0,0,0,2,2,2,0,0,0,0,0,0,0,0,0,0,0,0,2,2,2,0,0,0]);

PID = {
  // gains
  Pg : 0.02,
  Ig : 1,
  Dg : 0,
  // min/max
  Imin : -0.5,
  Imax : 0.5
};

function Motor(M1,M2) {
  Object.assign(this,{
    M1:M1,M2:M2,
    aspeed : 0, // actual speed
    rspeed : 0,   // requested speed
    duty : 0,
    idle : 0,
    lastTime : getTime(), // time of last pin event
    pwm : undefined, // PWM pin
    direction : 0, // 1 or -1
    odometer : 0, // how many steps have we moved?
    // PID
    err:0,
    P:0,I:0,D:0,
  });
}
Motor.prototype.set = function(speed) {"ram";
  if (speed==0) {
    digitalWrite([this.M1,this.M2],0);
    this.duty = 0;
    this.rspeed = 0;
    this.pwm = undefined;
    this.P = this.I = this.D = this.err = 0;
  } else {
    if (speed>0) {
      this.pwm = this.M1;
      this.direction = 1;
    } else  if (speed<0) { 
      this.pwm = this.M2;
      this.direction = -1;
    }
    this.duty = 1;
    analogWrite(this.pwm,this.duty);
  }
  this.rspeed = Math.abs(speed)*30;  
};
Motor.prototype.onSensor = function(e) {"ram";
  var d = e.time-this.lastTime;
  if (d<0.01) return;
  this.lastTime = e.time;
  this.odometer += this.direction;
  this.aspeed = this.aspeed*0.6 + (0.4/d);
  //print(this.aspeed, this.lastTime, this.idle);
  this.idle=0;
};
Motor.prototype.onStep = function() {"ram";
  this.idle++;
  if (this.idle>8)
    this.aspeed = this.aspeed*0.6 + (0.4 / (getTime()-this.lastTime));
  // PID
  var err = this.rspeed-this.aspeed;
  this.P = this.err * PID.Pg;
  this.D = (err-this.err) * PID.Dg;
  this.err = err;
  this.I = E.clip(err * PID.Ig, PID.Imin, PID.Imax);
  this.duty = E.clip(0.5 + this.P + this.I + this.D, 0, 1);
  if (this.pwm)
    analogWrite(this.pwm, this.duty);
};

L = new Motor(ML1,ML2);
R = new Motor(MR1,MR2);
setInterval(function() {"ram";
  L.onStep();
  R.onStep();
}, 20);
clearWatch();
setWatch(L.onSensor.bind(L), IRL, {repeat:true, edge:0});
setWatch(R.onSensor.bind(R), IRR, {repeat:true, edge:0});

function go(l,r) {
  L.set(l);
  R.set(r);
}
