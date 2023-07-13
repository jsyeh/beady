//之前的 penguin_bead 把 edge 變成bead
//現在，是把 polygon 裡的 vertex 變成 綠色wire edge
PShape penguin;
ArrayList<PVector> vertices;
ArrayList<ArrayList<Integer>> faces;
void setup(){
  size(400, 400, P3D);
  String [] lines = loadStrings("penguin.obj"); //penguin = loadShape("penguin.obj");
  penguin = loadShape("penguin.obj");
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
  background(#FFFFF2);
  lights();
  pushMatrix();
    translate(width/2, height/2);
    scale(500);
    rotateY(radians(mouseX));
    shape(penguin);
  popMatrix();
}
