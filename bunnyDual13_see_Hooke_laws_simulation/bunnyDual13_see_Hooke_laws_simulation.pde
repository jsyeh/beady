//將 2023-08-19 bunnyDual01 與 2023年2月的 step04-01 ArrayList 結合
//https://github.com/jsyeh/beady
//再加上2023-08-19 bunnyDual04 的2行
//        String[] fDetail = split(nums[k], "/"); //新加的內容,要解決/的斷字
//        temp.add( int(fDetail[0]) ); //新加的內容,要解決/的斷字

//PShape bunny;
ArrayList<PVector> vertices;
ArrayList<ArrayList<Integer>> faces;
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
        //temp.add( int(nums[k]) );//新註解掉的程式,不要直接做事
        String[] fDetail = split(nums[k], "/"); //新加的內容,要解決/的斷字
        temp.add( int(fDetail[0]) ); //新加的內容,要解決/的斷字
       
      }
      faces.add(temp);
    }
  }
}
void setup(){
  size(500,500, P3D);
  //bunny = loadShape("output.obj");
  String [] lines = loadStrings("output.obj");
  prepareVertexFaces(lines);
  findCenters(); //bunnyDual06_center_dual 要算中心點
  findNeighbors();
}
ArrayList< int [] > neighbors = new ArrayList< int [] > ();
boolean shareTwoVertex(int i, int j){ //face i face j 是否是鄰居
  int share = 0;
  for(int ii : faces.get(i)){ //face i 的頂點 ii
    if(faces.get(j).indexOf(ii) != -1) share++;
  }
  if(share==2)  return true;
  else return false;
}
void findNeighbors(){
  float totalLen = 0; //要算平均長度(供虎克彈簧模擬使用)
  for(int i=0; i<centers.size(); i++){
    for(int j=i+1; j<centers.size(); j++){
      if( shareTwoVertex(i,j) ) {
        int [] neighbor = {i, j}; //centers[i] centers[j] 是鄰居
        neighbors.add(neighbor); //只是測一下語法,還沒有真的拿來用
        totalLen += PVector.sub(centers.get(i),centers.get(j)).mag();
      } //把兩個center 點連線的距離算出來,加到 totalLen
    }
  }
  HookeLen = totalLen / neighbors.size(); //算平均
}
void applyOneHooke(){
  for(int [] neighbor : neighbors){
    int a = neighbor[0], b = neighbor[1];
    HookeForce( centers.get(a), centers.get(b), HookeLen);
  }  
}
void keyPressed(){
  for(int i=0; i<100; i++){
    applyOneHooke();
  }
}
float HookeLen = 0;
//下面的函式,是由 hookeAgain08_average_len_as_hooke提供
void HookeForce(PVector p1, PVector p2, float HookeLen){
  PVector v = PVector.sub(p2, p1);
  float len = v.mag();
  v.normalize(); //長度為1的單位向量
  v.mult( -(len-HookeLen)/100.0 ); //虎克定律有個負號
  p2.x += v.x;
  p2.y += v.y;
  p2.z += v.z;
  p1.x -= v.x;
  p1.y -= v.y;
  p1.z -= v.z;
}
void findCenters(){
  for(ArrayList<Integer> face : faces){ //每一個面
    PVector center = new PVector(); //0,0,0
    for(Integer i : face){ //有很多個頂點
      PVector p = vertices.get(i-1);
      center.add(p); //頂點加起
    }
    center.div( face.size() ); //除總數,平均
    centers.add(center);
  }
}
ArrayList<PVector> centers = new ArrayList<PVector>();
void draw(){
  background(#FFFFF2);
  translate(width/2, height/2);
  translate(0, 200); //希望output.obj 兔子,放在畫面的中心
  scale(2000,-2000,2000); //放大一些,同時Y變成負的
  rotateY(radians(frameCount)); //先不要轉,以便確認 applyOneHooke()
  lights();//再加這行打光
  stroke(255,0,0); //用紅色畫線
  strokeWeight(0.001); //線會被放大,所以事先縮小
  for(PVector center : centers){ //神奇的for迴圈
    point(center.x, center.y, center.z); //畫點
  }
  drawNeighborsLine();
}
void drawNeighborsLine(){
  for(int[] neighbor : neighbors){
    int a = neighbor[0], b = neighbor[1];
    PVector p = centers.get(a), q = centers.get(b);
    line(p.x, p.y, p.z, q.x, q.y, q.z);
  }
}
