# beady
Teach students how to implement Yuki Igarashi's Beady (SIGGRAPH 2012) paper

# Step-by-Step tutorials
使用 Processing 一步步進行實作

# Step 01: 先建立 Processing 的 3D 基礎

- 了解 `P3D` 可開啟 Processing 的 OpenGL 3D 的功能
- `box()` 就很像 `glutSolidCube()`
- 看到東西在左上角，表示座標原點在左上角

## step01-1 了解 P3D 及 box()
```processing
void setup(){
  size(300, 300, P3D);
}
void draw(){
  box(100);
}
```

## step01-2 了解轉動 rotate() 及 角度弧度換算 radians()

- `rotate()` 與大二下學過的電腦圖學 OpenGL 的 `glRotatef()` 有關 
- `radians()` 是換算 degrees 及 radians 

```processing
void setup(){
  size(300, 300, P3D);
}
void draw(){
  background(#FFFFF2);
  rotate(radians(mouseX));
  box(100);
}
```

## step01-3 了解 pushMatrix() popMatrix() 及移動 translate()

- 這些指令，與大二下學過的電腦圖學 OpenGL 的 `glPushMatrix()` `glPopMatrix()` `glTranslatef()` 有關 
- 為了讓物體在畫面正中心，所以需要 `transalte()` 將物體移到 (寬度一半, 高度一半) 的位置
```processing
void setup(){
  size(300, 300, P3D);
}
void draw(){
  background(#FFFFF2);
  pushMatrix();
    translate(150,150);
    rotateY(radians(mouseX));
    box(100);
  popMatrix();
}
```

## step01-4 了解打光 lights() 

原本 OpenGL 打光有點複雜，不過在 Processing 中，只要一行 `lights()` 就好了。

```processing
void setup(){
  size(300, 300, P3D);
}
void draw(){
  lights();
  background(#FFFFF2);
  pushMatrix();
    translate(150,150);
    rotateX(-radians(mouseY));
    rotateY(-radians(mouseX));
    box(100);
  popMatrix();
}
``` 

## step01-5 了解 beginShape() endShape() vertex()

這些指令，與大二下學過的電腦圖學 OpenGL 的 `glBegin()` `glEnd()` `glVertex3f()` 有關 

```processing
void setup(){
  size(300, 300, P3D);
}
void draw(){
  lights();
  background(#FFFFF2);
  pushMatrix();
    translate(150,150);
    rotateX(-radians(mouseY));
    rotateY(-radians(mouseX));
    myShape();//box(100);
  popMatrix();
}
void myShape(){
  beginShape();  // glBegin(POLYGON);
    vertex(-50, -50);  // glVertex2f(x,y);
    vertex(-50, 50);
    vertex(50, 50);
    vertex(50, -50);  
  endShape(CLOSE);    // glEnd();
}
```

## step01-6 了解 sphere()

先畫出圓球

```processing
size(300, 300, P3D);
sphere(112);
```

因為球有太多線條，所以 `noStroke()` 才不會太多線條太花。但是看起來像白色的圓，所以加上打光的效果 `lights()`

```processing
size(300,300,P3D);
lights();
noStroke();
sphere(112);
```

最後再把球移到畫面的中心。完成的程式，其實與 Processing 官網的 `sphere()` Reference 很像，但希望大家能體會「程式成長的過程」

```processing
size(300,300,P3D);
lights();
noStroke();
translate(150,150);
sphere(112);
```


## step01-7 在 box 的邊上畫 sphere

試著模仿 Beady (SIGGRAPH Asia 2011) https://www.is.ocha.ac.jp/~yuki/papers/beady_SIGA2011sketch.pdf
Figure 3 在 box 的邊上畫 sphere

```processing
void setup(){
  size(300,300,P3D);
}
void draw(){
  background(#FFFFF2);
  lights();
  pushMatrix();
    translate(150,150);
    rotateY(radians(frameCount));
    stroke(0);
    box(100);
    mySphere( 50, 0, 50);
    mySphere(-50, 0, 50);
    mySphere( 50, 0, -50);
    mySphere(-50, 0, -50);
  popMatrix();
}
void mySphere(float x, float y, float z){
  pushMatrix();
    noStroke();
    translate(x,y,z);
    sphere(50);
  popMatrix();
}
```

# Step 02: PShape 與 OBJ 模型
在 Yuki Igarashi 的論文網站中，有 beady_en.zip 程式可以下載。下載後，發現裡面有許多 OBJ 模型，所以接下來將模型試著讀讀看。

## step02-1 PShape 及 loadShape() 與 shape()

下面是程式的基礎型，先將 penguin.obj 接到程式中，但是在執行時沒有看到模型。
```processing
size(500,500,P3D);
PShape penguin = loadShape("penguin.obj");
shape(penguin);
```

