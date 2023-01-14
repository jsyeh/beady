//改良自 sketch_230112g.pde 重寫的版本，再加上 sketch_230113b.pde 以 Euler Angle 的 alpha beta 做出的版本

ArrayList<PVector> vertices;
ArrayList<ArrayList<Integer>> faces;
void setup(){
  size(400, 400, P3D);
  String [] lines = loadStrings("penguin.obj"); //penguin = loadShape("penguin.obj");
  prepareVertexFaces(lines);
}
void prepareVertexFaces(String [] lines){
  vertices = new ArrayList<PVector>();
  faces = new ArrayList<ArrayList<Integer>>();
  for(int i=0; i<lines.length; i++){
    String line = lines[i];
    char c = line.charAt(0);
    if(c=='v'){
      String [] nums = split(line, " ");
      PVector p = new PVector( float(nums[1]) , float(nums[2]) , float(nums[3]) );
      vertices.add(p);
    }else if(c=='f'){
      String [] nums = split(line, " ");
      ArrayList<Integer> temp = new ArrayList<Integer>();
      for(int k=1; k<nums.length; k++){
        temp.add( int(nums[k]) );
      }
      faces.add(temp);
    }
  }
}
void draw(){
  lights();
  background(#FFFFF2);
  translate(width/2, height/2);
  rotateY(radians(frameCount));
  scale(300);
  noStroke();
  for(ArrayList<Integer> face : faces){
    for(int i=0; i<face.size(); i++){
      int k = face.get(i), k2 = face.get((i+1)%face.size());
      PVector p = vertices.get(k-1), p2 = vertices.get(k2-1);
      myBead(p, p2);
    }
  }
}
void myBead(PVector p1, PVector p2){
  PVector myVec = PVector.sub(p2, p1);
  PVector c = PVector.add(p1, p2).div(2);
  PVector Z = new PVector(0,0,1);
  PVector N = Z.cross(myVec);
  float beta = angleBetweenTwoVector(Z, myVec, N);
  float alpha = angleBetweenTwoVector(new PVector(1,0,0), N, Z);

  pushMatrix();
    translate(c.x, c.y, c.z);
    rotateZ(alpha);//alpha
    rotateX(beta);//beta 這裡做了交換，可能是座標系統不同
    scale(0.3, 0.3, 1);
    sphere(myVec.mag()/2);
  popMatrix();

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
