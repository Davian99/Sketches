public class Cell {
  public int number, x, y;
  public State s, last;
  public Cell(int number, int x, int y) {
    this.number = number;
    this.x = x;
    this.y = y;
    this.s = State.UNDETERMINED;
    this.last = State.ERROR;
  }

  public void draw() {
    if(this.s == this.last)
      return;
    switch(this.s) {
      case ERROR:
        fill(50);
        break;
      case UNDETERMINED:
        fill(240);
        break;
      case PRIME:
        fill(0, 255, 0);
        break;
      case COMPOS:
        fill(255, 0, 0);
        break;
    }
    rect(x, y, x_cell_size, y_cell_size); //<>//
    fill(0);
    text(number, x+x_cell_size/2, y + y_cell_size/2);
    noFill();
    this.last = this.s;
  }
}