經研究 penguin.obj 內容後，發現裡面 vertex 的範圍介於 -1...+1 之間

```
child 0
v -0.12191772920605067 -0.13222121191864572 0.11876787243413596
v 0.11521881847373712 -0.13283785652828503 0.1217738533317186
v 0.13063848024845373 -0.15356716913749427 0.0022588886720807983
...
```

所以要縮放一下

```processing
size(500,500,P3D);
PShape penguin = loadShape("penguin.obj");
scale(300);
shape(penguin);
```

## step02-2 會轉動的模型

看到模型後，嘗試改成可互動的版本，以便轉動模型。
接下來便可以將不同的模型都畫出來，認識有哪些模型。

```processing
PShape penguin;
void setup(){
  size(500,500,P3D);
  penguin = loadShape("penguin.obj");
}
void draw(){
  background(#FFFFF2);
  noStroke();
  lights();
  translate(250,250);
  rotateY(radians(frameCount));
  scale(300);
  shape(penguin);
}
```

## step02-3 用小球把一些頂點秀出來 

研究完 penguin.obj 後，決定把第1個 face 的頂點 用陣列來準備好，畫出這些頂點。
```
f 2 3 8 12 7
```

沒想到畫出來的東西一團黑。

```processing
PShape penguin, bead;
void setup(){
  size(500,500,P3D);
  penguin = loadShape("penguin.obj");
  bead = loadShape("swarovski.obj");
  v[0] = v2;
  v[1] = v3;
  v[2] = v8;
  v[3] = v12;
  v[4] = v7;
}
float [][] v = new float[5][3];
float [] v2 = {0.11521881847373712, -0.13283785652828503, 0.1217738533317186};
float [] v3 = {0.13063848024845373, -0.15356716913749427, 0.0022588886720807983};
float [] v8 = {0.16195801593675974, -0.045716782889734665, -0.006947897412048257};
float [] v12 = {0.15167518181281553, 0.02868529221094248, 0.07889629120802978};
float [] v7 = {0.09256910837794742, -0.020914519797139743, 0.1639126889581805};
void draw(){
  background(#FFFFF2);
  lights();
  translate(250,250);
  
  rotateY(radians(frameCount));
  scale(300);
  shape(penguin);
  for(int i=0; i<5; i++){
    mySphere( v[i][0], v[i][1], v[i][2]);
  }
}
void mySphere(float x, float y, float z){
  pushMatrix();
    translate(x,y,z);
    sphere(0.03);
  popMatrix();
}
```

原來是 sphere() 實在是太小了，結果 sphere() 預設的 stroke 比 sphere還大。
所以解決方式，是另外加上 `noStroke()` 就正常了。可以看到小球在企鵝的左臉上有這些小球。

## step02-4 將這幾個 vertex 用 line 連起來

```processing
PShape penguin, bead;
void setup(){
  size(500,500,P3D);
  penguin = loadShape("penguin.obj");
  //bead = loadShape("swarovski.obj");
  v[0] = v2;
  v[1] = v3;
  v[2] = v8;
  v[3] = v12;
  v[4] = v7;
}
float [][] v = new float[5][3];
float [] v2 = {0.11521881847373712, -0.13283785652828503, 0.1217738533317186};
float [] v3 = {0.13063848024845373, -0.15356716913749427, 0.0022588886720807983};
float [] v8 = {0.16195801593675974, -0.045716782889734665, -0.006947897412048257};
float [] v12 = {0.15167518181281553, 0.02868529221094248, 0.07889629120802978};
float [] v7 = {0.09256910837794742, -0.020914519797139743, 0.1639126889581805};
void draw(){
  background(#FFFFF2);
  noStroke();//stroke(255,0,0);
  lights();
  translate(250,250);
  
  rotateY(radians(frameCount));
  scale(300);
  shape(penguin);
  for(int i=0; i<5; i++){
    mySphere( v[i][0], v[i][1], v[i][2]);
  }
  for(int i=0; i<5; i++){
    stroke(255,0,0);
    strokeWeight(0.01);
    line(v[i][0], v[i][1], v[i][2], v[(i+1)%5][0], v[(i+1)%5][1], v[(i+1)%5][2]);
  }
}
void mySphere(float x, float y, float z){
  pushMatrix();
    translate(x,y,z);
    sphere(0.03);
  popMatrix();
}
```

# Step03: ArrayList

## step03-0

