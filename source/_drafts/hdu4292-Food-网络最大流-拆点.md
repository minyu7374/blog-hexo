---
title: "hdu4292 Food 网络最大流 拆点"
date: "2014-07-26T17:21:10+08:00"
categories:
tags:
---

                                            



Problem Description
　　You, a part-time dining service worker in your college’s dining hall, are now confused with a new problem: serve as many people as possible.

　　The issue comes up as people in your college are more and more difficult to serve with meal: They eat only some certain kinds of food and drink, and with requirement unsatisfied, go away directly.

　　You have prepared F (1 <= F <= 200) kinds of food and D (1 <= D <= 200) kinds of drink. Each kind of food or drink has certain amount, that is, how many people could this food or drink serve. Besides, You know there’re N (1 <= N <= 200) people and you too
 can tell people’s personal preference for food and drink.

　　Back to your goal: to serve as many people as possible. So you must decide a plan where some people are served while requirements of the rest of them are unmet. You should notice that, when one’s requirement is unmet, he/she would just go away, refusing any
 service.

 

Input
　　There are several test cases.

　　For each test case, the first line contains three numbers: N,F,D, denoting the number of people, food, and drink.

　　The second line contains F integers, the ith number of which denotes amount of representative food.

　　The third line contains D integers, the ith number of which denotes amount of representative drink.

　　Following is N line, each consisting of a string of length F. e jth character in the ith one of these lines denotes whether people i would accept food j. “Y” for yes and “N” for no.

　　Following is N line, each consisting of a string of length D. e jth character in the ith one of these lines denotes whether people i would accept drink j. “Y” for yes and “N” for no.

　　Please process until EOF (End Of File).

 

Output
　　For each test case, please print a single line with one integer, the maximum number of people to be satisfied.

 

Sample Input

4 3 3
1 1 1
1 1 1
YYN
NYY
YNY
YNY
YNY
YYN
YYN
NNY

 

Sample Output

3



      这道题比较简单只需将每个人拆分成两点即可，但数据量很大，最开始我用熟悉的Ford-Fulkerson 算法提交 ，结果为TLE，改为Dinic ，运行时间为375MS。
Dinic算法
```cpp
#include <cstdio>
#include <cstring>
#define inf 0x3f3f3f3f
#define maxn 810

int s, t, n, N, F, D;
char temp[210];
int c[maxn][maxn], dep[maxn]; 
int queue[maxn];

void init(){
    s = 0; t = N + N + F + D + 1; n = t + 1;
    memset(c, 0, sizeof(c));
    for(int i = 1; i <= F; i++)
        scanf("%d", &c[s][i]);
    for(int i = 1; i <= D; i++)
        scanf("%d", &c[F+N+N+i][t]);
    for(int i = 1; i <= N; i++)
    	c[F+i][F+N+i] = 1;
    for(int i = 1; i <= N; i++){
        scanf("%s", temp + 1);
        for(int j = 1; j <= F; j++)
            if(temp[j] == 'Y')  
                c[j][F+i] = 1;
    }   
    for(int i = 1; i <= N; i++){
        scanf("%s", temp + 1);
        for(int j = 1; j <= D; j++)
            if(temp[j] == 'Y')  
                c[F+N+i][F+N+N+j] = 1;
    }
}


bool bfs(){
    int f = 0, r = 0, u, v;  
    memset(dep, -1, sizeof(dep));  
    queue[r++] = s;  
    dep[s] = 0;   
    while(f < r){  
        u = queue[f++];  
        for(v = 0; v < n; v++)  
            if(c[u][v] && dep[v] < 0){  
                dep[v] = dep[u] + 1;  
                queue[r++] = v;  
            }  
            if(u == t) break;  
  
    }  
    return dep[t] < 0; 
}

int Dinic(){
    int k, u, v, num, res = 0, top, tag;
    while(1){
        if( bfs() ) break; 
        top = 0;
        u = s;
        while(1){
            if(u == t){  
                queue[top++] = t;
                for(k = 0, num = inf; k < top - 1; k++)
                    if(c[ queue[k] ][ queue[k+1] ] < num){
                        tag = k; 
                        num = c[ queue[k] ][ queue[k+1] ];
                    }
                for(k = 0; k < top - 1; k++){
                    c[ queue[k] ][ queue[k+1] ] -= num;
                    c[ queue[k+1] ][ queue[k] ] += num;
                }
                res += num;
                top = tag; 
                u = tag;
            }
            for(v = 0; v < n; v++) 
                if(c[u][v] && dep[u] + 1 == dep[v]) break; 

            if(v<n) {queue[top++] = u; u = v;} 
            else{
                if(top == 0) break;
                dep[u] = -1;
                u = queue[--top]; 
            }
        }
    }
    printf("%d\n", res);
}

int main(){
	while(~scanf("%d %d %d", &N, &F, &D)){
        init();
        Dinic();
	}
    return 0;
}
```





































