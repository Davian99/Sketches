public class TSP {
  public Point[] puntos;
  public Cromosome[] cromosomas;


  public TSP(Point[] puntos) {
    this.puntos = puntos;
    cromosomas = new Cromosome[init]; 
    createInitialPopulation();
  }

  public void createInitialPopulation() {
    int ind = 0;
    ArrayList<Integer> l = new ArrayList<Integer>();
    for (int i = 0; i < np; ++i) 
      l.add(i);
    for (int i = 0; i < init; ++i) {
      Collections.shuffle(l);
      cromosomas[i] = new Cromosome(l, i);
    }
  }

  public double avg() {
    double ret = 0;
    for (int i = 0; i < init; ++i)
      ret += this.cromosomas[i].fitness;
    return ret / init;
  }

  public void gen_step() {
    Cromosome[] next_gen = new Cromosome[init];
    int i = 1;
    next_gen[0] = bestEver;
    /*
    if(gen - lastbest > 50){
      System.out.println("TODOS MUTAN");
      for(int j = 1; j < np; ++j){
        double p = rand.nextDouble();
        if(p < 0.5)
          cromosomas[j].mutate();
      }
      lastbest = gen;
    }
    */
    while (i < init) {
      Cromosome c1 = selection(), c2 = selection();
      Cromosome c3 = cross(c1, c2);
      Cromosome c4 = cross(c2, c1);
      c3.mutate();
      c4.mutate();
      double pc3 = rand.nextDouble(), pc4 = rand.nextDouble();
      if (c3.fitness < c1.fitness || pc3 < 0.3)
        next_gen[i] = c3;
      else
        next_gen[i] = c1;
      if(i + 1 == init)
        break;
      if (c4.fitness < c2.fitness || pc4 < 0.3)
        next_gen[i+1] = c4;
      else
        next_gen[i+1] = c2;
      i += 2;
    }
    cromosomas = next_gen;
  }

  public Cromosome selection() {
    Cromosome c1 = randCrom(), c2 = randCrom();
    double p = rand.nextDouble();
    if (p < 0.8)
      return max(c1, c2);
    else
      return min(c1, c2);
  }

  public Cromosome cross(Cromosome a, Cromosome b) {
    int ntaken = 0;
    int[] perm = new int[np];
    boolean[] taken = new boolean[np];
    for (int i = 0; i < np; ++i) 
      taken[i] = false;

    int p1 = rand.nextInt(np), p2 = rand.nextInt(np);
    if (p1 > p2) {
      int aux = p2;
      p2 = p1;
      p1 = aux;
    }

    for (int i = p1; i < p2; ++i) {
      perm[i] = a.perm[i];
      taken[perm[i]] = true;
      ntaken++;
    }
    int i = p2, i2 = i;
    while (ntaken < np) {
      if (!taken[b.perm[i]]) {
        taken[b.perm[i]] = true;
        ntaken++;
        perm[i2] = b.perm[i];
        i2++;
        i2 %= np;
      }
      i++;
      i %= np;
    }

    return new Cromosome(perm);
  }

  public Cromosome randCrom() {
    int k = rand.nextInt(init);
    return cromosomas[k];
  }

  public Cromosome max(Cromosome a, Cromosome b) {
    if (a.fitness < b.fitness)
      return a;
    else
      return b;
  }

  public Cromosome min(Cromosome a, Cromosome b) {
    if (a.fitness < b.fitness)
      return b;
    else
      return a;
  }
}
