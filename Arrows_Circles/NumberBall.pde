public class NumberBall {
  int number;
  int x, y;
  int r, g, b;

  public NumberBall(int n, int x, int y, int r, int g, int b) {
    this.number = n;
    this.x = x;
    this.y = y;
    this.r = r;
    this.g = g;
    this.b = b;
  }

  public void draw() {
    fill(0);
    ellipse(x, y, 10, 10);
    fill(255);
    /*
    fill(0);
     textAlign(CENTER, CENTER);
     text(number, x, y-3);
     fill(255);
     */
  }
}