```processing
// 這個版本，可以做出閃亮的企鵝
PVector [] OBJv;
ArrayList<ArrayList<Integer>> OBJf;
int v, f;
void myLoadShape(String file){
  String[] lines = loadStrings(file);
  v=0;
  f=0;
  for(int i=0; i<lines.length; i++){
    //println(lines[i]);
    char c = lines[i].charAt(0);
    if(c=='v') v++;
    if(c=='f') f++;
  }
  println("total vertex: ", v, "total face: ", f);
  OBJv = new PVector[v+1]; //因為OBJ檔的 f 裡面的頂點 v 是從1開始數
  OBJf = new ArrayList<ArrayList<Integer>>();
  v = 1;
  f = 0;
  for(int i=0; i<lines.length; i++){
    char c = lines[i].charAt(0);
    if(c=='v'){
      String[] nums = split(lines[i], " "); //把 lines[i] 切出3個數字
      OBJv[v] = new PVector(float(nums[1]), float(nums[2]), float(nums[3]));
      println(OBJv[v]);
      v++;
    }
    if(c=='f'){
      String[] nums = split(lines[i], " ");
      //f 2 3 8 12 7
      ArrayList<Integer> temp = new ArrayList<Integer>() ;
      for(int k=1; k<nums.length; k++){
        //print(nums[k], " " );
        temp.add( int(nums[k]) ) ;
      }
      OBJf.add(temp);
      //println("=====");
      f++;
    }
  }
  println(v);
}
void setup(){
  size(500,500,P3D);
  myLoadShape("penguin.obj");
}
void draw(){
  background(#FFFFF2);
  translate(width/2, height/2);
  rotateY(radians(mouseX));
  scale(300);
  for(int z=0; z<OBJf.size(); z++){
    beginShape();
    stroke(random(255), random(255), random(255) );
    strokeWeight(0.03);
    ArrayList<Integer> ff =OBJf.get(z);
    for(int i=0; i<ff.size(); i++){
      int k = ff.get(i);
      PVector now = OBJv[k];
      vertex(now.x, now.y, now.z);
    }
    //for(int i=1; i<v; i++){
    //  vertex(OBJv[i].x, OBJv[i].y, OBJv[i].z);
    //}
    endShape(CLOSE);
  }
}
```

## step03-1
```processing
// 解釋陣列、ArrayList
//昨天在講在陣列的時候，有點難理解。所以慢慢來
//ArrayList<ArrayList<Integer>> ff;
// int a[10]; //C or C++  大小固定！！！
// int b[10][20]; //C or C++  大小固定！！！
int [] a;
int [][] b;
  
a = new int[10]; //Java  可以在之後再決定大小, 大小固定！！！
b = new int[10][20]; //Java

a = new int[200];
//然後再把前面10個，慢慢copy到新的a[i]
//以上的程式，都有致命問題 大小固定！！！

//不固定大小時
// C++                     C
// vector<int> v;  //就像是 int v[1000];
// 會長大的陣列！！
ArrayList<Integer> v;// Java的寫法
v = new ArrayList<Integer>(); //準備好，可變大
// PVector p = new PVector(10,20,30);
v.add( 300 );
v.add( 200 );
v.add( 500 );
```

## step03-2
```processing
// 為方便了解 ArrayList, 所以用畫圖的方法，來看如何 add() 及對應for迴圈

ArrayList<Integer> v;

v = new ArrayList<Integer>();

v.add(2);
v.add(3);
v.add(8);
v.add(12);
v.add(7);

textSize(60);
size(520,120);
for(int i=0; i<5; i++){
  fill(255);
  rect(i*100,0, 100,100);
  
  fill(0);
  text(v.get(i), i*100, 50);
}
```

## step03-3
```processing
// 介紹 ArrayList<Integer> v; 裡面用 add() 來加點，再用迴圈取出

ArrayList<Integer> v;

v = new ArrayList<Integer>();

v.add(2);
v.add(3);
v.add(8);
v.add(12);
v.add(7);
for( int n : v ){
  print(n, " ");
}

//for(int i = 0; i < v.size(); i++){
//  print(  v.get(i) , " ");
//}
```

## step03-4
```processing
// 在介紹 ArrayList<ArrayList<Integer>> 之前，要先介紹簡單一點點的版本
// 寫出範例方便理解
ArrayList<Integer> v1;
ArrayList<Integer> v2;
ArrayList<Integer> v3;
ArrayList<Integer> v4;
ArrayList<Integer> v5;

v1 = new ArrayList<Integer>();
v1.add(2);
v1.add(3);
v1.add(8);
v1.add(12);
v1.add(7);

v2 = new ArrayList<Integer>();
v2.add(6);
v2.add(11);
v2.add(16);
v2.add(15);
v2.add(10);

v3 = new ArrayList<Integer>();
v3.add(7);
v3.add(12);
```

