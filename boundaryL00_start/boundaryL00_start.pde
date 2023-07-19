//這個程式 from strip04
ArrayList<PVector> vertices;
ArrayList<ArrayList<Integer>> faces;
void setup(){
  size(500,500, P3D);
  String [] lines = loadStrings("cube.obj");
  prepareVertexFaces(lines);
}
void draw(){
  background(#FFFFF2);
  translate(width/2,height/2);
  lights();
  rotateY(radians(230));
  for(int i=0; i<faces.size(); i++){
    if(i==faceID) fill(#FF0000,128);//紅色
    else fill(128,128);
    drawFace( faces.get(i) );
  }
}
int faceID=1;
void keyPressed(){
  if(key=='0') faceID=0;
  if(key=='1') faceID=1;
  if(key=='2') faceID=2;
  if(key=='3') faceID=3;
}
void drawFace(ArrayList<Integer> face) {
  beginShape();
  for( Integer i : face ){
    print(i + " ");
    PVector v = vertices.get(i-1); //OBJ的f從1開始，但程式從0開始
    vertex( v.x, v.y, v.z ); //座標都相同時，會閃爍（depth相同）
  }
  println();
  endShape();
}
void prepareVertexFaces(String [] lines) {
  vertices = new ArrayList<PVector>();
  faces = new ArrayList<ArrayList<Integer>>();
  for (int i=0; i<lines.length; i++) {
    String line = lines[i];
    char c = line.charAt(0);
    if (c=='v') {
      String [] nums = split(line, " ");
      PVector p = new PVector( float(nums[1]), float(nums[2]), float(nums[3]) );
      vertices.add(p);
    } else if (c=='f') {
      String [] nums = split(line, " ");
      ArrayList<Integer> temp = new ArrayList<Integer>();
      for (int k=1; k<nums.length; k++) {
        temp.add( int(nums[k]) );
      }
      faces.add(temp);
    }
  }
}
//相鄰的面，有共享一個邊 v1,v2
//在 faces裡，找有沒有face裡面含 v1,v2 的呢？
int findNeighborFace(int v1, int v2, int myself){
  for(int f=0; f<faces.size(); f++){
    if(f==myself) continue;
    ArrayList<Integer> face = faces.get(f);
    int count=0;//face這個面，有幾個頂點，和v1或v2相同？
    for(int i=0; i<face.size(); i++){
      int v = face.get(i);
      if(v==v1) count++;
      else if(v==v2) count++;
    }
    if(count==2) return f;
  }
  return -1;//找不到
}
