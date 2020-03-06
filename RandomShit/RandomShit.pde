import java.util.*;
ArrayList<Integer> ali;
Random rand;

void setup() {
  size(800, 800);
  rand = new Random();
  ali = new ArrayList<Integer>();
  for (int i = 0; i < 1000000; ++i)
    ali.add(new Integer(i));
}

void draw() {
  int s = 0;
  for (int i = 0; i < ali.size(); ++i) {
    Integer k = ali.get(rand.nextInt(ali.size()));
    s += k;
    
  }
  fill((rand.nextInt() % s) % 256);
  ellipse(width/2, height/2, 100, 100);
}
