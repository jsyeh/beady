PVector [] p = new PVector[3];
void setup(){
  size(400,400);
  p[0] = new PVector(100, 100);
  p[1] = new PVector(300, 200);
  p[2] = new PVector(100, 300);
}
void draw(){
  background(#FFFFF2);
  line(p[0].x, p[0].y, p[1].x, p[1].y);
  line(p[1].x, p[1].y, p[2].x, p[2].y);
  line(p[2].x, p[2].y, p[0].x, p[0].y);
  for(int i=0; i<3; i++){
    ellipse(p[i].x, p[i].y, 10, 10);
  }
  if(mousePressed==false){
    HookeForce( p[0], p[1] );
    HookeForce( p[1], p[2] );
    HookeForce( p[2], p[0] );
  }
}
void HookeForce(PVector p1, PVector p2){
  float len = dist(p1.x, p1.y, p2.x, p2.y);
  PVector v = PVector.sub(p2, p1);
  v.normalize(); //長度為1的單位向量
  v.mult( -(len-100)/100.0 ); //虎克定律有個負號
  p2.x += v.x;
  p2.y += v.y;
  p1.x -= v.x;
  p1.y -= v.y;
}
void mouseDragged(){
  p[1].x += mouseX-pmouseX;
  p[1].y += mouseY-pmouseY;
}
