---
title: "Codeforces Round #245 (Div. 1)  A /(Div.2 C)  Xor-tree"
date: "2014-05-13T22:55:13+08:00"
categories:
- [Algorithm, DFS]
- [Codeforces]
tags:
- DFS
- Codeforces
---

> 原题链接： [ http://codeforces.com/contest/429/problem/A](http://codeforces.com/contest/429/problem/A)

<h2><center>Xor-tree</center></h2>

Iahub is very proud of his recent discovery, propagating trees. Right now, he invented a new tree, called xor-tree. After this new revolutionary discovery, he invented a game for kids which uses xor-trees.

The game is played on a tree having *n* nodes, numbered from 1 to *n*. Each node *i* has an initial value *init~i~*, which is either 0 or 1. The root of the tree is node 1.

One can perform several (possibly, zero) operations on the tree during the game. The only available type of operation is to pick a node *x*. Right after someone has picked node *x*, the value of node *x* flips, the values of sons of *x* remain the same, the values of sons of sons of *x* flips, the values of sons of sons of sons of *x* remain the same and so on.

The goal of the game is to get each node *i* to have value *goal~i~*, which can also be only 0 or 1. You need to reach the goal of the game by using minimum number of operations.

## Input

The first line contains an integer *n* (1 ≤ *n* ≤ 10^5^). Each of the next *n - 1* lines contains two integers *u~i~* and *v~i~* (1 ≤ *u~i~*, *v~i~* ≤ *n*; *u~i~* ≠ *v~i~*) meaning there is an edge between nodes *u~i~* and *v~i~*.

The next line contains *n* integer numbers, the *i*-th of them corresponds to *init~i~* (*init~i~* is either 0 or 1). The following line also contains *n* integer numbers, the *i*-th number corresponds to *goal~i~* (*goali* is either 0 or 1).

## Output

In the first line output an integer number *cnt*, representing the minimal number of operations you perform. Each of the next *cnt* lines should contain an integer *x~i~*, representing that you pick a node *x~i~*.

## Sample test(s)

### Input

```
10
2 1
3 1
4 2
5 1
6 2
7 5
8 6
9 8
10 5
1 0 1 1 0 1 0 1 0 1
1 0 1 0 0 1 1 1 0 1
```

### Output

```
2
4
7
```

这道题我自己做是没有任何思路的，无奈之下研究了大神的代码，解法实在是太漂亮了，我这种菜鸟想不到是很正常的！

```cpp
#include <cstdio>
#include <vector>
#define maxn 100010

std::vector<int> Edge[maxn];
int n, a[maxn], b[maxn]; 
int cnt = 0, ans[maxn];

void dfs(int rt, int pre, int p1, int p2){
    if( a[rt]^ p1 != b[rt] ){      //(1/0)与0异或不翻转；与1异或 翻转
        ans[cnt++] = rt;    //a、b不同需要 flip
        p1 = 1- p1;    //翻转 flip
    }

    for(int i = 0; i < Edge[rt].size(); i++){
        int &e = Edge[rt][i];     //注意此处的引用
        if(e == pre) continue;    //父节点
        dfs(e, rt, p2, p1);     //p1 、p2参数位置的交换实现flip的“隔代遗传” 
    }
}

int main(){
    int i, x, y;
    scanf("%d", &n);
    for(i = 1; i < n; i++){
       scanf("%d %d",&x, &y);
       Edge[x].push_back(y);
       Edge[y].push_back(x);
    }
    for(i = 1; i <= n; i++)  scanf("%d", a + i); 
    for(i = 1; i <= n; i++)  scanf("%d", b + i);
    dfs(1, -1, 0, 0);
    printf("%d\n", cnt);
    for(i = 0; i < cnt; i++)
        printf("%d\n", ans[i]);
    return 0;
}
```
