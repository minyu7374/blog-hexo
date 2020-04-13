---
title: "POJ1273 Drainage Ditches"
date: "2014-07-24T13:43:46+08:00"
categories:
tags:
---

                                            

Description

Every time it rains on Farmer John's fields, a pond forms over Bessie's favorite clover patch. This means that the clover is covered by water for awhile and takes quite a long time to regrow. Thus, Farmer John has built a set of drainage ditches so that Bessie's
 clover patch is never covered in water. Instead, the water is drained to a nearby stream. Being an ace engineer, Farmer John has also installed regulators at the beginning of each ditch, so he can control at what rate water flows into that ditch. 

Farmer John knows not only how many gallons of water each ditch can transport per minute but also the exact layout of the ditches, which feed out of the pond and into each other and stream in a potentially complex network. 

Given all this information, determine the maximum rate at which water can be transported out of the pond and into the stream. For any given ditch, water flows in only one direction, but there might be a way that water can flow in a circle. 

Input

<strong><em>The input includes several cases.</em></strong> For each case, the first line contains two space-separated integers, N (0 <= N <= 200) and M (2 <= M <= 200). N is the number of ditches that Farmer John has dug. M is the number of intersections points
 for those ditches. Intersection 1 is the pond. Intersection point M is the stream. Each of the following N lines contains three integers, Si, Ei, and Ci. Si and Ei (1 <= Si, Ei <= M) designate the intersections between which this ditch flows. Water will flow
 through this ditch from Si to Ei. Ci (0 <= Ci <= 10,000,000) is the maximum rate at which water will flow through the ditch.
Output

For each case, output a single integer, the maximum rate at which water may emptied from the pond.
Sample Input
5 4
1 2 40
1 4 20
2 4 20
2 3 30
3 4 10

Sample Output
50

      最大流的一道水题，可是却WA了好几次。实在想不通为什么，就查了别人的博客。原来数据中有重边，边上的流量要加在一起……有重边干吗不在题目中说明，巨坑……

```cpp
#include <cstdio>
#include <cstring>
#define INF 0x7fffffff
#define maxn 205

int s, t, m, n;
int c[maxn][maxn], f[maxn][maxn];
int queue[maxn], qs, qe;
int mark[maxn], minf[maxn];

void init(){
    int x, y, tmp;
    memset(c, 0, sizeof(c));
    s = 1; t = n;
    while(m--){
	 scanf("%d %d %d", &x, &y, &tmp);
	     c[x][y] += tmp;   //坑爹的关键一句
    }
}

void ford(){
    int v, p;
    memset(f, 0, sizeof(f));
    memset(minf, 0, sizeof(minf));
    minf[s] = INF;

    while(true){
	memset(mark, -1, sizeof(mark));
        mark[s] = 0;
        
        qs = 0; queue[qs] = s; qe = 1;
        while( qs != qe && mark[t] == -1){
        	v = queue[qs];  qs = (qs + 1) % maxn;
        	for(int i = 1; i <= t; i ++)
        		if( mark[i] == -1 && (p = c[v][i] - f[v][i]) ){
        			mark[i] = v; queue[qe] = i; qe = (qe + 1) % maxn;
        			minf[i] = minf[v] < p ? minf[v] : p;
        		}
        }

        if(mark[t] == -1) break;

        for(int i = mark[t], j = t;  i != 0;  j = i, i = mark[i] ){
        	f[i][j] += minf[t];
        	f[j][i] -= f[i][j];
        }       
    }
    
    int ans = 0;
    for(int i = 1; i < n; i++)
    	ans += f[i][t];
    printf("%d\n", ans);
}

int main(){	
    while(~scanf("%d %d", &m, &n)){
        init();   
        ford();
    }
    return 0;
}
```

