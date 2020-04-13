---
title: "ZOJ1516 Uncle Tom's Inherited Land"
date: "2014-07-18T00:06:01+08:00"
categories:
tags:
---

                                            
Your old uncle Tom inherited a piece of land from his great-great-uncle. Originally, the property had been in the shape of a rectangle. A long time ago, however, his great-great-uncle decided to divide the land into a grid of small squares. He turned some
 of the squares into ponds, for he loved to hunt ducks and wanted to attract them to his property. (You cannot be sure, for you have not been to the place, but he may have made so many ponds that the land may now consist of several disconnected islands.)


Your uncle Tom wants to sell the inherited land, but local rules now regulate property sales. Your uncle has been informed that, at his great-great-uncle's request, a law has been passed which establishes that property can only be sold in rectangular lots the
 size of two squares of your uncle's property. Furthermore, ponds are not salable property.


Your uncle asked your help to determine the largest number of properties he could sell (the remaining squares will become recreational parks).

<img src="http://acm.zju.edu.cn/onlinejudge/showImage.do?name=0000%2F1516%2F1516.gif" width="711" height="170" alt="" />

<strong>Input</strong>


Input will include several test cases. The first line of a test case contains two integers N and M, representing, respectively, the number of rows and columns of the land (1 <= N, M <= 100). The second line will contain an integer K indicating the number of
 squares that have been turned into ponds ( (N x M) - K <= 50). Each of the next K lines contains two integers X and Y describing the position of a square which was turned into a pond (1 <= X <= N and 1 <= Y <= M). The end of input is indicated by N = M = 0.

<strong>Output</strong>


For each test case in the input your program should produce one line of output, containing an integer value representing the maximum number of properties which can be sold.


<strong>Sample Input</strong>
4 4

6

1 1

1 4

2 2

4 1

4 2

4 4

4 3

4

4 2

3 2

2 2

3 1

0 0

<strong>Sample Output</strong>
4

3
    
        将没建成pond 的land按坐标的和分为 奇、偶 两组，显然同组的不能合在一起卖掉，这样就把问题转化为二分匹配了
 
```cpp
#include <cstdio>
#include <cstring>
#define maxn 105
#define maxp 55

int  map[maxn][maxn], id[maxn][maxn];
bool state[maxp], graph[maxp][maxp];
int  link[maxp];  
int  odd, even;

bool find(int p){
    for(int i = 1; i <= even; i++){
     	if(graph[p][i] && !state[i]){
            state[i] = 1;  
            int j = link[i];
            if( !j  || find(j) ){
                link[i] = p;  return true;
            }
        }
    }
    return false;
}

int main(){
    int m, n, k, x, y, ans;
    while(~scanf("%d %d", &n, &m) && n && m){
        memset(map, 0, sizeof(map));
        scanf("%d", &k);
        while(k--){
        	scanf("%d %d", &x , &y);
        	map[x][y] = 1;
        }

        odd = 0; even = 0;
        memset(id, 0, sizeof(id));
        for(int i = 1; i <= n; i++)
        	for(int j = 1; j <= m; j++){
                if(!map[i][j])
                	if((i + j ) % 2 == 0)
                		id[i][j] = ++odd;
                	else 
                		id[i][j] = ++even;
        	}

        memset(graph, 0, sizeof(graph));
        for(int i = 1; i <= n; i++)
           	for(int j = 1; j <= m; j++)
                if(id[i][j])
                	if((i + j) % 2 == 0){
                        graph[ id[i][j] ][ id[i+1][j] ] = 1;
                        graph[ id[i][j] ][ id[i][j+1] ] = 1;
                	}
                	else{
                		graph[ id[i+1][j] ][ id[i][j] ] = 1;
                		graph[ id[i][j+1] ][ id[i][j] ] = 1;
                	}
        
        ans = 0;
        memset(link, 0, sizeof(link));
        for(int i = 1; i <= odd; i++){
	        memset(state, 0, sizeof(state));
            if(find(i))   ans++;   
        }
        printf("%d\n", ans);    
    }    
    return 0;
} 

```