## step03-5
```processing
// 如果有很多 face 那就用 ArrayList<ArrayList<Integer>> 配合迴圈來簡化囉

ArrayList<  ArrayList<Integer> > faces;
//可以用陣列，來讓 很多變數 變陣列

faces = new ArrayList<ArrayList<Integer>>();

for(int k=0; k<5; k++){
  ArrayList<Integer> temp = new ArrayList<Integer>();
  temp.add(1);
  temp.add(2);
  temp.add(3);
  faces.add(temp);
}

for( ArrayList<Integer> f : faces ){
  for( Integer i : f ){
    print(i); //其中的數字
  }
  println(); //跳行
}
```

## step03-6
```processing
// 2D 的咖啡豆轉動

PVector p1, p2;
void setup(){
  size(400,400,P3D);
  p1 = new PVector();
  p2 = new PVector();
}
void draw(){
  background(#FFFFF2);
  line(p1.x, p1.y, p2.x, p2.y);
  myEllipse();
}
void mousePressed(){
  p1.x = mouseX;
  p1.y = mouseY;
  p2.x = mouseX;
  p2.y = mouseY;
}
void mouseDragged(){
  p2.x = mouseX;
  p2.y = mouseY;
}
void myEllipse(){
  PVector v = PVector.sub(p2, p1);
  PVector c = PVector.add(p1, p2).div(2);
  float len = v.mag();
  float angle = atan2(v.y, v.x);
  pushMatrix();
    translate(c.x, c.y);
    rotateZ(angle);
    ellipse(0, 0, len, len/2); //x 是長軸
  popMatrix();
}
```

## step03-7
```processing
// 想要了解怎麼轉動珠子，所以利用 atan2() 來旋轉

PVector p1, p2;
void setup(){
  size(500,500,P3D);
  p1 = new PVector();
  p2 = new PVector();
}
void draw(){
  background(#FFFFF2);
  line(p1.x, p1.y, p2.x, p2.y);
  mySphere(p1);
  mySphere(p2);
  myBead();
}
void mousePressed(){
  p1.x = mouseX;
  p1.y = mouseY;
  p2.x = mouseX;
  p2.y = mouseY;
}
void mouseDragged(){
  p2.x = mouseX;
  p2.y = mouseY;
}
void mySphere(PVector p){
  pushMatrix();
    translate(p.x, p.y, p.z);
    sphere(10);
  popMatrix();
}
void myBead(){
  PVector v = PVector.sub(p2, p1);
  PVector c = PVector.add(p1, p2).div(2);
  float len = v.mag();
  float angle1 = atan2(v.y, v.x);
  float angle2 = atan2(v.z, v.x);
  //https://stackoverflow.com/questions/42554960/get-xyz-angles-between-vectors
  // vec3 u = vec3( 1,  0,  0); 
  // vec3 v = vec3(vx, vy, vz);
  //float x_angle = acos(0);//dot(yz)
  //float y_angle = acos(v.x);//dot(xz)
  //float z_angle = acos(//dot(xy)
  pushMatrix();
    translate(c.x, c.y);
    rotateZ(angle1);
    rotateY(-angle2);
    scale(1, 0.3, 0.3);
    noFill();
    sphere(len/2);//(0, 0, len, len/2); //x 是長軸
  popMatrix();
}
void keyPressed(){
  if(keyCode==UP) p1.z += 10;
  if(keyCode==DOWN) p1.z -= 10;
}
```

## step03-7
```processing
//在週五meeting時，先示範出旋轉咖啡豆的例子
PVector p1, p2;
void setup(){
  size(400, 400, P3D); //3種renderer: Java, P2D, P3D
  p1 = new PVector();
  p2 = new PVector();
}
void draw(){
  background(#FFFFF2);
  line(p1.x, p1.y, p2.x, p2.y);
  myCircle();
}
void myCircle(){
  PVector c = PVector.add(p1,p2).div(2);
  PVector v = PVector.sub(p2,p1);
  float len = v.mag();
  translate(c.x, c.y);
  float angle = atan2(v.y, v.x);
  rotate(angle);
  translate(-c.x, -c.y);
  ellipse(c.x, c.y, len, len/2);
}
void mousePressed(){
  p1.x = mouseX;
  p1.y = mouseY;
  p2.x = mouseX;  // 怕剛壓下時，會有奇怪的線
  p2.y = mouseY;  // 怕剛壓下時，會有奇怪的線
}
void mouseDragged(){
  p2.x = mouseX;
  p2.y = mouseY;
}
```

