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
}
void draw(){
  background(#FFFFF2);
  translate(width/2, height/2);
  scale(1000);
  //shape(bunny);
  lights();//再加這行打光
  fill(128);//再點灰色
  noStroke();
  for(ArrayList<Integer> face : faces){
    beginShape();
    for(Integer i : face){
      PVector p = vertices.get(i-1);
      vertex(p.x, p.y, p.z);
    }
    endShape(CLOSE);
  }
}
