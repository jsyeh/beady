PVector p1, p2;
void setup(){
  size(400,400);
  p1 = new PVector(100,100);
  p2 = new PVector(300,200);
}
void draw(){
  background(#FFFFF2);
  line(p1.x, p1.y, p2.x, p2.y);
  ellipse(p1.x, p1.y, 10, 10);
  ellipse(p2.x, p2.y, 10, 10);
  float len = dist(p1.x, p1.y, p2.x, p2.y);
  PVector v = PVector.sub(p2, p1);
  v.normalize(); //長度為1的單位向量
  if(mousePressed==false){
    v.mult( -(len-100)/10.0 ); //虎克定律有個負號
    p2.x += v.x;
    p2.y += v.y;
  }
}
void mouseDragged(){
  p2.x += mouseX-pmouseX;
  p2.y += mouseY-pmouseY;
}
