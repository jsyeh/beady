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

