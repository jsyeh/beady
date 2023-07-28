void setup(){
  size(800, 800);
}
void draw(){
  if(N>0) ellipse(x, y, 10, 10);
}
float x, y;
int N = 0;
void mousePressed(){
  x = mouseX;
  y = mouseY;
  N++;
}
