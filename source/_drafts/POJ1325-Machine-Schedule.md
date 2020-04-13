---
title: "POJ1325 Machine Schedule"
date: "2014-07-17T20:14:46+08:00"
categories:
tags:
---

                                            

Machine Schedule


Description

As we all know, machine scheduling is a very classical problem in computer science and has been studied for a very long history. Scheduling problems differ widely in the nature of the constraints that must be satisfied and the type of schedule desired. Here
 we consider a 2-machine scheduling problem. 


There are two machines A and B. Machine A has n kinds of working modes, which is called mode_0, mode_1, ..., mode_n-1, likewise machine B has m kinds of working modes, mode_0, mode_1, ... , mode_m-1. At the beginning they are both work at mode_0. 


For k jobs given, each of them can be processed in either one of the two machines in particular mode. For example, job 0 can either be processed in machine A at mode_3 or in machine B at mode_4, job 1 can either be processed in machine A at mode_2 or in machine
 B at mode_4, and so on. Thus, for job i, the constraint can be represent as a triple (i, x, y), which means it can be processed either in machine A at mode_x, or in machine B at mode_y. 


Obviously, to accomplish all the jobs, we need to change the machine's working mode from time to time, but unfortunately, the machine's working mode can only be changed by restarting it manually. By changing the sequence of the jobs and assigning each job to
 a suitable machine, please write a program to minimize the times of restarting machines. 

Input

The input file for this program consists of several configurations. The first line of one configuration contains three positive integers: n, m (n, m < 100) and k (k < 1000). The following k lines give the constrains of the k jobs, each line is a triple: i,
 x, y. 


The input will be terminated by a line containing a single zero. 

Output

The output should be one integer per line, which means the minimal times of restarting machine.
Sample Input
5 5 10
0 1 1
1 1 2
2 1 3
3 1 4
4 2 1
5 2 2
6 2 3
7 2 4
8 3 3
9 4 3
0

Sample Output
3


   很明显的二分匹配问题,利用了 二分图最小点覆盖数 == 最大匹配数 的原理


```cpp
#include <cstdio>
#include <cstring>

bool graph[105][105], state[105];
int n, m, link[105];

bool find(int p){
    for(int i = 1; i <= m; i++){
        if(graph[p][i] && !state[i]){
            state[i] = 1;
            int j = link[i];
            if( !j || find(j) ){
                link[i] = p; return true;
            }
        }
    }
    return false;
}

int main(){
    int k, x, y, ans;
    while(~scanf("%d", &n) && n){
        scanf("%d %d", &m, &k);
        memset(graph, 0, sizeof(graph));
        while(k--){
            scanf("%d %d %d", &x, &x, &y);
            graph[x][y] = 1;
        }
        ans = 0;
        memset(link, 0, sizeof(link));
        for(int i = 1; i <= n; i++){
            memset(state, 0, sizeof(state));
            if(find(i))   ans++;
        }
        printf("%d\n", ans);
    }
    return 0;
}
```
