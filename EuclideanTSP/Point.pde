public class Point{
  int x, y;
  
  public Point(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  void draw(){
    fill(0);
    ellipseMode(CENTER);
    ellipse(x, y, d, d);
  }

}
