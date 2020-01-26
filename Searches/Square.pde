public class Square{
  float x, y;
  int state, ind;
  float vida = 1;
  boolean change = true;

  public Square(float x, float y, int state, int ind) {
    this.x = x;
    this.y = y;
    this.ind = ind;
    this.state = state;
  }

  public void draw(float sumx, float sumy) {
    if (state == 2)
      fill(20);
    else if (state == 1)
      fill(230);
    else if (state == 3)
      fill(255, 0, 0);
    else if (state == 4)
      fill(0, 255, 0);
    else if (state == 5)
      fill(255, 255, 50);
    else if (state == 6)
      fill(255, 0, 102);
    rect(x, y, sumx, sumy);
    change = false;

    noFill();
  }

  public void modify(int newState) {
    change = true;
    if (this.state != 2)
      this.state = newState;
  }
}
