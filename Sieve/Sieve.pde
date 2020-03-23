/*
This is super slow cause of indexing an arraylist
Change to array for performance pls -> Changed to vector

TODO:
Change from colors to shapes that show the prime factors 
  The primes are just them (Ex: 3 is a triangle) and the 
  composite numbers are multiple polygons
  Those polygons rotate for better visualization
*/

import java.util.Vector;

int x_cell_size, y_cell_size, x_cells = 10, y_cells = 10;
int p_index = -1, s_index = -1;
PFont font;

Vector<Cell> cells;

void setup() {
  size(900, 900);
  x_cell_size = width/x_cells;
  y_cell_size = height/y_cells;
  font = createFont("Arial", 18, true);
  textSize(x_cell_size/2);
  textAlign(CENTER, CENTER);
  cells = new Vector<Cell>();
  for (int j = 0; j < y_cells; ++j) {
    for (int i = 0; i < x_cells; ++i) {
      cells.add(new Cell(j * x_cells + i, i * x_cell_size, j * y_cell_size));
    }
  }
}

void draw() {
  //background(240);
  
  for (Cell c : cells)
    c.draw();
  advanceSieve();
}

void advanceSieve() {
  if (s_index == -1) { //Toca avanzar p_index
    p_index++;
    if (p_index == cells.size()) {
      noLoop();
      return;
    }
    Cell c = cells.get(p_index);
    if (c.s == State.UNDETERMINED) {
      if (c.number < 2)
        c.s = State.ERROR;
      else {
        c.s = State.PRIME;
        s_index = p_index * p_index;
      }
      delay(10);
    }
    
  } else {
    if (s_index < cells.size()) {
      Cell c = cells.get(s_index);
      if (c.s != State.COMPOS) {
        c.s = State.COMPOS;
        delay(10);
      }

      s_index += p_index;
    } else
      s_index = -1;
  }
}
