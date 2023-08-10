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
    
    noFill();
    beginShape();
    for(int i=0; i<centersN; i++){  
      vertex(centers[i].x, centers[i].y);
    }
    endShape(CLOSE);
    
    for(int i=0; i<centersN; i++){
      ellipse(centers[i].x, centers[i].y, 8, 8);
    }
  }
  for(int i=0; i<N; i++){
    ellipse( pt[i].x, pt[i].y, 8, 8);
  }
}
int N=0, TRI3N=0;
PVector [] pt = new PVector[100]; //會重覆使用頂點啦
Integer [] tri = new Integer[300]; //100個三角形，會有300個對應頂點整數的代碼
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
    tri[ TRI3N + 0 ] = 0;
    tri[ TRI3N + 1 ] = N-1;
    tri[ TRI3N + 2 ] = 1;
    TRI3N += 3;
    findCenters();
  }
}
PVector [] centers = new PVector[100];
int centersN = 0;
void findCenters(){
  for(int i=0; i<TRI3N/3; i++){ //第i個三角形
    int i0 = tri[ 3*i + 0 ];
    int i1 = tri[ 3*i + 1 ];
    int i2 = tri[ 3*i + 2 ];
    centers[centersN] = PVector.add(pt[i0],pt[i1]).add(pt[i2]).div(3);
    centersN++;
  }
}
