PFont font;
int total = 0;
void setup(){
  size(800, 800);
  font = createFont("Arial", 24, true); // Arial, 16 point, anti-aliasing on
  frameRate(60);
}

void draw(){
  background(240);
  fill(0);
  textSize(30);
  text(round(frameRate), 0, 35);
  float bpm = (float)total / (frameCount / (frameRate*60));
  text("BPM = " + round(bpm), 0, 70);
  noFill();
}

void keyPressed() {
  total++;
}
