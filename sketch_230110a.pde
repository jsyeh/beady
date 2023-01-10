// 這個版本，可以做出閃亮的企鵝
PVector [] OBJv;
ArrayList<ArrayList<Integer>> OBJf;
int v, f;
void myLoadShape(String file){
  String[] lines = loadStrings(file);
  v=0;
  f=0;
  for(int i=0; i<lines.length; i++){
    //println(lines[i]);
    char c = lines[i].charAt(0);
    if(c=='v') v++;
    if(c=='f') f++;
  }
  println("total vertex: ", v, "total face: ", f);
  OBJv = new PVector[v+1]; //因為OBJ檔的 f 裡面的頂點 v 是從1開始數
  OBJf = new ArrayList<ArrayList<Integer>>();
  v = 1;
  f = 0;
  for(int i=0; i<lines.length; i++){
    char c = lines[i].charAt(0);
    if(c=='v'){
      String[] nums = split(lines[i], " "); //把 lines[i] 切出3個數字
      OBJv[v] = new PVector(float(nums[1]), float(nums[2]), float(nums[3]));
      println(OBJv[v]);
      v++;
    }
    if(c=='f'){
      String[] nums = split(lines[i], " ");
      //f 2 3 8 12 7
      ArrayList<Integer> temp = new ArrayList<Integer>() ;
      for(int k=1; k<nums.length; k++){
        //print(nums[k], " " );
        temp.add( int(nums[k]) ) ;
      }
      OBJf.add(temp);
      //println("=====");
      f++;
    }
  }
  println(v);
}
void setup(){
  size(500,500,P3D);
  myLoadShape("penguin.obj");
}
void draw(){
  background(#FFFFF2);
  translate(width/2, height/2);
  rotateY(radians(mouseX));
  scale(300);
  for(int z=0; z<OBJf.size(); z++){
    beginShape();
    stroke(random(255), random(255), random(255) );
    strokeWeight(0.03);
    ArrayList<Integer> ff =OBJf.get(z);
    for(int i=0; i<ff.size(); i++){
      int k = ff.get(i);
      PVector now = OBJv[k];
      vertex(now.x, now.y, now.z);
    }
    //for(int i=1; i<v; i++){
    //  vertex(OBJv[i].x, OBJv[i].y, OBJv[i].z);
    //}
    endShape(CLOSE);
  }
}
