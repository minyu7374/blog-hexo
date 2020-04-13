---
title: "Codeforces Round #245 (Div. 1)  A /(Div.2 C)  Xor-tree"
date: "2014-05-13T22:55:13+08:00"
categories:
tags:
---

                                            
原题链接：    [
http://codeforces.com/contest/429/problem/A](http://codeforces.com/contest/429/problem/A)     或       <a href="http://codeforces.com/contest/430/problem/C" rel="nofollow">
http://codeforces.com/contest/430/problem/C
</a>


                                                                    Xor-tree


Iahub is very proud of his recent discovery, propagating trees. Right now, he invented a new tree, called xor-tree. After this new revolutionary discovery, he invented a game for kids which uses xor-trees.
The game is played on a tree having <em>n</em> nodes, numbered from1 to<em>n</em>. Each node<em>i</em> has an initial value<em>init</em><sub class="lower-index"><em>i</em></sub>,
 which is either 0 or 1. The root of the tree is node 1.
One can perform several (possibly, zero) operations on the tree during the game. The only available type of operation is to pick a node<em>x</em>. Right after someone has picked node<em>x</em>,
 the value of node <em>x</em> flips, the values of sons of<em>x</em> remain the same, the values of sons of sons of<em>x</em> flips, the values of sons of sons of sons
 of<em>x</em> remain the same and so on.
The goal of the game is to get each node <em>i</em> to have value<em>goal</em><sub class="lower-index"><em>i</em></sub>, which can also be only 0 or 1. You need to reach the goal of the game by
 using minimum number of operations.


Input
The first line contains an integer <em>n</em> (1 ≤ <em>n</em> ≤ 10<sup class="upper-index">5</sup>). Each of the next<em>n</em> - 1 lines contains two integers<em>u</em><sub class="lower-index"><em>i</em></sub>
 and<em>v</em><sub class="lower-index"><em>i</em></sub> (1 ≤ <em>u</em><sub class="lower-index"><em>i</em></sub>, <em>v</em><sub class="lower-index"><em>i</em></sub> ≤ <em>n</em>;<em>u</em><sub class="lower-index"><em>i</em></sub> ≠ <em>v</em><sub class="lower-index"><em>i</em></sub>)
 meaning there is an edge between nodes<em>u</em><sub class="lower-index"><em>i</em></sub> and<em>v</em><sub class="lower-index"><em>i</em></sub>.
The next line contains <em>n</em> integer numbers, the<em>i</em>-th of them corresponds to<em>init</em><sub class="lower-index"><em>i</em></sub> (<em>init</em><sub class="lower-index"><em>i</em></sub>
 is either 0 or 1). The following line also contains<em>n</em> integer numbers, the<em>i</em>-th number corresponds to<em>goal</em><sub class="lower-index"><em>i</em></sub>
 (<em>goal</em><sub class="lower-index"><em>i</em></sub> is either 0 or 1).


Output
In the first line output an integer number <em>cnt</em>, representing the minimal number of operations you perform. Each of the next<em>cnt</em> lines should contain an integer<em>x</em><sub class="lower-index"><em>i</em></sub>,
 representing that you pick a node<em>x</em><sub class="lower-index"><em>i</em></sub>.

Sample test(s)

Input
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


Output
2
4
7
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

