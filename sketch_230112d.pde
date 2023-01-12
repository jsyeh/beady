//在週五meeting時，先示範出旋轉咖啡豆的例子
PVector p1, p2;
void setup(){
  size(400, 400, P3D); //3種renderer: Java, P2D, P3D
  p1 = new PVector();
  p2 = new PVector();
}
void draw(){
  background(#FFFFF2);
  line(p1.x, p1.y, p2.x, p2.y);
  myCircle();
}
void myCircle(){
  PVector c = PVector.add(p1,p2).div(2);
  PVector v = PVector.sub(p2,p1);
  float len = v.mag();
  translate(c.x, c.y);
  float angle = atan2(v.y, v.x);
  rotate(angle);
  translate(-c.x, -c.y);
  ellipse(c.x, c.y, len, len/2);
}
void mousePressed(){
  p1.x = mouseX;
  p1.y = mouseY;
  p2.x = mouseX;  // 怕剛壓下時，會有奇怪的線
  p2.y = mouseY;  // 怕剛壓下時，會有奇怪的線
}
void mouseDragged(){
  p2.x = mouseX;
  p2.y = mouseY;
}
