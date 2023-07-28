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
void mousePressed(){
  if(N>=3) return; //只能點3個點哦
  x[N] = mouseX;
  y[N] = mouseY;
  N++;
}
