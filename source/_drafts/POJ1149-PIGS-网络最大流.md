---
title: "POJ1149 PIGS 网络最大流"
date: "2014-07-21T21:38:36+08:00"
categories:
tags:
---

                                            
Description

Mirko works on a pig farm that consists of M locked pig-houses and Mirko can't unlock any pighouse because he doesn't have the keys. Customers come to the farm one after another. Each of them has keys to some pig-houses and wants to buy a certain number of
 pigs. 

All data concerning customers planning to visit the farm on that particular day are available to Mirko early in the morning so that he can make a sales-plan in order to maximize the number of pigs sold. 

More precisely, the procedure is as following: the customer arrives, opens all pig-houses to which he has the key, Mirko sells a certain number of pigs from all the unlocked pig-houses to him, and, if Mirko wants, he can redistribute the remaining pigs across
 the unlocked pig-houses. 

An unlimited number of pigs can be placed in every pig-house. 

Write a program that will find the maximum number of pigs that he can sell on that day.
Input

The first line of input contains two integers M and N, 1 <= M <= 1000, 1 <= N <= 100, number of pighouses and number of customers. Pig houses are numbered from 1 to M and customers are numbered from 1 to N. 

The next line contains M integeres, for each pig-house initial number of pigs. The number of pigs in each pig-house is greater or equal to 0 and less or equal to 1000. 

The next N lines contains records about the customers in the following form ( record about the i-th customer is written in the (i+2)-th line): 

A K1 K2 ... KA B It means that this customer has key to the pig-houses marked with the numbers K1, K2, ..., KA (sorted nondecreasingly ) and that he wants to buy B pigs. Numbers A and B can be equal to 0.
Output

The first and only line of the output should contain the number of sold pigs.
Sample Input
3 3
3 1 10
2 1 2 2
2 1 3 3
1 2 6
Sample Output
7


一般增广路径方法——Ford-Fulkerson算法（标号法）

