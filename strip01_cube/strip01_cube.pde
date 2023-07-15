PShape cube;
void setup(){
  size(500,500, P3D);
  cube = loadShape("cube.obj");
}
void draw(){
  background(#FFFFF2);
  translate(width/2,height/2);
  lights();
  rotateY(radians(frameCount));
  shape(cube);
}
