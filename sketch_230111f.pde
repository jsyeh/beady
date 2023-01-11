// 2D 的咖啡豆轉動

PVector p1, p2;
void setup(){
  size(400,400,P3D);
  p1 = new PVector();
  p2 = new PVector();
}
void draw(){
  background(#FFFFF2);
  line(p1.x, p1.y, p2.x, p2.y);
  myEllipse();
}
void mousePressed(){
  p1.x = mouseX;
  p1.y = mouseY;
  p2.x = mouseX;
  p2.y = mouseY;
}
void mouseDragged(){
  p2.x = mouseX;
  p2.y = mouseY;
}
void myEllipse(){
  PVector v = PVector.sub(p2, p1);
  PVector c = PVector.add(p1, p2).div(2);
  float len = v.mag();
  float angle = atan2(v.y, v.x);
  pushMatrix();
    translate(c.x, c.y);
    rotateZ(angle);
    ellipse(0, 0, len, len/2); //x 是長軸
  popMatrix();
}
