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
  scale(1500);
  lights();//再加這行打光
  stroke(255,0,0); //用紅色畫線
  strokeWeight(0.001); //線會被放大,所以事先縮小
  for(ArrayList<Integer> face : faces){
    beginShape();
    for(Integer i : face){
      PVector p = vertices.get(i-1);
      vertex(p.x, p.y, p.z);
    }
    endShape(CLOSE);
  }
  strokeWeight(0.003); //點要畫粗一些 比0.001大一些
  for(PVector center : centers){ //神奇的for迴圈
    point(center.x, center.y, center.z); //畫點
  }
}
