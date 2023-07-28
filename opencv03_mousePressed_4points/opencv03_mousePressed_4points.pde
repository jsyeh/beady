//要先安裝 OpenCV，才能使用 OpenCV的功能
//Sketch-Import Libraries, 找 opencv, 裝它
import gab.opencv.*; //Processing的OpenCV轉接
import org.opencv.calib3d.*; //findHomography()
import org.opencv.core.Core; 
import org.opencv.core.Mat; //Mat資料結構
import org.opencv.core.MatOfPoint2f; //點的資料結構
import org.opencv.core.Point;
OpenCV opencv;
void setup(){
  size(640,480);
  opencv = new OpenCV(this, 640,480);
}
void draw(){
  background(#FFFFF2);
  for(int i=0; i<N; i++){
    ellipse(x[i], y[i], 10, 10);
  }
}
float [] x = new float[4];
float [] y = new float[4];
int N = 0;
void mousePressed(){
  if(N<4){
    x[N] = mouseX;
    y[N] = mouseY;
    N++;
  }
}
