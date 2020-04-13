---
title: "POJ2287／UVA1344 Tian Ji -- The Horse Racing"
date: "2014-05-18T17:27:58+08:00"
categories:
tags:
---

                                            
URL： [http://poj.org/problem?id=2287](http://poj.org/problem?id=2287)                                                                                 

                                                                                     Tian Ji -- The Horse Racing


Description
Here is a famous story in Chinese history. 
<blockquote>That was about 2300 years ago. General Tian Ji was a high official in the country Qi. He likes to play horse racing with the king and others.



Both of Tian and the king have three horses in different classes, namely, regular, plus, and super. The rule is to have three rounds in a match; each of the horses must be used in one round. The winner of a single round takes two hundred silver dollars from
 the loser. 


Being the most powerful man in the country, the king has so nice horses that in each class his horse is better than Tian's. As a result, each time the king takes six hundred silver dollars from Tian.



Tian Ji was not happy about that, until he met Sun Bin, one of the most famous generals in Chinese history. Using a little trick due to Sun, Tian Ji brought home two hundred silver dollars and such a grace in the next match.



It was a rather simple trick. Using his regular class horse race against the super class from the king, they will certainly lose that round. But then his plus beat the king's regular, and his super beat the king's plus. What a simple trick. And how do you think
 of Tian Ji, the high ranked official in China? 
<center>![](http://poj.org/images/2287_1.jpg)</center>
</blockquote>


Were Tian Ji lives in nowadays, he will certainly laugh at himself. Even more, were he sitting in the ACM contest right now, he may discover that the horse racing problem can be simply viewed as finding the maximum matching in a bipartite graph. Draw Tian's
 horses on one side, and the king's horses on the other. Whenever one of Tian's horses can beat one from the king, we draw an edge between them, meaning we wish to establish this pair. Then, the problem of winning as many rounds as possible is just to find
 the maximum matching in this graph. If there are ties, the problem becomes more complicated, he needs to assign weights 0, 1, or -1 to all the possible edges, and find a maximum weighted perfect matching...



However, the horse racing problem is a very special case of bipartite matching. The graph is decided by the speed of the horses -- a vertex of higher speed always beat a vertex of lower speed. In this case, the weighted bipartite matching algorithm is a too
 advanced tool to deal with the problem. 


In this problem, you are asked to write a program to solve this special case of matching problem.

Input
The input consists of up to 50 test cases. Each case starts with a positive integer n ( n<=1000) on the first line, which is the number of horses on each side. The next n integers on the second line are the speeds of Tian's horses.
 Then the next n integers on the third line are the speeds of the king's horses. The input ends with a line that has a single `0' after the last test case.

Output
For each input case, output a line containing a single number, which is the maximum money Tian Ji will get, in silver dollars.

Sample Input
3
92 83 71
95 87 74
2
20 20
20 20
2
20 19
22 18
0

Sample Output
200
0
0

贪心策略:

        将两人的马分别排序,得到递增序列,设

        田忌: A = a1, a2, a3, …… an

        齐王：B = b1, b2, b3, …… bn

    

       1）若 a1 > b1, a1 和 b1 比，因为齐王最慢的马一定会输，输给田忌最慢的马合适;

       2）若 a1 < b1, a1 和 bn 比，因为田忌最慢的马一定会输，输给齐王最慢的马合适;

       3）若 an > bn, an 和 bn 比，因为 an 一定会赢，赢齐王最快的马合适;

       4）若 an < bn, a1 和 bn 比，因为 bn 一定会赢，赢田忌最慢的马合适;

       5）在 an = bn 的情况下，用 a1 和 bn 比有最优解（情况较复杂，结合前几条可以分析出来）。  



```cpp
#include <stdio.h>
#include <algorithm>
int main(){
    int tj[1010],qw[1010],n;
    while(~scanf("%d", &n) && n){
           for(int i = 1; i <= n; i++)  scanf("%d", &tj[i]);
           for(int i = 1; i <= n; i++)  scanf("%d", &qw[i]);
           std::sort(tj+1 , tj+1+n);
           std::sort(qw+1 , qw+1+n);
           int tf = 1, tr = n, qf = 1, qr = n, sum = 0;
           while(tf <= tr){
                 if(tj[tf] < qw[qf]){
                      qr--; tf++; sum -= 200;
                 }else if(tj[tf] > qw[qf]){
                      tf++; qf++; sum += 200; 
                 }else{
                      while(tf <= tr && qf <= qr){
                            if(tj[tr] > qw[qr]){
                                  tr--; qr--; sum += 200;
                            }else{
                                   if(tj[tf] < qw[qr])  sum -= 200;
                                   tf++; qr--; break;                                   
                            }
                      }
                 }
         }
         printf("%d\n", sum);
    }
    return 0;
}
```
另附用加权二分图最佳匹配算法写出的解法，在POJ上提交是TLE的。


```cpp
#include <cstdio>
#include <cstring>
#include <algorithm> 
using namespace std;
const int MAX = 1010;

int n;                     
int weight[MAX][MAX];        
int lx[MAX], ly[MAX];       
bool sx[MAX], sy[MAX];     
int match[MAX]; 
int a[MAX], b[MAX];      

void init(){
    for(int i = 0; i < n; i ++)
    	scanf("%d", a + i);
    for(int i = 0; i < n; i ++)
        scanf("%d", b + i);
    for(int i = 0; i < n; i++)
    	for(int j = 0; j < n; j++)
    		if(a[i] < b[j])
    			weight[i][j] = -1;
    		else if(a[i] > b[j])
    			weight[i][j] = 1;
    		else
    			weight[i][j] = 0;
}

bool hungary(int u){   
    sx[u] = true;
    for(int v = 0; v < n; v ++)
        if(!sy [v] && lx[u] + ly[v] == weight[u][v]){
            sy[v] = true;
            if(match[v] == -1 || hungary(match[v])){
                match [v] = u;
                return true;
            }
        }
    return false;
}

int KM(){
    int i, j;
    memset(ly, 0, sizeof(ly));
    for(i = 0; i < n; i ++){
        lx[i] = -0x7FFFFFFF;
        for(j = 0; j < n; j ++)
            lx[i] = max(weight[i][j], lx[i]);
    }

    memset(match, -1, sizeof(match));
    for(int u = 0; u < n; u ++){
        while(1){
            memset(sx, 0, sizeof(sx));
            memset(sy, 0, sizeof(sy));
            if(hungary(u))   break;

            int d = 0x7FFFFFFF;
            for(i = 0; i < n; i++)
                if(sx[i])
                    for(j = 0; j < n; j ++)
                        if(!sy[j])
                            d = min(lx[i] + ly[j] - weight[i][j], d);
            for(i = 0; i < n; i ++)  if(sx[i])   lx[i] -= d;
            for(i = 0; i < n; i ++)  if(sy[i])   ly[i] += d;
            
        }
    }
    int sum = 0;
    for(i = 0; i < n; i ++)
        sum += weight[ match[i] ][i];
    return sum;
}

int main(){
    while(~scanf("%d", &n) && n){
        init();
        printf("%d\n", 200 * KM());
    }
    return 0;
} 
```