<table class="a" border="1" cellpadding="0" cellspacing="0" width="100%"><tbody><tr align="center"><td>468K</td>
<td>0MS</td>
<td>[G++](http://poj.org/showsource?solution_id=13135353)</td>
<td>1601B</td>
</tr></tbody></table>

```cpp
#include <cstdio>
#include <cstring>
#define INF 0x3f3f3f3f

int s, t, m, n;
int c[105][105], f[105][105];
int house[1005], pre[1005];
int queue[105], qs, qe;
int mark[105], minf[105];

void init(){
	int num, k;
    memset(pre, 0, sizeof(pre));
    memset(c, 0, sizeof(c));
    scanf("%d %d", &m, &n);
    s = 0; t = n + 1;
    for(int i = 1; i <= m; i++)
    	scanf("%d", house + i);
    for(int i = 1; i <= n; i++){
        scanf("%d", &num);
        while(num--){
        	scanf("%d", &k);
        	if(!pre[k])
        		c[s][i] += house[k];
        	else
        		c[ pre[k] ][i] = INF;
        	pre[k] = i;
        }
        scanf("%d", &c[i][t]);
    }
}

void ford(){
	int v, p;
    memset(f, 0, sizeof(f));
    minf[0] = INF;

    while(true){
        for(int i = 0; i <= n + 1; i++)
        	mark[i] = -2;
        mark[0] = -1;
        
        qs = 0; queue[qs] = 0; qe = 1;
        while( qs != qe && mark[t] == -2){
        	v = queue[qs];  qs = (qs + 1) % n;
        	for(int i = 0; i <= t; i ++)
        		if( mark[i] == -2 && (p = c[v][i] - f[v][i]) ){
        			mark[i] = v; queue[qe] = i; qe = (qe + 1) % n;
        			minf[i] = minf[v] < p ? minf[v] : p;
        		}
        }
        if(mark[t] == -2) break;

        for(int i = mark[t], j = t;  i != -1;  j = i,i = mark[i] ){
        	f[i][j] += minf[t];
        	f[j][i] -= f[i][j];
        }       
    }

    int ans = 0;
    for(int i = 1; i <= n; i++)
    	ans += f[i][t];
    printf("%d\n", ans);
}

int main(){
    init();   
    ford();
    return 0;
}
```
最短增广路算法——SAP

<table class="a" border="1" cellpadding="0" cellspacing="0" width="100%"><tbody><tr align="center"><td>396K</td>
<td>16MS</td>
<td>[G++](http://poj.org/showsource?solution_id=13152026)</td>
<td>1673B</td>
</tr></tbody></table>

```cpp
#include <cstdio>
#include <cstring>
#define inf 0x3f3f3f3f

int n, m, s, t;
int c[105][105], h[105], vh[105];

void init(){
	scanf("%d %d", &m, &n);
    int a[m], b[m];
    memset(a, 0, sizeof(a));
    memset(vh, 0, sizeof(vh));
    memset(h, 0, sizeof(h));
    memset(c, 0, sizeof(c));
    for(int i = 0; i < m; i++)
        scanf("%d", &b[i]);
    for(int i = 0; i < n; i++){
        int k, l, temp;
        scanf("%d", &k);
        for(int j = 0; j < k; j++){
            scanf("%d", &temp);
            if(!a[temp - 1])
                c[0][i+1] += b[temp-1];
            else 
				c[ a[temp-1] ][i+1] = inf;
            a[temp-1] = i + 1;
        }
        scanf("%d", &l);
        c[i+1][n+1] = l;
    }
}

int sap(int i, int f){
    if(i == t)
        return f;
    int old = f, minh = n - 1;
    for(int j = 0; j < n; j++){
        if(c[i][j] > 0){
            if(h[i] == h[j] + 1){
                int d = c[i][j] < old ? c[i][j] : old;
                d = sap(j, d);
                c[i][j] -= d;
                c[j][i] += d;
                old -= d;
                if(h[s] >= n)
                return  f - old;
                if(old == 0)
                    break;
            }
            if(h[j] < minh)
                minh = h[j];
        }
    }
    if(f == old){
        vh[ h[i] ]--;
        if(vh[ h[i] ] == 0)
            h[s] = n;
        h[i] = minh+1;
        vh[ h[i] ] ++;
    }
    return f - old;
}

int main(){
	init();
    s = 0, t = n + 1, vh[0] = n + 2;
    int ff = 0;
    n += 2;
    while(h[s] < n)
        ff += sap(s, inf);
    printf("%d\n", ff);
    return 0;
}
```

连续最短增广路算法——Dinic    


<table class="a" border="1" cellpadding="0" cellspacing="0" width="100%"><tbody><tr align="center"><td>400K</td>
<td>0MS</td>
<td>[G++](http://poj.org/showsource?solution_id=13152673)</td>
<td>2270B</td>
</tr></tbody></table>

```cpp
#include <cstdio>
#include <cstring>
#define INF 0x3f3f3f3f

int n, m, s, t;
int house[1005], pre[1005];
int c[105][105], ps[105], dep[105];

void init(){
	int num, k;
    memset(pre, 0, sizeof(pre));
    memset(c, 0, sizeof(c));
    scanf("%d %d", &m, &n);
    s = 0; t = n + 1;
    for(int i = 1; i <= m; i++)
    	scanf("%d", house + i);
    for(int i = 1; i <= n; i++){
        scanf("%d", &num);
        while(num--){
        	scanf("%d", &k);
        	if(!pre[k])
        		c[s][i] += house[k];
        	else
        		c[ pre[k] ][i] = INF;
        	pre[k] = i;
        }
        scanf("%d", &c[i][t]);
    }
}

bool bfs(int n,int s,int t){
    int f = 0, r = 0, u, v;
    memset(dep, -1, sizeof(dep));
    ps[r++] = s;
    dep[s] = 0; //开始计算层次
    while(f < r){
        u = ps[f++];
        for(v = 0; v < n; v++)
            if(c[u][v] && dep[v] < 0){
                dep[v] = dep[u] + 1;
                ps[r++] = v;
            }
            if(u == t) break;

    }
    return dep[t] < 0; //返回能否增广
}

int Dinic(int n,int s,int t){
    int k, u, v, num, res = 0, top, tag;
    while(1){
        if( bfs(n, s, t) ) break; //不能增广，最终结果
        top = 0;
        u = s;
        while(1){
            if(u == t){  //一条增广
                ps[top++] = t;
                for(k = 0, num = INF; k < top - 1; k++)
                    if(c[ ps[k] ][ ps[k+1] ] < num){
                        tag = k; //标志最小弧的头
                        num = c[ ps[k] ][ ps[k+1] ];
                    }
                for(k=0;k<top-1;k++){
                    c[ps[k]][ps[k+1]] -= num;
                    c[ps[k+1]][ps[k]] += num;
                }
                res += num;
                top = tag; //从标志处继续找其他增广路
                u = tag;
            }
            for(v = 0; v < n; v++) 
                if(c[u][v] && dep[u] + 1 == dep[v]) break;  //从u出发存在弧u->v

            if(v<n) {ps[top++] = u; u = v;}   //压u入栈，从v出发找
            else{
                if(top == 0) break;  //确定增广路找不到
                dep[u] = -1;
                u=ps[--top]; //把u弹出，找层次图中另一条u->v
            }
        }
    }
    return res;
}

int main(){
	init();
    printf("%d\n", Dinic(n + 2, s, t));
	return 0;
} 
```


