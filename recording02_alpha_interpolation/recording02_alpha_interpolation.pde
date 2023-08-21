void setup(){
  size(1200,1200,P3D);
}
void draw(){
  background(#FFFFF2);
  for(PVector a : recording){
    pushMatrix();
      translate(a.x, a.y, a.z);
      box(10);
    popMatrix();
  }
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
  }else if(state==4 && recording.size()>2 ){
    PVector p1 = recording.get(playI), p2 = recording.get(playI2);
    float alpha = (t%60)/60.0;
    PVector p = PVector.add(PVector.mult(p2,alpha), PVector.mult(p1,1-alpha));
    pushMatrix();
      translate(p.x, p.y, p.z);
      box(30);
    popMatrix();
    t++;
    if(t%60==0){
      playI = (playI+1)%recording.size();
      playI2 = (playI2+1)%recording.size();
    }
  }
  if(keyPressed) background(255,0,0);
}
ArrayList<PVector> recording = new ArrayList<PVector>();
int playI = 0, playI2 = 1, t = 0; //t:0...60
int state=0; //0:nothing, 1: operation, 2: recording, 3: playing
void mousePressed(){
  recording.add(new PVector(mouseX, mouseY));
}
void keyPressed(){
  if(key=='2'){
    state=2;
  }else if(key=='3'){ //playing
    state=3;
  }else if(key=='4'){ //animation by key position
    state=4;
  }
  println(state);
}
