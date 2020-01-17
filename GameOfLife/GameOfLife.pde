boolean grid[][];
int n = 25;

void setup() {
  grid = new boolean[n][n];
  size(500, 500);
  grid[1][2] = true;
  grid[2][3] = true;
  grid[3][1] = true;
  grid[2][2] = true;
  grid[3][2] = true;
  /*
  for (int i = 0; i < n; ++i) {
    for (int j = 0; j < n; ++j) {
      int d = (int)random(2);
      grid[i][j] = d == 0 ? false : true;
    }
  }
  */
}

void updateGrid() {
  boolean aux[][];
  aux = new boolean[n][n];
  for (int i = 0; i < n; ++i) {
    for (int j = 0; j < n; ++j) {
      int v = vecinos(i, j);
      if (v < 2)
        aux[i][j] = false;
      else if (v == 2 && grid[i][j])
        aux[i][j] = true;
      else if (v == 3)
        aux[i][j] = true;
      else
        aux[i][j] = false;
    }
  }
  grid = aux;
}

void draw() {
  background(100);
  for (int i = 0; i < n; ++i) {
    for (int j = 0; j < n; ++j) {
      if (grid[i][j]) {
        //stroke(255);
        strokeWeight(2);
        rect(i*width/n, j* height/n, width/n, height/n, 7);
      }
    }
  }
  delay(300);
  updateGrid();
}

int vecinos(int i, int j) {
  int ret = 0;
  if (i > 1 && j > 1 && grid[i-1][j-1]) //Arriba izq
    ret++;
  if (i > 1 && grid[i-1][j]) //Arriba cent
    ret++;
  if (i > 1 && j < n-1 && grid[i-1][j+1]) //Arriba der
    ret++;

  if (i < n - 1 && j > 1 && grid[i+1][j-1]) //Abajo izq
    ret++;
  if (i < n - 1 && grid[i+1][j]) //Abajo cent
    ret++;
  if (i < n - 1 && j < n-1 && grid[i+1][j+1]) //Abajo der
    ret++;

  if (i > 1 && j > 1 && grid[i][j-1]) //Centro izq
    ret++;
  if (i > 1 && j < n-1 && grid[i][j+1]) //Centro der
    ret++;

  return ret;
}
