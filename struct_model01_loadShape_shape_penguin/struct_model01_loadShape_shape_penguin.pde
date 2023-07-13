//之前的 penguin_bead 把 edge 變成bead
//現在，是把 polygon 裡的 vertex 變成 綠色wire edge
PShape penguin;
ArrayList<PVector> vertices;
ArrayList<ArrayList<Integer>> faces;
void setup(){
  size(400, 400, P3D);
  String [] lines = loadStrings("penguin.obj"); //penguin = loadShape("penguin.obj");
  penguin = loadShape("penguin.obj");
  //prepareVertexFaces(lines);
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
