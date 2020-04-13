---
title: "带权二分图最佳匹配KM算法模板"
date: "2014-06-05T23:02:38+08:00"
categories:
tags:
---

                                            
          KM算法是在匈牙利算法的基础上扩展出来的，具体原理不再赘述，算法模版如下：

```cpp
#include <cstdio>
#include <cstring>
#include <algorithm> 
using namespace std;
const int MAX_X = 1024;
const int MAX_Y = 1024;

int n, m;                        // X ,Y 的大小
int weight[MAX_X][MAX_Y];        // X 到 Y 的映射（权重）
int lx[MAX_X], ly[MAX_Y];        // 标号
bool sx[MAX_X], sy[MAX_Y];      // 是否被搜索过
int match[MAX_Y];              // Y(i) 与 X(match [i]) 匹配

void init(){
    for(int i = 0; i < n; i ++)
        for(int j = 0; j < m; j ++)
            scanf("%d", &weight[i][j]);
}

//寻找增广路径
bool hungary(int u){   
    sx[u] = true;
    for(int v = 0; v < m; v ++)
        if(!sy [v] && lx[u] + ly[v] == weight[u][v]){
            sy[v] = true;
            if(match[v] == -1 || hungary(match[v])){
                match [v] = u;
                return true;
            }
        }
    return false;
}

int KM(bool maxsum){ // 参数 maxsum 为 true ，返回最大权匹配，否则最小权匹配
    int i, j;
    if(!maxsum){
        for(i = 0; i < n; i ++)
            for(j = 0; j < m; j ++)
                weight [i] [j] = -weight [i] [j];
    }
    
    // 初始化标号
    memset(ly, 0, sizeof(ly));
    for(i = 0; i < n; i ++){
        lx[i] = -0x7FFFFFFF;
        for(j = 0; j < m; j ++)
            lx[i] = max(weight[i][j], lx[i]);
    }

    memset(match, -1, sizeof(match));
    for(int u = 0; u < n; u ++){
        while(1){
            memset(sx, 0, sizeof(sx));
            memset(sy, 0, sizeof(sy));
            if(hungary(u))   break;
            // 修改标号
            int d = 0x7FFFFFFF;
            for(i = 0; i < n; i++)
                if(sx[i])
                    for(j = 0; j < m; j ++)
                        if(!sy[j])
                            d = min(lx[i] + ly[j] - weight[i][j], d);
            for(i = 0; i < n; i ++)  if(sx[i])   lx[i] -= d;
            for(i = 0; i < m; i ++)  if(sy[i])   ly[i] += d;
            
        }
    }
    int sum = 0;
    for(i = 0; i < m; i ++)
        sum += weight[ match[i] ][i];
    if(!maxsum){
        sum = -sum;
        for(i = 0; i < n; i ++)
            for(j = 0; j < m; j ++)
                weight[i][j] = -weight[i][j];         // 如果需要保持 weight [ ] [ ] 原来的值，这里需要将其还原
    }
    return sum;
}

int main(){
    while(~scanf("%d %d", &n, &m)){
        init();
        printf("%d\n", KM(false));
        for(int i = 0; i < m; i ++)
            printf("X %d -> Y %d\n", match [i], i);
    }
    return 0;
} 
```

例题1 ： hdu 2255     奔小康赚大钱  

