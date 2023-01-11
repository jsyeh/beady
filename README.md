# beady
Teach students how to implement Yuki Igarashi's Bready (SIGGRAPH 2012) paper

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
