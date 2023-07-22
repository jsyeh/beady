PImage img;
void setup(){
  size(800,800);
  img = loadImage("arrow.png");
}
void draw(){
  image(img, 0, 0);
}
