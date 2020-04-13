---
title: "POJ1419 Graph Coloring"
date: "2015-08-19T17:10:17+08:00"
categories:
tags:
---

                                            
Description
You are to write a program that tries to find an optimal coloring for a given graph. Colors are applied to the nodes of the graph and the only available colors are black and white. The coloring of the graph is called optimal
 if a maximum of nodes is black. The coloring is restricted by the rule that no two connected nodes may be black. 


![](http://poj.org/images/1419_1.jpg) 

Figure 1: An optimal graph with three black nodes 

Input
The graph is given as a set of nodes denoted by numbers 1...n, n <= 100, and a set of undirected edges denoted by pairs of node numbers (n1, n2), n1 != n2. The input file contains m graphs. The number m is given on the
 first line. The first line of each graph contains n and k, the number of nodes and the number of edges, respectively. The following k lines contain the edges given by a pair of node numbers, which are separated by a space.
Output
The output should consists of 2m lines, two lines for each graph found in the input file. The first line of should contain the maximum number of nodes that can be colored black in the graph. The second line should contain
 one possible optimal coloring. It is given by the list of black nodes, separated by a blank.
Sample Input
1
6 8
1 2
1 3
2 4
2 5
3 4
3 6
4 6
5 6
Sample Output
3
1 4 5


由于相邻节点颜色不同，同种颜色的节点就组成了一个独立集，显然题目要求计算图的最大独立子集。
而 图的最大独立子集 = 补图的最大团
最大团问题的解法很多，这里采用最简单同时也很低效的搜索算法，为提高一些效率，储存从每个节点作为团首节点得来的团节点数，进行减枝优化。

```cpp
<pre name="code" class="cpp">#include <cstdio>
#include <cstring>
using namespace std;

#define maxn 105
bool graph[maxn][maxn];
int get[maxn][maxn];
int node[maxn], res[maxn], num_c[maxn];
int n, m, t, maxc;

void dfs(int now, int sum){
    if(sum == 0){
        if(now > maxc){
            maxc = now;
            for(int i = 1; i <= maxc; i++) res[i] = node[i];
        }
        return;
    }
    for(int i = 1; i <= sum; i++){
        int v = get[now][i], t = 0;
        if(now + num_c[v] <= maxc) return;
        for(int j = i + 1; j <= sum; j++)
            if(graph[v][get[now][j]]) get[now + 1][++t] = get[now][j];
        node[now + 1] = v;
        dfs(now + 1, t);
    }
}

int main(){
    scanf("%d", &t);
    while(t--){
        scanf("%d %d", &n, &m);
        memset(graph, 0xff, sizeof(graph));
        for(int i = 1; i <= m; i++){
            int a, b;
            scanf("%d %d", &a, &b);
            graph[a][b] = graph[b][a] = false;
        }
        maxc = 0;
        for(int i = n; i >= 1; i--){
            int sum = 0;
            for(int j = i + 1; j <= n; j++)
                if(graph[i][j]) get[1][++sum] = j;
            node[1] = i;
            dfs(1, sum);
            num_c[i] = maxc;
        }
        printf("%d\n", maxc);
        for(int i = 1; i < maxc; i++)
            printf("%d ", res[i]);
        printf("%d\n", res[maxc]);

    }
    return 0;
}
```


