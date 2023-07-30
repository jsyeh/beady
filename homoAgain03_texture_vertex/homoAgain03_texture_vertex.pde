float [] gx = {  30, 330, 330, 630};
float [] gy = { 130, 430,-170, 130};
float [] gz = {-300,-600,-300,-600};
PImage imgChessboard;
void setup(){
  size(800, 800, P3D);
  imgChessboard = loadImage("chessboard.png");
}
void draw(){
  background(#FFFFF2);
  stroke(255,0,0);
  //https://processing.org/reference/vertex_.html
  //glTexCoord2f(tx,ty); glVertex3f(x,y,z); ==> vertex(x,y,z, tx,ty);
  beginShape();
    textureMode(NORMAL); 
    texture(imgChessboard);
    vertex(gx[0], gy[0], gz[0], 0, 0);
    vertex(gx[1], gy[1], gz[1], 1, 0);
    vertex(gx[3], gy[3], gz[3], 1, 1);
    vertex(gx[2], gy[2], gz[2], 0, 1);
  endShape(CLOSE);
  for(int i=0; i<4; i++){
    pushMatrix();
      translate(gx[i], gy[i], gz[i]);
      sphere(10);
    popMatrix();
  }
  float oldX = mouseX;
  float oldY = mouseY;
  float oldZ = 0;
  PVector Tx = new PVector(gx[1]-gx[0], gy[1]-gy[0], gz[1]-gz[0]).normalize();
  PVector Ty = new PVector(gx[2]-gx[0], gy[2]-gy[0], gz[2]-gz[0]).normalize();
  PVector Tz = Tx.cross(Ty);
println( Tz.mag() );
  //float newX = Tx.x*oldX + Tx.y*oldY + Tx.z*oldZ + gx[0]*1;
  //float newY = Ty.x*oldX + Ty.y*oldY + Ty.z*oldZ + gy[0]*1;
  //float newZ = Tz.x*oldX + Tz.y*oldY + Tz.z*oldZ + gz[0]*1;  
  float newX = Tx.x*oldX + Ty.x*oldY + Tz.x*oldZ + gx[0]*1;
  float newY = Tx.y*oldX + Ty.y*oldY + Tz.y*oldZ + gy[0]*1;
  float newZ = Tx.z*oldX + Ty.z*oldY + Tz.z*oldZ + gz[0]*1;  
    pushMatrix();
      translate(newX, newY, newZ);
      sphere(10);
    popMatrix();
}
