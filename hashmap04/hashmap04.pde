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

HashMap<String,Integer> map2 = new HashMap<>();
map2.put("Hello", 3);
map2.put("World", 2);
map2.put("Processing", 1);
println("map2.get(\"Hello\")" + map2.get("Hello") );

HashMap<String,Integer> map3 = new HashMap<>();
String edge0 = 0 + "+" + 1; //"0+1"
String edge1 = 1 + "+" + 2; //"1+2"
String edge2 = 2 + "+" + 3; //"2+3"
String edge3 = 3 + "+" + 0; //"3+0"

map3.put(edge0, 73);
map3.put(edge1, 73);
map3.put(edge2, 73);
map3.put(edge3, 73);
println("map3.get(someEdge)" + map3.get("1+2") );
