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
