ArrayList<PVector> vertices;
ArrayList<ArrayList<Integer>> faces;
//PShape cube;
void setup(){
  size(500,500,P3D);
  //cube = loadShape("cube.obj");
  String [] lines = loadStrings("penguin.obj");
  
  vertices = new ArrayList<PVector>();
  faces = new ArrayList<ArrayList<Integer>>();
  for(String line : lines ) {
    String [] num = split(line, " "); 
    if(line.charAt(0)=='v') {
      vertices.add( new PVector( float(num[1]) , float(num[2]) , float(num[3]) ) );
    } 
    else if(line.charAt(0)=='f') {
      ArrayList<Integer> face = new ArrayList<Integer>();
      for(int i=1; i<num.length; i++){
        face.add( int(num[i]) );
      }
      faces.add(face);
    }
  }
  println("faces size is:" + faces.size() );
  allNeighbors = findAllNeighbors(faceID);
}
float rotX=0, rotY=0; //想要轉得更好
void mouseDragged(){
  rotX += mouseX-pmouseX;
  rotY -= mouseY-pmouseY;
}
void draw(){
  background(#FFFFF2);
  lights();
  translate(width/2, height/2);
  rotateY(radians(rotX)); //想要轉得更好
  rotateX(radians(rotY)); //想要轉得更好
  scale(500);
  noStroke();
  //shape(cube);
  for( PVector p : vertices ){
    //myBall(p);
  }
  //33 7 11 6 34
  fill(0,0,255);
  myBall(vertices.get(33-1));
  //myBall(vertices.get(7-1));
  //myBall(vertices.get(11-1));
  //myBall(vertices.get(6-1));
  myBall(vertices.get(34-1));
  //for( ArrayList<Integer> face : faces ){
  for(int i=0; i<faces.size(); i++){
    ArrayList<Integer> face = faces.get(i);
    if(i==faceID) fill(255, 0, 0);
    else if( strip != null && strip.indexOf(i) != -1 ) fill(255, 255, 0); //黃色
    //else if( allNeighbors.indexOf(i) != -1 ) fill(0, 255, 0);
    //else if( secondNeighbors != null && secondNeighbors.indexOf(i) != -1 ) fill(255, 0, 255); //紫色
    else fill(255);
    myFace(face);
  }
}
int faceID = 0, faceID2 = -1;
ArrayList<Integer> findAllNeighbors(int faceID) { //會把全部neighbors的代號查出來
  ArrayList<Integer> all = new ArrayList<Integer>(); //這是用來存答案 全部的鄰居
  ArrayList<Integer> face = faces.get(faceID);
  for(int i=0; i<face.size(); i++){
    int i2 = (i+1) % face.size();
    int temp = findOneNeighbor( face.get(i), face.get(i2), faceID );
    if(temp != -1) all.add(temp);
  }
  return all;
}
int findOneNeighbor( int v1, int v2, int faceID ) {
  int ans = -1;
  for(int i=0; i<faces.size(); i++) { //對 faces 裡的所有的面，都看看是不是有2個符合
    if(i==faceID) continue; //不能和本人一樣 
    int count = 0;//有幾個頂點相同？
    for(Integer v : faces.get(i) ){
      if(v==v1) count++;
      else if(v==v2) count++;
    }
    if(count==2) return i;
  }
  return ans;
}
ArrayList<Integer> allNeighbors = null;
ArrayList<Integer> secondNeighbors = null;
ArrayList<Integer> strip = null;
void keyPressed(){
  if(key=='0') faceID = 0;
  if(key=='1') faceID = 1;
  if(key=='2') faceID = 2;
  if(key=='3') faceID = 3;
  if(key=='a') faceID = (faceID+1) % faces.size();
  if(key=='b') faceID = (faceID+faces.size()-1) % faces.size();
  allNeighbors = findAllNeighbors(faceID);
  
  if(key=='s'){
    strip = new ArrayList<Integer>(); //空白的 strip
    strip.add(faceID); //先把第1個faceID加進去 strip
    //(1) 找鄰居 (2) 亂數挑 (3) 加進去
    int N, nextI, next = faceID;
    do {
      allNeighbors = findAllNeighbors(next);
      N = allNeighbors.size(); //(1) 找鄰居
      do {
        nextI = int(random(N)); //(2) 亂數挑
        next = allNeighbors.get(nextI);
      } while(strip.indexOf(next) != -1);
      
      strip.add(next); //(3) 加進去
    } while(strip.size()<6);
  }

  if(key=='c'){
    secondNeighbors = new ArrayList<Integer>();
    for(int i=0; i<allNeighbors.size(); i++){
      faceID2 = allNeighbors.get(i);
      ArrayList<Integer> temp = findAllNeighbors(faceID2);
      for(Integer t2 : temp){
        secondNeighbors.add(t2);
      }
    }
  }
  if(key=='d'){
    faceID2 = allNeighbors.get(1);
    secondNeighbors = findAllNeighbors(faceID2);
  }
}
void myFace(ArrayList<Integer> face) {
  beginShape();
  for( Integer i : face ) {
    PVector p = vertices.get(i-1);
    vertex(p.x, p.y, p.z);
  }
  endShape();
}
void myBall(PVector p) {
  pushMatrix();
    translate(p.x, p.y, p.z);
    noStroke();
    sphere(0.01);
  popMatrix();
}
