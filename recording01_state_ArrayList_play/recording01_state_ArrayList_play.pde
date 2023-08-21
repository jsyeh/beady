void setup(){
  size(800,800,P3D);
}
void draw(){
  background(#FFFFF2);
  if(state==2){
    background(#00FF00);
    PVector p = new PVector(mouseX, mouseY);
    recording.add(p);
  }else if(state==3 && recording.size()>0 ){
    pushMatrix();
      PVector p = recording.get(playI);
      translate(p.x, p.y, p.z);
      box(30);
      playI = (playI+1)%recording.size();
    popMatrix();
  }
  if(keyPressed) background(255,0,0);
}
ArrayList<PVector> recording = new ArrayList<PVector>();
int playI = 0;
int state=0; //0:nothing, 1: operation, 2: recording, 3: playing
void mousePressed(){
  println("mousePressed");
}
void keyPressed(){
  if(key=='2'){
    state=2;
  }else if(key=='3'){ //playing
    state=3;
  }
  println(state);
}
