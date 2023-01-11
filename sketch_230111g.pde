// 想要了解怎麼轉動珠子，所以利用 atan2() 來旋轉

PVector p1, p2;
void setup(){
  size(500,500,P3D);
  p1 = new PVector();
  p2 = new PVector();
}
void draw(){
  background(#FFFFF2);
  line(p1.x, p1.y, p2.x, p2.y);
  mySphere(p1);
  mySphere(p2);
  myBead();
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
void mySphere(PVector p){
  pushMatrix();
    translate(p.x, p.y, p.z);
    sphere(10);
  popMatrix();
}
void myBead(){
  PVector v = PVector.sub(p2, p1);
  PVector c = PVector.add(p1, p2).div(2);
  float len = v.mag();
  float angle1 = atan2(v.y, v.x);
  float angle2 = atan2(v.z, v.x);
  //https://stackoverflow.com/questions/42554960/get-xyz-angles-between-vectors
  // vec3 u = vec3( 1,  0,  0); 
  // vec3 v = vec3(vx, vy, vz);
  //float x_angle = acos(0);//dot(yz)
  //float y_angle = acos(v.x);//dot(xz)
  //float z_angle = acos(//dot(xy)
  pushMatrix();
    translate(c.x, c.y);
    rotateZ(angle1);
    rotateY(-angle2);
    scale(1, 0.3, 0.3);
    noFill();
    sphere(len/2);//(0, 0, len, len/2); //x 是長軸
  popMatrix();
}
void keyPressed(){
  if(keyCode==UP) p1.z += 10;
  if(keyCode==DOWN) p1.z -= 10;
}
