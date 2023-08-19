PShape bunny;
void setup(){
  size(500,500, P3D);
  bunny = loadShape("output.obj");
}
void draw(){
  background(#FFFFF2);
  translate(width/2, height/2);
  scale(1000);
  shape(bunny);
}
