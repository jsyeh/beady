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
