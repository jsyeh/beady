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
