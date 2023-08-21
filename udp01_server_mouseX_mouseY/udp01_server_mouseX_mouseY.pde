//參考 https://processing.org/reference/libraries/net/Server.html
import processing.net.*;

Server myServer;
int val = 0;

void setup() {
  size(255, 255);
  myServer = new Server(this, 5204); 
}

void draw() {
  background(#FFFFF2);
  myServer.write(mouseX);
  myServer.write(mouseY);
  ellipse(mouseX, mouseY, 8, 8);
}
