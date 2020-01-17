float x = 0;
final int sizex = 800, sizey = 800;

void setup(){
  frameRate(60);
}

void settings(){
  size(sizex, sizey);
}

void draw(){
  background(250);
  noFill();
  strokeWeight(5);
  arc(width/2, height/2, width/2, height/2, x, x + PI / 1);
  arc(width/2, height/2, width/2 + 100, height/2 + 100, x, x + PI / 1);
  strokeWeight(1);
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);
  x += PI/32;
}
