PVector orig, X, Y, Z, V, N;
void setup(){
  size(400,400,P3D);
  orig = new PVector();
  X = new PVector(1, 0, 0);
  Y = new PVector(0, 1, 0);
  Z = new PVector(0, 0, 1);
  V = new PVector(random(-1,+1), random(-1,+1), random(-1,+1)).normalize();
  N = Z.cross(V);
  alpha = angleBetweenTwoVector(X, N, Z);
  beta = angleBetweenTwoVector(Z, V, N);
}
float dx = 0, dy = 0, alpha, beta;
void draw(){
  lights();
  background(#FFFFF2);
  translate(width/2, height/2);
  rotateY(radians(dx));
  rotateX(radians(60));
  rotateZ(radians(45));
  strokeWeight(3);
  myLine(orig, X, 120, #FF0000);
  myLine(orig, Y, 120, #00FF00);
  myLine(orig, Z, 120, #0000FF);
  strokeWeight(1);
  myLine(orig, V, 150, #FF00FF);
  myLine(orig, N, 150, #00FF00);
  stroke(0);
  pushMatrix();
    rotateZ(alpha);
    rotateX(beta);
    myEllipse(); //z軸比較長
  popMatrix();
  box(10);
}
void myEllipse(){
  pushMatrix();
    scale(0.2, 0.2, 1);
    sphere(100);
  popMatrix();
  pushMatrix();
    scale(1, 0.2, 0.2);
    sphere(50);
  popMatrix();
}
void myLine(PVector p1, PVector p2, float len, color c){
  stroke(c);
  line(p1.x*len, p1.y*len, p1.z*len, p2.x*len, p2.y*len, p2.z*len);
}
void mouseDragged(){
  dx += mouseX - pmouseX;
  dy += mouseY - pmouseY;
}
float angleBetweenTwoVector(PVector v1, PVector v2, PVector N){
  //內積 ＝ a*b*cos(c)
  //cos(c) = 內積/a/b
  //c = acos(內積/a/b)
  float ans = acos( PVector.dot(v1,v2)/v1.mag()/v2.mag() );
  if( PVector.dot(  v1.cross(v2) , N ) < 0 ) ans = -ans;
  return ans;
}
