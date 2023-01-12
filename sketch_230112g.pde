// 最後重寫

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
    beginShape();
    for(Integer i : face){
      PVector p = vertices.get(i-1);
      vertex(p.x, p.y, p.z);
    }
    endShape(CLOSE);
  }
}
