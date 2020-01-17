int[] values;

int i = 0;
int v = 10;

void setup() {
  size(1000, 500);
  values = new int[width/v];
  for (int i = 0; i <  values.length; i++) {
    values[i] = (int)random(height);
  }
  //values = sort(values);
  frameRate(30);
}

void draw() {
  background(0);

  int min;
  int m = -1;
  if (i < values.length) {
    min = values[i];
    m = i;
    for (int j = i+1; j <  values.length; j++) {
      if (values[j] < min) {
        min = values[j];
        m = j;
      }
    }

    int aux = values[i];
    values[i] = min;
    values[m] = aux;
    i++;
  } else {
    noLoop();
  }

  for (int k = 0; k < values.length; k++) {
    if (k == i || k == m)
      stroke(255, 0, 0);
    else
      stroke(255);
    strokeWeight(v);
    line(v/2 + k*v, height, v/2 + k*v, height - values[k]);
  }
  //delay(100);
}
