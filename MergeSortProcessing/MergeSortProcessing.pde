int[] arr; //<>//

// Merges two subarrays of arr[]. 
// First subarray is arr[l..m] 
// Second subarray is arr[m+1..r] 
void merge(int l, int m, int r) 
{ 
  int i, j, k; 
  int n1 = m - l + 1; 
  int n2 =  r - m; 

  /* create temp arrays */
  int L[], R[]; 
  L = new int[n1];
  R = new int[n2];

  /* Copy data to temp arrays L[] and R[] */
  for (i = 0; i < n1; i++) 
    L[i] = arr[l + i]; 
  for (j = 0; j < n2; j++) 
    R[j] = arr[m + 1+ j]; 

  /* Merge the temp arrays back into arr[l..r]*/
  i = 0; // Initial index of first subarray 
  j = 0; // Initial index of second subarray 
  k = l; // Initial index of merged subarray 
  while (i < n1 && j < n2) { 
    //draw();
    if (L[i] <= R[j]) { 
      arr[k] = L[i]; 
      i++;
    } else { 
      arr[k] = R[j]; 
      j++;
    } 
    k++;
  } 

  /* Copy the remaining elements of L[], if there 
   are any */
  while (i < n1) { 
    arr[k] = L[i]; 
    i++; 
    k++;
  } 

  /* Copy the remaining elements of R[], if there 
   are any */
  while (j < n2) { 
    arr[k] = R[j]; 
    j++; 
    k++;
  }
} 

/* l is for left index and r is right index of the 
 sub-array of arr to be sorted */
int p = 10;
int tam = (int)pow(2, p);
float v;
int curr_size;
int left_start;
void setup() {
  frameRate(6000);
  size(1024, 500);
  v = width/tam;
  arr = new int[tam];
  for (int i = 0; i < arr.length; ++i)
    arr[i] = (int)random(height);
  curr_size = 1;
  left_start = 0;
  pinta();
}

void pinta() {
  background(0);
  for (int k = 0; k < arr.length; ++k) {
    stroke(255);
    strokeWeight(v);
    line(v/2 + k*v, height, v/2 + k*v, height - arr[k]);
  }
}

void draw() {
  if (curr_size<=arr.length-1) 
  { 
    int mid = left_start + curr_size - 1; 
    int right_end = min(left_start + 2*curr_size - 1, arr.length-1); 
    if (mid <= arr.length-1)
      merge(left_start, mid, right_end);
  }

  left_start += 2*curr_size;
  if (left_start >= arr.length-1) {
    left_start = 0;
    curr_size = 2*curr_size;
  }
  
  if (left_start == 0){
    delay(1000);
    pinta();
  }
    
} 
