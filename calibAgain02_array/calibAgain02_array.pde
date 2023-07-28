void setup(){
  size(800, 800);
}
void draw(){
  background(#FFFFF2);
  for(int i=0; i<N; i++){
  //if(N>0) 
    ellipse(x[i], y[i], 10, 10);
  }
}
float [] x = new float[6];
float [] y = new float[6];
int N = 0;
void mousePressed(){
  //if(N>=6) return;
  if(N<6){
    x[N] = mouseX;
    y[N] = mouseY;
    N++;
  }
}
