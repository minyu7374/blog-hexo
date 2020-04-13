---
title: "POJ1274 The Perfect Stall"
date: "2014-06-04T23:15:32+08:00"
categories:
tags:
---

                                            
原题链接：[http://poj.org/problem?id=1274](http://poj.org/problem?id=1274)
                                                                 The Perfect Stall

Description
Farmer John completed his new barn just last week, complete with all the latest milking technology. Unfortunately, due to engineering problems, all the stalls in the new barn are different. For the first week, Farmer John randomly
 assigned cows to stalls, but it quickly became clear that any given cow was only willing to produce milk in certain stalls. For the last week, Farmer John has been collecting data on which cows are willing to produce milk in which stalls. A stall may be only
 assigned to one cow, and, of course, a cow may be only assigned to one stall. 

Given the preferences of the cows, compute the maximum number of milk-producing assignments of cows to stalls that is possible.

Input
The input includes several cases. For each case, the first line contains two integers, N (0 <= N <= 200) and M (0 <= M <= 200). N is the number of cows that Farmer John has and M is the number of stalls in the new barn. Each of
 the following N lines corresponds to a single cow. The first integer (Si) on the line is the number of stalls that the cow is willing to produce milk in (0 <= Si <= M). The subsequent Si integers on that line are the stalls in which that cow is willing to
 produce milk. The stall numbers will be integers in the range (1..M), and no stall will be listed twice for a given cow.
Output
For each case, output a single line with a single integer, the maximum number of milk-producing stall assignments that can be made.
Sample Input
5 5
2 2 5
3 2 3 4
2 1 5
3 1 2 5
1 2 

Sample Output
4
       典型的二分图最大匹配问题。这类问题可在前后分别添加源点和汇点，并将各边的权值赋为1,从而使其转化为网络图最大流问题，但这样做的时间复杂度相对较高；最好还是采用经典的匈牙利算法，算法的核心就是通过不断寻找关于当前匹配的增广路径来修改此匹配直至达到饱和。

```cpp
#include <cstdio>
#include <cstring>

int n, m, map[210][210]; 
int state[210], link[210];  

bool find(int p){
    for(int i = 1; i <= m; i++){
     	if(map[p][i] && !state[i]){
             state[i] = 1;
             int j = link[i]; link[i] = p;
     	     if(j == -1 || find(j)) return true;
     	     link[i] = j;
        }
    }
    return false;
}

int main(){
    int si, tmp, ans;
    while(~scanf("%d %d", &n, &m)){
        memset(map, 0, sizeof(map)); 
        for(int i = 1; i <= n; i++){
            scanf("%d", &si);
            for(int j = 1; j <= si; j++){
	        scanf("%d", &tmp);
                map[i][tmp] = 1;
           }
        }   
        ans = 0;
        memset(link, -1, sizeof(link));
        for(int i = 1; i <= n; i++){
            memset(state, 0, sizeof(state));
            if(find(i))   ans++;
        }
        printf("%d\n",ans);    
    }    
    return 0;
}
```






















