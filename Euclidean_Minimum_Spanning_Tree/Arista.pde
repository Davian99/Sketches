public class Arista implements Comparable<Arista>{
  public Par p1, p2;
  public double peso;
  
  public Arista(Par px, Par py){
    p1 = px;
    p2 = py;
    peso = Math.sqrt((p1.x - p2.x) * (p1.x - p2.x) + (p1.y - p2.y) * (p1.y - p2.y));
  }
  
  public void pinta(){
    line(p1.x, p1.y, p2.x, p2.y);
  }
  
  public int compareTo(Arista a2){
    if(this.peso < a2.peso)
      return -1;
    else if(this.peso == a2.peso)
      return 0;
    else
      return 1;
  }
}