## step03-8
```processing
//週五接下來示範 ellipse 像旋轉咖啡豆的旋轉楕圓球的例子
PVector p1, p2;
void setup(){
  size(400, 400, P3D); //3種renderer: Java, P2D, P3D
  p1 = new PVector();
  p2 = new PVector();
}
void draw(){
  background(#FFFFF2);
  line(p1.x, p1.y, p2.x, p2.y);
  myBead(p1, p2);
}
void myBead(PVector p1, PVector p2){
  PVector c = PVector.add(p1,p2).div(2);
  PVector v = PVector.sub(p2,p1);
  float len = v.mag();
  translate(c.x, c.y);
  float angle = atan2(v.y, v.x);
  rotate(angle);
  translate(-c.x, -c.y);
  pushMatrix();
    translate(c.x, c.y);
    scale(1, 0.3, 0.3);
    sphere(len/2);
  popMatrix();
  //ellipse(c.x, c.y, len, len/2);
}
void mousePressed(){
  p1.x = mouseX;
  p1.y = mouseY;
  p2.x = mouseX;  // 怕剛壓下時，會有奇怪的線
  p2.y = mouseY;  // 怕剛壓下時，會有奇怪的線
}
void mouseDragged(){
  p2.x = mouseX;
  p2.y = mouseY;
}
```

## step03-09
```processing
//最後，用atan2()版本，做出企鵝的版本

PVector [] OBJv;
ArrayList<ArrayList<Integer>> OBJf;
int v, f;
void myLoadShape(String file){
  String[] lines = loadStrings(file);
  v=0;
  f=0;
  for(int i=0; i<lines.length; i++){
    //println(lines[i]);
    char c = lines[i].charAt(0);
    if(c=='v') v++;
    if(c=='f') f++;
  }
  println("total vertex: ", v, "total face: ", f);
  OBJv = new PVector[v+1]; //因為OBJ檔的 f 裡面的頂點 v 是從1開始數
  OBJf = new ArrayList<ArrayList<Integer>>();
  v = 1;
  f = 0;
  for(int i=0; i<lines.length; i++){
    char c = lines[i].charAt(0);
    if(c=='v'){
      String[] nums = split(lines[i], " "); //把 lines[i] 切出3個數字
      OBJv[v] = new PVector(float(nums[1]), float(nums[2]), float(nums[3]));
      println(OBJv[v]);
      v++;
    }
    if(c=='f'){
      String[] nums = split(lines[i], " ");
      //f 2 3 8 12 7
      ArrayList<Integer> temp = new ArrayList<Integer>() ;
      for(int k=1; k<nums.length; k++){
        //print(nums[k], " " );
        temp.add( int(nums[k]) ) ;
      }
      OBJf.add(temp);
      //println("=====");
      f++;
    }
  }
  println(v);
}
void setup(){
  size(500,500,P3D);
  myLoadShape("penguin.obj");
}
void draw(){
  background(#FFFFF2);
  translate(width/2, height/2);
  rotateY(radians(mouseX));
  scale(300);
  lights();
  for(int z=0; z<OBJf.size(); z++){
    beginShape();
    stroke(random(255), random(255), random(255) );
    strokeWeight(0.03);
    noFill();
    ArrayList<Integer> ff =OBJf.get(z);
    for(int i=0; i<ff.size(); i++){
      int k = ff.get(i);
      PVector now = OBJv[k];
      vertex(now.x, now.y, now.z);
    }
    //for(int i=1; i<v; i++){
    //  vertex(OBJv[i].x, OBJv[i].y, OBJv[i].z);
    //}
    endShape(CLOSE);
    noStroke();
    fill(0,255,0);
    for(int i=0; i<ff.size(); i++){
      int k = ff.get(i);
      int k2 = ff.get((i+1)%ff.size());
      PVector now = OBJv[k], now2 = OBJv[k2];
      myBead(now, now2);
    }
  }
}
void myBead(PVector p1, PVector p2){
  PVector c = PVector.add(p1,p2).div(2);
  PVector v = PVector.sub(p2,p1);
  float len = v.mag();
  pushMatrix();
    translate(c.x, c.y, c.z);
    float angle = atan2(v.y, v.x);
    rotate(angle);
    translate(-c.x, -c.y, -c.z);
    pushMatrix();
      translate(c.x, c.y, c.z);
      scale(1, 0.3, 0.3);
      sphere(len/2);
    popMatrix();
  popMatrix();
}
```

