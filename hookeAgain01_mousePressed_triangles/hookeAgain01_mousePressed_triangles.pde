void setup(){
  size(600,600);
}

void draw(){
  background(#FFFFF2);
  beginShape(TRIANGLE_FAN);
  for(int i=0; i<N; i++){
    vertex(pt[i].x, pt[i].y);
  }
  endShape();
  
  for(int i=0; i<N; i++){
    ellipse( pt[i].x, pt[i].y, 8, 8);
  }
}
int N=0;
PVector [] pt = new PVector[100];
void mousePressed(){
  pt[N] = new PVector(mouseX, mouseY);
  N++;
}
