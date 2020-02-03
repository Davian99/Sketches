public class UFDS {
  private int[] padre, peso;
  private int num;

  public UFDS(int n) {
    this.num = n;
    padre = new int[n];
    peso = new int[n];
    for (int i = 0; i < this.num; ++i) {
      padre[i] = i;
      peso[i] = 1;
    }
  }

  public int Find(int x) {
    if (x != padre[x]) {
      padre[x] = Find(padre[x]);
    }
    return padre[x];
  }

  public boolean same(int x, int y) {
    int xrep = Find(x);
    int yrep = Find(y);
    if (xrep == yrep)
      return true;
    else
      return false;
    }

    public void Union(int x, int y) {
      int xrep = Find(x);
      int yrep = Find(y);
      if (xrep == yrep)
        return;
      if (peso[xrep] > peso[yrep])
        padre[yrep] = xrep;
      else if (peso[xrep] < peso[yrep])
        padre[xrep] = yrep;
      else {
        padre[yrep] = xrep;
        peso[yrep] += peso[xrep];
      }
    }
}
