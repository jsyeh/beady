void setup(){
  size(600,600);
}
int state=0; //0: TRIANGLE_FAN, 1: TRIANGES/face
void draw(){
  background(#FFFFF2);
  if(state==0){
    fill(255,0,0);
    beginShape(TRIANGLE_FAN);
    for(int i=0; i<N; i++){
      vertex(pt[i].x, pt[i].y);
    }
    endShape();
  }else{
    fill(0,255,0);
    beginShape(TRIANGLES);
    for(int i=0; i<TRI3N; i++){
      PVector p = pt[ tri[i] ];
      vertex(p.x, p.y);
    }
    endShape();
  }
  for(int i=0; i<N; i++){
    ellipse( pt[i].x, pt[i].y, 8, 8);
  }
}
int N=0, TRI3N=0;
PVector [] pt = new PVector[100];
Integer [] tri = new Integer[300]; //隨便
void mousePressed(){
  if(mouseButton==LEFT){
    pt[N] = new PVector(mouseX, mouseY);
    N++;
  }else{
    state = 1;
    for(int i=1; i<N-1; i++){
      tri[ TRI3N + 0 ] = 0;
      tri[ TRI3N + 1 ] = i;
      tri[ TRI3N + 2 ] = i+1;
      TRI3N += 3;
    }
  }
}
