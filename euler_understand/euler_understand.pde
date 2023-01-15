PVector Orig, X, Y, Z, V;
void setup() {
  size(400, 400, P3D);
  Orig = new PVector();
  X = new PVector(1, 0, 0);
  Y = new PVector(0, 1, 0);
  Z = new PVector(0, 0, 1);
  V = new PVector(random(-1, +1), random(-1, +1), random(-1, +1));
}
float dy=0, dx=0;
void mouseDragged() {
  dx += mouseX - pmouseX;
  dy -= mouseY - pmouseY;
}
void draw() {
  background(#FFFFF2);
  lights();
  translate(width/2, height/2);
  rotateX(radians(dy));
  rotateY(radians(dx));
  rotateX(radians(60));
  rotateZ(radians(45));
  PVector N = Z.cross(V.copy().normalize());

  strokeWeight(3);
  myDrawLine(Orig, X, 100, #FF0000);
  myDrawLine(Orig, Y, 100, #00FF00);
  myDrawLine(Orig, Z, 100, #0000FF);
  strokeWeight(1);
  myDrawLine(Orig, V, 150, #FF00FF);
  myDrawLine(Orig, N, 150, #AAFFAA);
  float beta = findAngleBetween(Z, V, N);
  float alpha = findAngleBetween(X, N, Z);
  println(degrees(beta));
  pushMatrix();
    rotateZ(alpha);
    rotateX(beta);
    myEllipse();
  popMatrix();
  pushMatrix();
    rotateZ(-alpha);
    myDrawLine(Orig, N, 150, #0000FF);
  popMatrix();
  box(20);
}
float findAngleBetween(PVector v1, PVector v2, PVector axis) {
  PVector v1n = v1.copy().normalize();
  PVector v2n = v2.copy().normalize();
  PVector N = v1n.cross(v2n);
  float ans = acos(PVector.dot(v1n, v2n));
  if (PVector.dot(N, axis)>0) return ans;
  else return -ans;
}
void myDrawVector(PVector p1, PVector p2, float  len, color c, String name) {
}
void myDrawLine(PVector p1, PVector p2, float len, color c) {
  stroke(c);
  line(p1.x*len, p1.y*len, p1.z*len, p2.x*len, p2.y*len, p2.z*len);
}
void myEllipse() {
  pushMatrix();
    scale(0.3, 0.3, 1);
    sphere(50);
  popMatrix();
  pushMatrix();
    scale(1, 0.1, 0.1);
    sphere(60);
  popMatrix();
}
