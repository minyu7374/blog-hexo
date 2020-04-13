---
title: "POJ2337/UVA10441 Catenyms"
date: "2015-08-18T13:46:37+08:00"
categories:
tags:
---

                                            
URL:[http://poj.org/problem?id=2337](http://poj.org/problem?id=2337)
URL:[https://uva.onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&category=16&page=show_problem&problem=1382](https://uva.onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&category=16&page=show_problem&problem=1382)

Description

A catenym is a pair of words separated by a period such that the last letter of the first word is the same as the last letter of the second. For example, the following are catenyms: 
dog.gopher

gopher.rat

rat.tiger

aloha.aloha

arachnid.dog


A compound catenym is a sequence of three or more words separated by periods such that each adjacent pair of words forms a catenym. For example, 


aloha.aloha.arachnid.dog.gopher.rat.tiger 


Given a dictionary of lower case words, you are to find a compound catenym that contains each of the words exactly once.
Input

The first line of standard input contains t, the number of test cases. Each test case begins with 3 <= n <= 1000 - the number of words in the dictionary. n distinct dictionary words follow; each word is a string of between 1 and 20 lowercase letters on a line
 by itself.
Output

For each test case, output a line giving the lexicographically least compound catenym that contains each dictionary word exactly once. Output "***" if there is no solution.
Sample Input
2
6
aloha
arachnid
dog
gopher
rat
tiger
3
oak
maple
elm

Sample Output
aloha.arachnid.dog.gopher.rat.tiger
***
欧拉图相关定理：
  1.无向连通图G是欧拉图，当且仅当G不含奇数度结点(G的所有结点度数为偶数)；
  2.无向连通图G含有欧拉通路，当且仅当G有零个或两个奇数度的结点；
  3.有向连通图D是欧拉图，当且仅当该图为连通图且D中每个结点的入度=出度
  4.有向连通图D含有欧拉通路，当且仅当该图为连通图且D中除两个结点外，其余每个结点的入度=出度，且此两点满足deg－(u)－deg+(v)=±1。（起始点s的入度=出度-1，结束点t的出度=入度-1 或两个点的入度=出度）
  5.一个非平凡连通图是欧拉图当且仅当它的每条边属于奇数个环。

  6.如果图G是欧拉图且 H = G - uv，则H有奇数个u,v-迹仅在最后访问v；同时，在这一序列的u,v-迹中，不是路径的迹的条数是偶数
本题实际是要求欧拉通路，根据第4条定理，先使用并查集判断是否为连通图，至于出度入度的问题只需简单统计即可。

```cpp
#include <cstdio>
#include <iostream>
#include <cstring>
#include <algorithm>
#include <string>
using namespace std;

#define maxn 1010
struct node{
    int u, v;
    string word;
} edge[maxn];

bool visited[maxn];
int in_degree[26], out_degree[26], father[26], road[maxn];
int n, start, top;

bool cmp (const node& a, const node& b) {return a.word < b.word;}

int find_set(int x){
    return father[x] == x ? x : (father[x] = find_set(father[x]));
}

void union_set(int x, int y){
    if(father[x] == -1) father[x] = x;       
    if(father[y] == -1) father[y] = y;  
    if((x = find_set(x)) != (y = find_set(y))) father[x] = y;
}

int count_set(){
    int sum = 0;
    for(int i = 0; i < 26; i++){
        if(father[i] == i) sum ++;                            // 对于不存在的节点, 其father = -1, 不影响sum计数
    }
    return sum;
}

bool exist_eular(){
    if(count_set() > 1) return false;                         //节点不在同一个并查集内，说明其基图不连通
    int count_1 = 0, count_2 = 0;
    for(int i = 0; i < 26; i++){
        if(in_degree[i] > out_degree[i] + 1 || out_degree[i] > in_degree[i] + 1) return false;                    //出入度值相差大于1.
        if(out_degree[i] == in_degree[i] + 1) {start = i; count_1++;}                                             //出度 = 入度 + 1, 为欧拉路径起点
        if(in_degree[i] == out_degree[i] + 1) count_2++;
    }
    if(count_1 > 1 || count_2 > 1 || count_1 != count_2) return false;
    if(count_1 == 1) return true;                             //count_1 = count_2 = 1, 可构成欧拉通路, 起始点已确定，直接返回真值
    for(int i = 0; i < 26; i++)                               //所有节点的出入度均相等,构成了欧拉回路, 为以字典序输出答案，故选择序号最小的节点作为起点
        if(father[i] != -1) {start = i; break;}
    return true;
}

void dfs(int now){
    for(int i = 0; i < n; i++){
        if(!visited[i] && edge[i].u == now){
            visited[i] = true;
            dfs(edge[i].v);
            road[top++] = i;
        }
    }
}

void init(){
    scanf("%d", &n);
    memset(in_degree, 0, sizeof(in_degree));
    memset(out_degree, 0, sizeof(out_degree));
    memset(father, 0xff, sizeof(father));
    for(int i = 0; i < n; i++){
        cin >> edge[i].word;
        edge[i].u = edge[i].word[0] - 'a';
        edge[i].v = edge[i].word[edge[i].word.size() - 1] - 'a';
        union_set(edge[i].u, edge[i].v);
        out_degree[edge[i].u]++;  in_degree[edge[i].v]++;
    }
    sort(edge, edge + n, cmp);
}

int main(){
    int t;
    scanf("%d", &t);
    while(t--){
        init();
        if(!exist_eular()) {printf("***\n");continue;}
        top = 0;
        memset(visited, 0, sizeof(visited));
        dfs(start);
        while(top--){
            printf(top == 0 ? "%s\n" : "%s.", edge[road[top]].word.c_str());
        }
    }
    return 0;
}
```






