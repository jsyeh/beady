// 手動將 OBJ 檔讀進來，並將將某個 face 對應的 vertex 用陣列準備好，畫出環
PShape penguin, bead;
void setup(){
  size(500,500,P3D);
  penguin = loadShape("penguin.obj");
  //bead = loadShape("swarovski.obj");
  v[0] = v2;
  v[1] = v3;
  v[2] = v8;
  v[3] = v12;
  v[4] = v7;
}
float [][] v = new float[5][3];
float [] v2 = {0.11521881847373712, -0.13283785652828503, 0.1217738533317186};
float [] v3 = {0.13063848024845373, -0.15356716913749427, 0.0022588886720807983};
float [] v8 = {0.16195801593675974, -0.045716782889734665, -0.006947897412048257};
float [] v12 = {0.15167518181281553, 0.02868529221094248, 0.07889629120802978};
float [] v7 = {0.09256910837794742, -0.020914519797139743, 0.1639126889581805};
void draw(){
  background(#FFFFF2);
  noStroke();//stroke(255,0,0);
  lights();
  translate(250,250);
  
  rotateY(radians(frameCount));
  scale(300);
  shape(penguin);
  for(int i=0; i<5; i++){
    mySphere( v[i][0], v[i][1], v[i][2]);
  }
  for(int i=0; i<5; i++){
    stroke(255,0,0);
    strokeWeight(0.01);
    line(v[i][0], v[i][1], v[i][2], v[(i+1)%5][0], v[(i+1)%5][1], v[(i+1)%5][2]);
  }
}
void mySphere(float x, float y, float z){
  pushMatrix();
    translate(x,y,z);
    sphere(0.03);
  popMatrix();
}