# Step04
## step04-1
```processing
// 最後重寫

ArrayList<PVector> vertices;
ArrayList<ArrayList<Integer>> faces;
void setup(){
  size(400, 400, P3D);
  String [] lines = loadStrings("penguin.obj"); //penguin = loadShape("penguin.obj");
  prepareVertexFaces(lines);
}
void prepareVertexFaces(String [] lines){
  vertices = new ArrayList<PVector>();
  faces = new ArrayList<ArrayList<Integer>>();
  for(int i=0; i<lines.length; i++){
    String line = lines[i];
    char c = line.charAt(0);
    if(c=='v'){
      String [] nums = split(line, " ");
      PVector p = new PVector( float(nums[1]) , float(nums[2]) , float(nums[3]) );
      vertices.add(p);
    }else if(c=='f'){
      String [] nums = split(line, " ");
      ArrayList<Integer> temp = new ArrayList<Integer>();
      for(int k=1; k<nums.length; k++){
        temp.add( int(nums[k]) );
      }
      faces.add(temp);
    }
  }
}
void draw(){
  lights();
  background(#FFFFF2);
  translate(width/2, height/2);
  rotateY(radians(frameCount));
  scale(300);
  noStroke();
  for(ArrayList<Integer> face : faces){
    beginShape();
    for(Integer i : face){
      PVector p = vertices.get(i-1);
      vertex(p.x, p.y, p.z);
    }
    endShape(CLOSE);
  }
}
```
## step04-2
```processing
//準備做出3D轉動前，先介紹 applyMatrix()
//https://processing.org/reference/applyMatrix_.html
size(400, 400, P3D);
noFill();
translate(200, 200, 0);
rotateY(PI/6);
stroke(153);
box(140);
// Set rotation angles
float ct = cos(PI/9.0);
float st = sin(PI/9.0);
// Matrix for rotation around the Y axis
/*
applyMatrix(  ct, 0.0,  st,  0.0,
             0.0, 1.0, 0.0,  0.0,
             -st, 0.0,  ct,  0.0,
             0.0, 0.0, 0.0,  1.0);  */
rotateY(PI/9.0);
stroke(255);
box(200);
```

## step04-3
```processing
// 週五晚上試著做珠珠轉動，週六半夜修正出來了
// 現在如何把它的 atan2()做得正確 3D
// https://zh.wikipedia.org/zh-tw/%E6%AC%A7%E6%8B%89%E8%A7%92
// Euler Angle Rotation
// rotateZ()
// rotateX() 看你的長軸要倒多少，就是這裡的參數, 就用內積 Z軸與你 FromTo acos()
// rotateZ()
PVector p1, p2;
void setup(){
  size(400,400,P3D);
  p1 = new PVector(-50, -100, -50);
  p2 = new PVector(100, 50, -0);
}
void draw(){
  background(#FFFFF2);
  translate(width/2, height/2);
  rotateY(radians(mouseX));
  stroke(0,255,0); mySphere(p1);
  line(p1.x, p1.y, p1.z, p2.x, p2.y, p2.z);
  stroke(255,0,0); mySphere(p2);

  PVector myVec = PVector.sub(p2, p1);
  PVector c = PVector.add(p1, p2).div(2);
  PVector Z = new PVector(0,0,1);
  PVector N = Z.cross(myVec);
  float beta = angleBetweenTwoVector(Z, myVec, N);
  float alpha = angleBetweenTwoVector(new PVector(1,0,0), N, Z);

  myBead( myVec.mag(), c, alpha, beta );
}
float angleBetweenTwoVector(PVector v1, PVector v2, PVector axis){
  float len1 = v1.mag(), len2 = v2.mag();
  //內積 = len1 * len2 * cos(角度)
  //cos(角度) = 內積 / len1 / len2;
  float cos_value = PVector.dot(v1,v2) / len1 / len2;
  float angle = acos(cos_value);
  if(PVector.dot(axis,v1.cross(v2))>=0) return angle;
  else return -angle;
}
void mySphere(PVector p){
  pushMatrix();
    translate(p.x, p.y, p.z);
    sphere(8);
  popMatrix();
}
void myBead(float len, PVector pos, float alpha, float beta){
  pushMatrix();
    translate(pos.x, pos.y, pos.z);
    rotateZ(alpha);//alpha
    rotateX(beta);//beta 這裡做了交換，可能是座標系統不同
    scale(0.3, 0.3, 1);
    sphere(len/2);
  popMatrix();
}
```

