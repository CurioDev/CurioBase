pins = [  D28, D29, D24, D23, D30, D31, D15, D14 ];
n = -1;

function test() {
  n++;
  if (n>=pins.length)n=0;
  digitalWrite(pins, 1<<n);
  digitalWrite([LED1, LED2], 1<<(n&1));
}

setInterval(test,300);