float [] gx = {  30, 330, 330}; //剛剛座標有錯
float [] gy = { 130, 430,-170}; //換成新的座標
float [] gz = {-300,-600,-300}; //小心直的、橫的
void setup(){
  size(800, 800, P3D); //在3D的世界
}
void draw(){
  background(#FFFFF2);
  fill(255,0,0);
  for(int i=0; i<=N && i<3; i++){ //加奇怪的迴圈
    pushMatrix(); //圖學的 push matrix
      translate(gx[i], gy[i], gz[i]); //移動
      sphere(10); //畫圓球
    popMatrix(); //圖學的 pop matrix
  }
  
  fill(0, 255, 0);
  for(int i=0; i<N; i++){
    ellipse(x[i], y[i], 10, 10);
  }
}
float [] x = new float[6];
float [] y = new float[6];
int N = 0;
PVector strangeX = null, strangeY = null, strangeZ = null;
PVector axis3X = null, axis3Y = null, axis3Z = null;
void mousePressed(){
  if(N>=3) return; //只能點3個點哦
  x[N] = mouseX;
  y[N] = mouseY;
  N++;
  if(N==3){ //寄生蟲，湊齊3個頂點
    strangeX = new PVector(x[1]-x[0],  y[1]-y[0]).normalize();
    strangeY = new PVector(x[2]-x[0],  y[2]-y[0]).normalize();
    strangeZ = strangeX.cross(strangeY);
    println("strangeZ的長度：" + strangeZ.mag());
    axis3X = new PVector(gx[1]-gx[0],  gy[1]-gy[0],  gz[1]-gz[0]).normalize();
    axis3Y = new PVector(gx[2]-gx[0],  gy[2]-gy[0],  gz[2]-gz[0]).normalize();
    println("axis3X的長度：" + axis3X.mag() );
    axis3Z = axis3X.cross(axis3Y);
    println(axis3Z);
    println(axis3Z.mag());
  }
}