## step05
```processing
//改良自 sketch_230112g.pde 重寫的版本，再加上 sketch_230113b.pde 以 Euler Angle 的 alpha beta 做出的版本

ArrayList<PVector> vertices;
ArrayList<ArrayList<Integer>> faces;
void setup(){
  size(400, 400, P3D);
  String [] lines = loadStrings("penguin.obj"); //penguin = loadShape("penguin.obj");
  prepareVertexFaces(lines);
}
void prepareVertexFaces(String [] lines){
  vertices = new ArrayList<PVector>();
  faces = new ArrayList<ArrayList<Integer>>();
  for(int i=0; i<lines.length; i++){
    String line = lines[i];
    char c = line.charAt(0);
    if(c=='v'){
      String [] nums = split(line, " ");
      PVector p = new PVector( float(nums[1]) , float(nums[2]) , float(nums[3]) );
      vertices.add(p);
    }else if(c=='f'){
      String [] nums = split(line, " ");
      ArrayList<Integer> temp = new ArrayList<Integer>();
      for(int k=1; k<nums.length; k++){
        temp.add( int(nums[k]) );
      }
      faces.add(temp);
    }
  }
}
void draw(){
  lights();
  background(#FFFFF2);
  translate(width/2, height/2);
  rotateY(radians(frameCount));
  scale(300);
  noStroke();
  for(ArrayList<Integer> face : faces){
    for(int i=0; i<face.size(); i++){
      int k = face.get(i), k2 = face.get((i+1)%face.size());
      PVector p = vertices.get(k-1), p2 = vertices.get(k2-1);
      myBead(p, p2);
    }
  }
}
void myBead(PVector p1, PVector p2){
  PVector myVec = PVector.sub(p2, p1);
  PVector c = PVector.add(p1, p2).div(2);
  PVector Z = new PVector(0,0,1);
  PVector N = Z.cross(myVec);
  float beta = angleBetweenTwoVector(Z, myVec, N);
  float alpha = angleBetweenTwoVector(new PVector(1,0,0), N, Z);

  pushMatrix();
    translate(c.x, c.y, c.z);
    rotateZ(alpha);//alpha
    rotateX(beta);//beta 這裡做了交換，可能是座標系統不同
    scale(0.3, 0.3, 1);
    sphere(myVec.mag()/2);
  popMatrix();

}
float angleBetweenTwoVector(PVector v1, PVector v2, PVector axis){
  float len1 = v1.mag(), len2 = v2.mag();
  //內積 = len1 * len2 * cos(角度)
  //cos(角度) = 內積 / len1 / len2;
  float cos_value = PVector.dot(v1,v2) / len1 / len2;
  float angle = acos(cos_value);
  if(PVector.dot(axis,v1.cross(v2))>=0) return angle;
  else return -angle;
}
```
## step05-1
```processing
PVector Orig, X, Y, Z, V;
void setup() {
  size(400, 400, P3D);
  Orig = new PVector();
  X = new PVector(1, 0, 0);
  Y = new PVector(0, 1, 0);
  Z = new PVector(0, 0, 1);
  V = new PVector(random(-1, +1), random(-1, +1), random(-1, +1));
}
float dy=0, dx=0;
void mouseDragged() {
  dx += mouseX - pmouseX;
  dy -= mouseY - pmouseY;
}
void draw() {
  background(#FFFFF2);
  lights();
  translate(width/2, height/2);
  rotateX(radians(dy));
  rotateY(radians(dx));
  rotateX(radians(60));
  rotateZ(radians(45));
  PVector N = Z.cross(V.copy().normalize());

  strokeWeight(3);
  myDrawLine(Orig, X, 100, #FF0000);
  myDrawLine(Orig, Y, 100, #00FF00);
  myDrawLine(Orig, Z, 100, #0000FF);
  strokeWeight(1);
  myDrawLine(Orig, V, 150, #FF00FF);
  myDrawLine(Orig, N, 150, #AAFFAA);
  float beta = findAngleBetween(Z, V, N);
  float alpha = findAngleBetween(X, N, Z);
  println(degrees(beta));
  pushMatrix();
    rotateZ(alpha);
    rotateX(beta);
    myEllipse();
  popMatrix();
  pushMatrix();
    rotateZ(-alpha);
    myDrawLine(Orig, N, 150, #0000FF);
  popMatrix();
  box(20);
}
float findAngleBetween(PVector v1, PVector v2, PVector axis) {
  PVector v1n = v1.copy().normalize();
  PVector v2n = v2.copy().normalize();
  PVector N = v1n.cross(v2n);
  float ans = acos(PVector.dot(v1n, v2n));
  if (PVector.dot(N, axis)>0) return ans;
  else return -ans;
}
void myDrawVector(PVector p1, PVector p2, float  len, color c, String name) {
}
void myDrawLine(PVector p1, PVector p2, float len, color c) {
  stroke(c);
  line(p1.x*len, p1.y*len, p1.z*len, p2.x*len, p2.y*len, p2.z*len);
}
void myEllipse() {
  pushMatrix();
    scale(0.3, 0.3, 1);
    sphere(50);
  popMatrix();
  pushMatrix();
    scale(1, 0.1, 0.1);
    sphere(60);
  popMatrix();
}
```

