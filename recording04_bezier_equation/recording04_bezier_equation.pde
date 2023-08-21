void setup(){
  size(800,800);
}
void draw(){
  background(#FFFFF2);
  for(PVector p :pts){
    ellipse(p.x, p.y, 8, 8);
  }
  if(pts.size()>=4){
    PVector p0 = pts.get(0), p1 = pts.get(1), p2 = pts.get(2), p3 = pts.get(3);
    noFill();
    bezier(p0.x, p0.y, p1.x, p1.y, p2.x, p2.y, p3.x, p3.y);
    
    float t2 = 1-t;
    PVector p = PVector.add(PVector.mult(p0,t2*t2*t2), PVector.mult(p1, 3*t2*t2*t));
    p.add(PVector.mult(p2, 3*t2*t*t));
    p.add(PVector.mult(p3, t*t*t));
    ellipse(p.x, p.y, 8, 8);
    t = (t+0.002);
    if(t>=1) t = 0;
  }
}
float t = 0; //alpha
ArrayList<PVector> pts = new ArrayList<PVector>();
void mousePressed(){
  pts.add(new PVector(mouseX, mouseY));
}
