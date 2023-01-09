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

