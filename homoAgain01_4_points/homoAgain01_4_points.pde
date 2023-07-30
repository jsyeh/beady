float [] gx = {  30, 330, 330, 630};
float [] gy = { 130, 430,-170, 130};
float [] gz = {-300,-600,-300,-600};
void setup(){
  size(800, 800, P3D);
}
void draw(){
  background(#FFFFF2);
  for(int i=0; i<4; i++){
    pushMatrix();
      translate(gx[i], gy[i], gz[i]);
      sphere(10);
    popMatrix();
  }
}
