// 週五晚上試著做珠珠轉動，週六半夜修正出來了
// 現在如何把它的 atan2()做得正確 3D
// https://zh.wikipedia.org/zh-tw/%E6%AC%A7%E6%8B%89%E8%A7%92
// Euler Angle Rotation
// rotateZ()
// rotateX() 看你的長軸要倒多少，就是這裡的參數, 就用內積 Z軸與你 FromTo acos()
// rotateZ()
PVector p1, p2;
void setup(){
  size(400,400,P3D);
  p1 = new PVector(-50, -100, -50);
  p2 = new PVector(100, 50, -0);
}
void draw(){
  background(#FFFFF2);
  translate(width/2, height/2);
  rotateY(radians(mouseX));
  stroke(0,255,0); mySphere(p1);
  line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);
  stroke(255,0,0); mySphere(p2);
  
  PVector myVec = PVector.sub(p2, p1);
  PVector c = PVector.add(p1, p2).div(2);
  PVector Z = new PVector(0,0,1);
  PVector N = Z.cross(myVec);
  float beta = angleBetweenTwoVector(Z, myVec, N);
  float alpha = angleBetweenTwoVector(new PVector(1,0,0), N, Z);

  myBead( myVec.mag(), c, alpha, beta );
}
float angleBetweenTwoVector(PVector v1, PVector v2, PVector axis){
  float len1 = v1.mag(), len2 = v2.mag();
  //內積 = len1 * len2 * cos(角度)
  //cos(角度) = 內積 / len1 / len2;
  float cos_value = PVector.dot(v1,v2) / len1 / len2;
  float angle = acos(cos_value);
  if(PVector.dot(axis,v1.cross(v2))>=0) return angle;
  else return -angle;
}
void mySphere(PVector p){
  pushMatrix();
    translate(p.x, p.y, p.z);
    sphere(8);
  popMatrix();
}
void myBead(float len, PVector pos, float alpha, float beta){
  pushMatrix();
    translate(pos.x, pos.y, pos.z);
    rotateZ(alpha);//alpha
    rotateX(beta);//beta 這裡做了交換，可能是座標系統不同
    scale(0.3, 0.3, 1);
    sphere(len/2);
  popMatrix();
}
