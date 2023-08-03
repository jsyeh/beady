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
}