URL：[http://acm.hdu.edu.cn/showproblem.php?pid=2255](http://acm.hdu.edu.cn/showproblem.php?pid=2255)

Problem Description
传说在遥远的地方有一个非常富裕的村落,有一天,村长决定进行制度改革：重新分配房子。

这可是一件大事,关系到人民的住房问题啊。村里共有n间房间,刚好有n家老百姓,考虑到每家都要有房住（如果有老百姓没房子住的话，容易引起不安定因素），每家必须分配到一间房子且只能得到一间房子。

另一方面,村长和另外的村领导希望得到最大的效益,这样村里的机构才会有钱.由于老百姓都比较富裕,他们都能对每一间房子在他们的经济范围内出一定的价格,比如有3间房子,一家老百姓可以对第一间出10万,对第2间出2万,对第3间出20万.(当然是在他们的经济范围内).现在这个问题就是村领导怎样分配房子才能使收入最大.(村民即使有钱购买一间房子但不一定能买到,要看村领导分配的).

 

Input
输入数据包含多组测试用例，每组数据的第一行输入n,表示房子的数量(也是老百姓家的数量)，接下来有n行,每行n个数表示第i个村名对第j间房出的价格(n<=300)。

 

Output
请对每组数据输出最大的收入值，每组的输出占一行。


 

Sample Input

2
100 10
15 23

 

Sample Output

123


 对模版稍做修改即可：
```cpp
#include <cstdio>
#include <cstring>
#include <algorithm> 
using namespace std;
const int MAX = 310;

int n;                     
int weight[MAX][MAX];        
int lx[MAX], ly[MAX];       
bool sx[MAX], sy[MAX];     
int match[MAX];       

void init(){
    for(int i = 0; i < n; i ++)
        for(int j = 0; j < n; j ++)
            scanf("%d", &weight[i][j]);
}

bool hungary(int u){   
    sx[u] = true;
    for(int v = 0; v < n; v ++)
        if(!sy [v] && lx[u] + ly[v] == weight[u][v]){
            sy[v] = true;
            if(match[v] == -1 || hungary(match[v])){
                match [v] = u;
                return true;
            }
        }
    return false;
}

int KM(){
    int i, j;
    memset(ly, 0, sizeof(ly));
    for(i = 0; i < n; i ++){
        lx[i] = -0x7FFFFFFF;
        for(j = 0; j < n; j ++)
            lx[i] = max(weight[i][j], lx[i]);
    }

    memset(match, -1, sizeof(match));
    for(int u = 0; u < n; u ++){
        while(1){
            memset(sx, 0, sizeof(sx));
            memset(sy, 0, sizeof(sy));
            if(hungary(u))   break;

            int d = 0x7FFFFFFF;
            for(i = 0; i < n; i++)
                if(sx[i])
                    for(j = 0; j < n; j ++)
                        if(!sy[j])
                            d = min(lx[i] + ly[j] - weight[i][j], d);
            for(i = 0; i < n; i ++)  if(sx[i])   lx[i] -= d;
            for(i = 0; i < n; i ++)  if(sy[i])   ly[i] += d;
            
        }
    }
    int sum = 0;
    for(i = 0; i < n; i ++)
        sum += weight[ match[i] ][i];
    return sum;
}

int main(){
    while(~scanf("%d", &n)){
        init();
        printf("%d\n", KM());
    }
    return 0;
} 
```

例题2  POJ 2195 Going Home
URL：[http://poj.org/problem?id=2195](http://poj.org/problem?id=2195)

Description
On a grid map there are n little men and n houses. In each unit time, every little man can move one unit step, either horizontally, or vertically, to an adjacent point. For each little man, you need to pay a $1 travel fee for every
 step he moves, until he enters a house. The task is complicated with the restriction that each house can accommodate only one little man.


Your task is to compute the minimum amount of money you need to pay in order to send these n little men into those n different houses. The input is a map of the scenario, a '.' means an empty space, an 'H' represents a house on that point, and am 'm' indicates
 there is a little man on that point.
<center><img alt="" src="http://poj.org/images/2195_1.jpg" /></center>


You can think of each point on the grid map as a quite large square, so it can hold n little men at the same time; also, it is okay if a little man steps on a grid with a house without entering that house.
Input
There are one or more test cases in the input. Each case starts with a line giving two integers N and M, where N is the number of rows of the map, and M is the number of columns. The rest of the input will be N lines describing
 the map. You may assume both N and M are between 2 and 100, inclusive. There will be the same number of 'H's and 'm's on the map; and there will be at most 100 houses. Input will terminate with 0 0 for N and M.
Output
For each test case, output one line with the single integer, which is the minimum amount, in dollars, you need to pay.
Sample Input
2 2
.m
H.
5 5
HH..m
.....
.....
.....
mm..H
7 8
...H....
...H....
...H....
mmmHmmmm
...H....
...H....
...H....
0 0

Sample Output
2
10
28

除了初始化数据，此题对模版的修改也不大：

```cpp
#include <cstdio>
#include <cstring>
#include <algorithm> 
using namespace std;
const int MAXN = 110;

struct point{
	int x;
	int y;
}px[MAXN],py[MAXN];
char map[MAXN];             
int r, c, n, m;                     
int weight[MAXN][MAXN];    
int lx[MAXN], ly[MAXN];     
bool sx[MAXN], sy[MAXN];     
int match[MAXN];

void init(){
     n = 0; m = 0;
     for(int i = 0; i < r; i ++){
     	scanf("%s", map);
          for(int j = 0; j < c; j ++)
              if(map[j] == 'H')
             	    px[n].x = i, px[n++].y = j;
              else if(map[j] == 'm')
             	    py[m].x = i, py[m++].y = j;
     }
     for(int i = 0; i < n; i++)
     	for(int j = 0; j < m; j++)
     		weight[i][j] = -(abs(px[i].x - py[j].x) + abs(px[i].y - py[j].y));     
}

bool hungary(int u){   
    sx[u] = true;
    for(int v = 0; v < m; v ++)
        if(!sy [v] && lx[u] + ly[v] == weight[u][v]){
            sy[v] = true;
            if(match[v] == -1 || hungary(match[v])){
                match [v] = u;
                return true;
            }
        }
    return false;
}

int KM(){ 
    int i, j;

    memset(ly, 0, sizeof(ly));
    for(i = 0; i < n; i ++){
        lx[i] = -0x7FFFFFFF;
        for(j = 0; j < m; j ++)
            lx[i] = max(weight[i][j], lx[i]);
     }

     memset(match, -1, sizeof(match));
     for(int u = 0; u < n; u ++){
         while(1){
             memset(sx, 0, sizeof(sx));
             memset(sy, 0, sizeof(sy));
             if(hungary(u))    break;

             int d = 0x7FFFFFFF;
             for(i = 0; i < n; i++)
                 if(sx[i])
                     for(j = 0; j < m; j ++)
                         if(!sy[j])
                            d = min(lx[i] + ly[j] - weight[i][j], d);
              for(i = 0; i < n; i ++)  if(sx[i])   lx[i] -= d;
              for(i = 0; i < m; i ++)  if(sy[i])   ly[i] += d;        
         }
     }
     int sum = 0;
     for(i = 0; i < m; i ++)
         sum += weight[ match[i] ][i];
     return -sum;
}

int main(){
    while(~scanf("%d %d", &r, &c) && (r || c) ){
          init();
          printf("%d\n", KM());
    }
    return 0;
} 
```

