//要先安裝 OpenCV，才能使用 OpenCV的功能
//Sketch-Import Libraries, 找 opencv, 裝它
import gab.opencv.*; //Processing的OpenCV轉接
import org.opencv.calib3d.*; //findHomography()
import org.opencv.core.Core; 
import org.opencv.core.Mat; //Mat資料結構
import org.opencv.core.MatOfPoint2f; //點的資料結構
import org.opencv.core.Point;
OpenCV opencv;
MatOfPoint2f src;
MatOfPoint2f dst;
void setup(){
  size(640,480);
  opencv = new OpenCV(this, 640,480);
  src = new MatOfPoint2f();
  dst = new MatOfPoint2f();
}
void draw(){
  background(#FFFFF2);
  fill(255,0,0);
  for(int i=0; i<N; i++){
    ellipse(x[i], y[i], 10, 10);
  }
  fill(0,255,0);
  for(int i=0; i<N2; i++){
    ellipse(x2[i], y2[i], 10, 10);
  }
  if(N==4 && N2==4){ //代表你有找到 4 + 4 個點，都做好了
    double newX = h[0][0]*mouseX + h[0][1]*mouseY + h[0][2]*1;
    double newY = h[1][0]*mouseX + h[1][1]*mouseY + h[1][2]*1;
    double newZ = h[2][0]*mouseX + h[2][1]*mouseY + h[2][2]*1;
    ellipse( (float)(newX/newZ), (float)(newY/newZ), 5, 5);
  }
}
float [] x = new float[4];
float [] y = new float[4];
int N = 0;
float [] x2 = new float[4];
float [] y2 = new float[4];
int N2 = 0;
Point [] srcPt = new Point[4];
Point [] dstPt = new Point[4];
void mousePressed(){
  if(N<4){ //前4個點
    x[N] = mouseX;
    y[N] = mouseY;
    srcPt[N] = new Point(mouseX, mouseY);
    N++;
    if(N==4){
      src.fromArray(srcPt);
    }
  }else if(N2<4){ //後4個點
    x2[N2] = mouseX;
    y2[N2] = mouseY;
    dstPt[N2] = new Point(mouseX, mouseY);
    N2++;
    if(N2==4){
      dst.fromArray(dstPt);
      //全部湊齊，可以findHomography()
      Mat temp = new Mat();
      Mat H = Calib3d.findHomography(src, dst, Calib3d.RANSAC, 10, temp);
      for(int i=0; i<3; i++){
        for(int j=0; j<3; j++){
          h[i][j] = H.get(i,j)[0];
          print( H.get(i,j)[0] + " " );
        }
        println();
      }
    }
  }
}
double [][] h = new double[3][3];
