public class NumberBall {
  int number;
  int x, y;

  public NumberBall(int n, int x, int y) {
    this.number = n;
    this.x = x;
    this.y = y;
  }

  public void draw() {
    ellipse(x, y, 50, 50);

    fill(0);
    textAlign(CENTER, CENTER);
    text(number, x, y-3);
    fill(255);
  }
}
