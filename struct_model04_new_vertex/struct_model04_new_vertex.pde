//之前的 penguin_bead 把 edge 變成bead
//現在，是把 polygon 裡的 vertex 變成 綠色wire edge
PShape penguin;
ArrayList<PVector> newVertices;
ArrayList<PVector> vertices;
ArrayList<ArrayList<Integer>> faces;
void setup(){
  size(400, 400, P3D);
  String [] lines = loadStrings("penguin.obj"); //penguin = loadShape("penguin.obj");
  penguin = loadShape("penguin.obj");
  prepareVertexFaces(lines);
  generateNewVertex(4);
}
void generateNewVertex(float ratio){
  newVertices = new ArrayList<PVector>();
  for(ArrayList<Integer> face : faces){
    int N = face.size();
    for(int i=0; i<N; i++){
      Integer k1 = face.get(i), k2 = face.get((i+1)%N);
      PVector p1 = vertices.get(k1-1), p2 = vertices.get(k2-1);
      PVector center = PVector.add(p1,p2).div(2);
      PVector p1_10 = PVector.mult(p1,ratio);
      PVector p2_10 = PVector.mult(p2,ratio);
      PVector newp1 = PVector.add(p1_10,center).div(ratio+1);
      PVector newp2 = PVector.add(p2_10,center).div(ratio+1);
      //newVertices.add(center);
      newVertices.add(newp1);
      newVertices.add(newp2);
    }
  }
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
    for(PVector center : newVertices){
      pushMatrix();
        translate(center.x, center.y, center.z);
        noStroke();
        sphere(0.003);
      popMatrix();
    }
  popMatrix();
}
