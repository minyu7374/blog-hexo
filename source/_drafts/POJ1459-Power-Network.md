---
title: "POJ1459 Power Network"
date: "2014-07-24T22:10:11+08:00"
categories:
tags:
---

                                            
Description
A power network consists of nodes (power stations, consumers and dispatchers) connected by power transport lines. A node u may be supplied with an amount s(u) >= 0 of power, may produce an amount 0 <= p(u) <= p<sub>max</sub>(u)
 of power, may consume an amount 0 <= c(u) <= min(s(u),c<sub>max</sub>(u)) of power, and may deliver an amount d(u)=s(u)+p(u)-c(u) of power. The following restrictions apply: c(u)=0 for any power station, p(u)=0 for any consumer, and p(u)=c(u)=0 for any dispatcher.
 There is at most one power transport line (u,v) from a node u to a node v in the net; it transports an amount 0 <= l(u,v) <= l<sub>max</sub>(u,v) of power delivered by u to v. Let Con=Σ<sub>u</sub>c(u) be the power consumed in the net. The problem is to compute
 the maximum value of Con. 
<center>![](http://poj.org/images/1459_1.jpg)</center>


An example is in figure 1. The label x/y of power station u shows that p(u)=x and p<sub>max</sub>(u)=y. The label x/y of consumer u shows that c(u)=x and c<sub>max</sub>(u)=y. The label x/y of power transport line (u,v) shows that l(u,v)=x and l<sub>max</sub>(u,v)=y.
 The power consumed is Con=6. Notice that there are other possible states of the network but the value of Con cannot exceed 6.

Input
There are several data sets in the input. Each data set encodes a power network. It starts with four integers: 0 <= n <= 100 (nodes), 0 <= np <= n (power stations), 0 <= nc <= n (consumers), and 0 <= m <= n^2 (power transport lines).
 Follow m data triplets (u,v)z, where u and v are node identifiers (starting from 0) and 0 <= z <= 1000 is the value of l<sub>max</sub>(u,v). Follow np doublets (u)z, where u is the identifier of a power station and 0 <= z <= 10000 is the value of p<sub>max</sub>(u).
 The data set ends with nc doublets (u)z, where u is the identifier of a consumer and 0 <= z <= 10000 is the value of c<sub>max</sub>(u). All input numbers are integers. Except the (u,v)z triplets and the (u)z doublets, which do not contain white spaces, white
 spaces can occur freely in input. Input data terminate with an end of file and are correct.
Output
For each data set from the input, the program prints on the standard output the maximum amount of power that can be consumed in the corresponding network. Each result has an integral value and is printed from the beginning of a
 separate line.
Sample Input
2 1 1 2 (0,1)20 (1,0)10 (0)15 (1)20
7 2 3 13 (0,0)1 (0,1)2 (0,2)5 (1,0)1 (1,2)8 (2,3)1 (2,4)7
         (3,5)2 (3,6)5 (4,2)7 (4,3)5 (4,5)1 (6,0)5
         (0)5 (1)2 (3)2 (4)1 (5)4
Sample Output
15
6
Hint
The sample input contains two data sets. The first data set encodes a network with 2 nodes, power station 0 with pmax(0)=15 and consumer 1 with cmax(1)=20, and 2 power transport lines with lmax(0,1)=20 and lmax(1,0)=10. The maximum
 value of Con is 15. The second data set encodes the network from figure 1.
 
       简单的最大流问题，建好网络流图就行了。
 
```cpp
#include <cstdio>
#include <cstring>
#define maxn 110
#define INF 0x3f3f3f3f

int s, t, m, n, np, nc;
int c[maxn][maxn], f[maxn][maxn];
int queue[maxn], qs, qe;
int mark[maxn], minf[maxn];

void init(){
    int u, v, z;
    s = n; t = n + 1;
    memset(c, 0, sizeof(c));
    for(int i = 0; i < m; i++){
	scanf(" (%d,%d)%d", &u, &v, &z);
	c[u][v] += z;   //鉴于曾经被重边坑过，现在写这句话都用 +=
    }
    for(int i = 0; i < np; i++){
	scanf(" (%d)%d", &u, &z);
	c[s][u] += z;
    }
    for(int i = 0; i < nc; i++){
	scanf(" (%d)%d", &u, &z);
	c[u][t] += z;
    }
}

void ford(){
    int v, p;
    memset(f, 0, sizeof(f));
    memset(minf, 0, sizeof(minf));
    minf[s] = INF;

    while(true){
        for(int i = 0; i <= n + 1; i++)
        	    mark[i] = -2;
        mark[s] = -1;
        
        qs = 0; queue[qs] = s; qe = 1;
        while( qs != qe && mark[t] == -2){
        	   v = queue[qs];  qs = (qs + 1) % maxn;
        	   for(int i = 0; i <= t; i++)
        		if( mark[i] == -2 && (p = c[v][i] - f[v][i]) ){
        			mark[i] = v; queue[qe] = i; qe = (qe + 1) % maxn;
        			minf[i] = minf[v] < p ? minf[v] : p;
        		}
        }

        if(mark[t] == -2)  break;

        for(int i = mark[t], j = t;  i != -1;  j = i,i = mark[i] ){
        	f[i][j] += minf[t];
        	f[j][i] -= f[i][j];
        }       
    }

    int ans = 0;
    for(int i = 0; i < n; i++)
    	ans += f[i][t];
    printf("%d\n", ans);
}

int main(){
    while( ~scanf("%d %d %d %d", &n, &np, &nc, &m) ){
        init();   
        ford();
    }
    return 0;
}
```

 
 
