float [] gx = {30,  130,-300};
float [] gy = {330, 430,-600};
float [] gz = {300,-170,-300};
void setup(){
  size(800, 800);
}
void draw(){
  background(#FFFFF2);
  fill(255,0,0);
  ellipse(gx[N], gy[N], 10, 10);
  
  fill(0, 255, 0);
  for(int i=0; i<N; i++){
    ellipse(x[i], y[i], 10, 10);
  }
}
float [] x = new float[6];
float [] y = new float[6];
int N = 0;
void mousePressed(){
  if(N>=3) return; //只能點3個點哦
  x[N] = mouseX;
  y[N] = mouseY;
  N++;
}
