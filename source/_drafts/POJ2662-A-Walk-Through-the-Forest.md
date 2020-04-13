---
title: "POJ2662  A Walk Through the Forest"
date: "2014-07-14T13:52:26+08:00"
categories:
tags:
---

                                            
URL: [http://poj.org/problem?id=2662](http://poj.org/problem?id=2662)

Description

Jimmy experiences a lot of stress at work these days, especially since his accident made working difficult. To relax after a hard day, he likes to walk home. To make things even nicer, his office is on one side of a forest, and his house is on the other. A
 nice walk through the forest, seeing the birds and chipmunks is quite enjoyable. 

The forest is beautiful, and Jimmy wants to take a different route everyday. He also wants to get home before dark, so he always takes a path to make progress towards his house. He considers taking a path from A to B to be progress if there exists a route from
 B to his home that is shorter than any possible route from A. Calculate how many different routes through the forest Jimmy might take. 

Input

Input contains several test cases followed by a line containing 0. Jimmy has numbered each intersection or joining of paths starting with 1. His office is numbered 1, and his house is numbered 2. The first line of each test case gives the number of intersections
 N, 1 < N <= 1000, and the number of paths M. The following M lines each contain a pair of intersections a b and an integer distance 1 <= d <= 1000000 indicating a path of length d between intersection a and a different intersection b. Jimmy may walk a path
 any direction he chooses. There is at most one path between any pair of intersections.
Output

For each test case, output a single integer indicating the number of different routes through the forest. You may assume that this number does not exceed 2147483647.
Sample Input
5 6
1 3 2
1 4 2
3 4 3
1 5 12
4 2 34
5 2 24
7 8
1 3 1
1 4 1
3 7 1
7 4 1
7 5 1
6 7 1
5 2 1
6 2 1
0

Sample Output
2
4

     题目出的很直接，就是Dijkstra算法加记忆化搜索，代码如下：

```cpp
#include <cstdio>
#include <cstring>
#define INF 0x3F3F3F3F

int cost[1010][1010], dist[1010], f[1010];
bool find[1010];
int n, m, s, e, w;

void init(){
    scanf("%d", &m);
    std::memset(dist, 0x3F, sizeof(dist));
    std::memset(cost, 0x3F, sizeof(cost));
    std::memset(find, 0, sizeof(find));
    for(int i = 1; i <= n; i++)
        cost[i][i]= 0;
    while(m--){
        scanf("%d %d %d", &s, &e, &w);
        cost[s][e] = cost[e][s] = w;
    }

}

void Dijkstra(){
    int min, point;
    for(int i = 1; i <= n; i++)
        dist[i] = cost[2][i];
    find[2] = 1; 
    for(int i = 1; i <= n; i++){
        min = INF;
        for(int j = 1; j <= n; j++){
            if(!find[j] && dist[j] < min){
                min = dist[j];
                point = j; 
            }            
        }
        find[point] = 1;
        for(int k = 1; k <= n; k++){
            if(!find[k] && cost[k][point] + min < dist[k])
                dist[k] = cost[k][point] + min;
        }
    }   
    
}

int DFS(int x){
    if(f[x] > 0) return f[x];
    int s = 0;
    for(int i = 1; i <= n; i++){
        if(dist[x] > dist[i] && cost[x][i] != INF)
            s += DFS(i);
    }
    f[x] = s;
    return s;
}
int main(){
    while(scanf("%d", &n) && n){
        init();
        Dijkstra();
        std::memset(f, 0 , sizeof(f)); f[2] = 1;
        printf("%d\n", DFS(1));                        
    }
    return 0;
