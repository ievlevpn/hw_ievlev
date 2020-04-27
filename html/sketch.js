var pos;
var prev;

function setup() {
  createCanvas(400, 400);
  pos = createVector(200, 200);
  prev = pos.copy();
}

function draw() {
  stroke(0);
  strokeWeight(2);
  line(pos.x, pos.y, prev.x, prev.y);
  prev.set(pos);

  var step = p5.Vector.random2D();

  var r = random(100);
  if (r < 1) {
    step.mult(random(25, 100));
  } else {
    step.setMag(2);
  }

  pos.add(step);
}
