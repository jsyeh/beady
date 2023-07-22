PImage img;
void setup(){
  size(800,800);
  img = loadImage("arrow.png");
}
void draw(){
  image(img, 0, 0);
  for(int i=0; i<N; i++){
    fill(255,0,0);
    ellipse(x[i], y[i], 10, 10);
  }
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
