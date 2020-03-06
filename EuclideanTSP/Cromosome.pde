public class Cromosome implements Comparable<Cromosome> {
  public int[] perm;
  public double fitness;

  public Cromosome(ArrayList<Integer> l, int pos) {
    int ind = 0;
    perm = new int[np];
    for (Integer a : l) {
      perm[ind] = a;
      ind++;
    }
    this.fitness = fitness(this);
  }
  
  public Cromosome(int[] perm){
    this.perm = perm;
    this.fitness = fitness(this);
  }
  
  public void mutate(){
    for(int i = 0; i < np; ++i){
      double p = rand.nextDouble();
      if(p < pMut){
        int k = rand.nextInt(np);
        swap(i, k);
        //System.out.println("MUTA");
      }
    }
    this.fitness = fitness(this);
  }
  
  public void swap(int a, int b){
    int aux = perm[a];
    perm[a] = perm[b];
    perm[b] = aux;
  }

  public void draw(float scale, int pos) {
    textFont(f, 16);
    int px = pos / 4;
    int py = pos % 4;
    noFill();
    translate(py*mx, px*my);
    rect(0, 0, mx, my);
    scale(1/scale, 1/scale);
    for (int i = 0; i < np; ++i)
      puntos[i].draw();
    for (int i = 0; i < np-1; ++i)
      line(puntos[perm[i]].x, puntos[perm[i]].y, puntos[perm[i+1]].x, puntos[perm[i+1]].y);
    line(puntos[perm[np-1]].x, puntos[perm[np-1]].y, puntos[perm[0]].x, puntos[perm[0]].y);
    scale(scale, scale);

    text("FITNESS: " + Math.round(this.fitness * 1000) / 1000.0, 5, 20);
    translate(-py*mx, -px*my);
  }

  public void drawBest() {
    textFont(f, 18);
    translate(mx * 4, 0);

    noFill();
    rect(0, 0, mx*3, my*3);
    scale(2/3.0, 2/3.0);
    for (int i = 0; i < np; ++i)
      puntos[i].draw();
    
    //Grafo completo
    /*
    strokeWeight(0.01);
    for (int i = 0; i < np; ++i) {
      for (int j = 0; j < np; ++j) {
        if(i == j)
          continue;
        line(puntos[i].x, puntos[i].y, puntos[j].x, puntos[j].y);
      }
    }
    */
    strokeWeight(3);
    stroke(255, 0, 0);
    for (int i = 0; i < np-1; ++i)
      line(puntos[perm[i]].x, puntos[perm[i]].y, puntos[perm[i+1]].x, puntos[perm[i+1]].y);
    line(puntos[perm[np-1]].x, puntos[perm[np-1]].y, puntos[perm[0]].x, puntos[perm[0]].y);
    stroke(0);
    strokeWeight(1);
    scale(3.0/2, 3.0/2);
    text("BEST EVER WITH FITNESS OF: " + Math.round(this.fitness * 1000) / 1000.0, 5, 20);
    translate(-mx * 4, 0);
  }

  public int compareTo(Cromosome o) {
    if (this.fitness > o.fitness)
      return 1;
    else if (this.fitness == o.fitness)
      return 0;
    else
      return -1;
  }
}