## step05-2
```processing
PVector orig, X, Y, Z, V, N;
void setup(){
  size(400,400,P3D);
  orig = new PVector();
  X = new PVector(1, 0, 0);
  Y = new PVector(0, 1, 0);
  Z = new PVector(0, 0, 1);
  V = new PVector(random(-1,+1), random(-1,+1), random(-1,+1)).normalize();
  N = Z.cross(V);
  alpha = angleBetweenTwoVector(X, N, Z);
  beta = angleBetweenTwoVector(Z, V, N);
}
float dx = 0, dy = 0, alpha, beta;
void draw(){
  lights();
  background(#FFFFF2);
  translate(width/2, height/2);
  rotateY(radians(dx));
  rotateX(radians(60));
  rotateZ(radians(45));
  strokeWeight(3);
  myLine(orig, X, 120, #FF0000);
  myLine(orig, Y, 120, #00FF00);
  myLine(orig, Z, 120, #0000FF);
  strokeWeight(1);
  myLine(orig, V, 150, #FF00FF);
  myLine(orig, N, 150, #00FF00);
  stroke(0);
  pushMatrix();
    rotateZ(alpha);
    rotateX(beta);
    myEllipse(); //z軸比較長
  popMatrix();
  box(10);
}
void myEllipse(){
  pushMatrix();
    scale(0.2, 0.2, 1);
    sphere(100);
  popMatrix();
  pushMatrix();
    scale(1, 0.2, 0.2);
    sphere(50);
  popMatrix();
}
void myLine(PVector p1, PVector p2, float len, color c){
  stroke(c);
  line(p1.x*len, p1.y*len, p1.z*len, p2.x*len, p2.y*len, p2.z*len);
}
void mouseDragged(){
  dx += mouseX - pmouseX;
  dy += mouseY - pmouseY;
}
float angleBetweenTwoVector(PVector v1, PVector v2, PVector N){
  //內積 ＝ a*b*cos(c)
  //cos(c) = 內積/a/b
  //c = acos(內積/a/b)
  float ans = acos( PVector.dot(v1,v2)/v1.mag()/v2.mag() );
  if( PVector.dot(  v1.cross(v2) , N ) < 0 ) ans = -ans;
  return ans;
}
```

# Penguin_bead
```processing
PShape bead;
ArrayList<PVector> vertices;
ArrayList<ArrayList<Integer>> faces;
void setup(){
  size(400, 400, P3D);
  String [] lines = loadStrings("penguin.obj"); //penguin = loadShape("penguin.obj");
  prepareVertexFaces(lines);
  bead = loadShape("swarovski.obj");
}
void prepareVertexFaces(String [] lines){
  vertices = new ArrayList<PVector>();
  faces = new ArrayList<ArrayList<Integer>>();
  for(int i=0; i<lines.length; i++){
    String line = lines[i];
    char c = line.charAt(0);
    if(c=='v'){
      String [] nums = split(line, " ");
      PVector p = new PVector( float(nums[1]) , float(nums[2]) , float(nums[3]) );
      vertices.add(p);
    }else if(c=='f'){
      String [] nums = split(line, " ");
      ArrayList<Integer> temp = new ArrayList<Integer>();
      for(int k=1; k<nums.length; k++){
        temp.add( int(nums[k]) );
      }
      faces.add(temp);
    }
  }
}
void draw(){
  lights();
  background(#FFFFF2);
  translate(width/2, height/2);
  rotateY(radians(frameCount));
  scale(300);
  shape(bead);
  noStroke();
  for(ArrayList<Integer> face : faces){
    for(int i=0; i<face.size(); i++){
      int k = face.get(i), k2 = face.get((i+1)%face.size());
      PVector p = vertices.get(k-1), p2 = vertices.get(k2-1);
      myBead(p, p2);
    }
  }
}
void myBead(PVector p1, PVector p2){
  PVector myVec = PVector.sub(p2, p1);
  PVector c = PVector.add(p1, p2).div(2);
  PVector Z = new PVector(0,0,1);
  PVector N = Z.cross(myVec);
  float beta = angleBetweenTwoVector(Z, myVec, N);
  float alpha = angleBetweenTwoVector(new PVector(1,0,0), N, Z);
  pushMatrix();
    translate(c.x, c.y, c.z);
    rotateZ(alpha);//alpha
    rotateX(beta);//beta 這裡做了交換，可能是座標系統不同
    //scale(0.3, 0.3, 1);
    //sphere(myVec.mag()/2);
    shape(bead);
  popMatrix();
}
float angleBetweenTwoVector(PVector v1, PVector v2, PVector axis){
  float len1 = v1.mag(), len2 = v2.mag();
  //內積 = len1 * len2 * cos(角度)
  //cos(角度) = 內積 / len1 / len2;
  float cos_value = PVector.dot(v1,v2) / len1 / len2;
  float angle = acos(cos_value);
  if(PVector.dot(axis,v1.cross(v2))>=0) return angle;
  else return -angle;
}
```

