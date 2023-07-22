PImage img;
PVector[] point3;
void setup(){
  size(800,800,P3D);
  img = loadImage("arrow.png");
  point3 = new PVector[3];
  point3[0] = new PVector(30, 130, -300);
  point3[1] = new PVector(330, 430, -600);
  point3[2] = new PVector(330, -170, -300);
  
}
void draw(){
  perspective();
  background(#FFFFF2);
  if(state==0){ //讓你校正的特定位置的圖
    for(int i=0; i<=N && i<3; i++){
      pushMatrix();
        translate(point3[i].x, point3[i].y, point3[i].z);
        image(img, 0, 0);
      popMatrix();
    }
    for(int i=0; i<N; i++){ //把2個2D的點（你的mouse或你影像中的手）
      fill(255,0,0);
      ellipse(x[i], y[i], 10, 10);
    }
  }else if(state==1){ //簡單校正後，你的Mouse可以控制圖的移動
    //image(img, mouseX+cx, mouseY+cy);
  }
}
float cx=0, cy=0; //calibrate用的 x,y
int state=0;
void keyPressed(){
  state = 1;
  cx = -x[0];
  cy = -y[0];
}
float [] x = new float[5];
float [] y = new float[5];
int N = 0;
void mousePressed(){
  println(mouseX, mouseY);
  x[N] = mouseX;
  y[N] = mouseY;
  N++;
}
