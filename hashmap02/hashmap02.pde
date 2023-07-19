int [] a = {3,2,1};
for(int i=0; i<a.length; i++){
  println("a[i]" + a[i]);
}

ArrayList<Integer> b = new ArrayList<>();
b.add(3);
b.add(2);
b.add(1);
for(int i=0; i<b.size(); i++){
  println("b.get(i)" + b.get(i) );
}

HashMap<Integer,Integer> map = new HashMap<>();
map.put(0, 3);
map.put(1, 2);
map.put(2, 1);
println("map.get()" + map.get(0));
println("map.get()" + map.get(1));
println("map.get()" + map.get(2));
