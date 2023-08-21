//參考 https://processing.org/reference/libraries/net/Client_read_.html
import processing.net.*; 
Client myClient;
int dataIn; 

void setup() {
  size(255, 255);
  myClient = new Client(this, "127.0.0.1", 5204); // 可換成server IP
}
int x=0, y=0;
void draw() {
  if (myClient.available() > 0) {
    x = myClient.read();
    y = myClient.read();
  }
  background(#FFFFF2);
  ellipse(x, y, 8, 8);
}
