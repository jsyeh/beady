PImage img;
void setup(){
  size(800,800,P3D);
  img = loadImage("arrow.png");
}
void draw(){
  perspective();
  background(#FFFFF2);
  pushMatrix();
    translate(30, 30, -300);
    image(img, 0, 0);
  popMatrix();
  pushMatrix();
    translate(200, 200, -600);
    image(img, 0, 0);
  popMatrix();
/*  if(state==0){ //讓你校正的特定位置的圖
    image(img, 0, 0);
    for(int i=0; i<N; i++){
      fill(255,0,0);
      ellipse(x[i], y[i], 10, 10);
    }
  }else if(state==1){ //簡單校正後，你的Mouse可以控制圖的移動
    image(img, mouseX+cx, mouseY+cy);
  }*/
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
