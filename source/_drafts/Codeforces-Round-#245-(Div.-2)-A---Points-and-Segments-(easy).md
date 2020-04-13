---
title: "Codeforces Round #245 (Div. 2) A - Points and Segments (easy)"
date: "2014-05-13T16:24:40+08:00"
categories:
tags:
---

                                            
原题链接： <a href="http://codeforces.com/contest/430/problem/A" rel="nofollow"> http://codeforces.com/contest/430/problem/A
</a>
 无力吐槽的水题，尽管原题上标明了easy，但我还是不敢相信会有这么水的题！当一个题简单到你不都敢相信它会那么简单的时候，它就变难了……
                                                         A. Points and Segments (easy)


Iahub isn't well prepared on geometry problems, but he heard that this year there will be a lot of geometry problems on the IOI selection camp. Scared, Iahub locked himself in the basement and started thinking of new problems of this kind. One of them is
 the following.
Iahub wants to draw <em>n</em> distinct points and
<em>m</em> segments on the <em>OX</em> axis. He can draw each point with either red or blue. The drawing is good if and only if the following requirement is met: for each segment
[<em>l</em><sub class="lower-index"><em>i</em></sub>, <em>r</em><sub class="lower-index"><em>i</em></sub>] consider all the red points belong to it (<em>r</em><sub class="lower-index"><em>i</em></sub>
 points), and all the blue points belong to it (<em>b</em><sub class="lower-index"><em>i</em></sub> points); each segment
<em>i</em> should satisfy the inequality 
|<em>r</em><sub class="lower-index"><em>i</em></sub> - <em>b</em><sub class="lower-index"><em>i</em></sub>| ≤ 1.
Iahub thinks that point <em>x</em> belongs to segment
[<em>l</em>, <em>r</em>], if inequality 
<em>l</em> ≤ <em>x</em> ≤ <em>r</em> holds.
Iahub gives to you all coordinates of points and segments. Please, help him to find any good drawing.


Input
The first line of input contains two integers: <em>n</em> (1 ≤ <em>n</em> ≤ 100) and
<em>m</em> (1 ≤ <em>m</em> ≤ 100). The next line contains
<em>n</em> space-separated integers 
<em>x</em><sub class="lower-index">1</sub>, <em>x</em><sub class="lower-index">2</sub>, ..., <em>x</em><sub class="lower-index"><em>n</em></sub> (0 ≤ <em>x</em><sub class="lower-index"><em>i</em></sub> ≤ 100) — the coordinates
 of the points. The following <em>m</em> lines contain the descriptions of the
<em>m</em> segments. Each line contains two integers
<em>l</em><sub class="lower-index"><em>i</em></sub> and
<em>r</em><sub class="lower-index"><em>i</em></sub> (0 ≤ <em>l</em><sub class="lower-index"><em>i</em></sub> ≤ <em>r</em><sub class="lower-index"><em>i</em></sub> ≤ 100) — the borders of the
<em>i</em>-th segment.
It's guaranteed that all the points are distinct.


Output
If there is no good drawing for a given test, output a single integer -1. Otherwise output
<em>n</em> integers, each integer must be 0 or 1. The
<em>i</em>-th number denotes the color of the 
<em>i</em>-th point (0 is red, and 1 is blue).
If there are multiple good drawings you can output any of them.


Sample test(s)


Input
3 3
3 7 14
1 5
6 10
11 15



Output
0 0 0


Input
3 4
1 2 3
1 2
2 3
5 6
2 2



Output
1 0 1 






```cpp
#include <cstdio>
#include <algorithm>
struct point{
   int coo;
   int num;
}p[110];

bool cmp(point x, point y){
    return  x.coo < y.coo;
}

int main(){
    int n, m, l, r, ans[110];
    scanf("%d %d ", &n, &m);
    for(int i = 0; i < n; i ++){
        scanf("%d", &p[i].coo);
        p[i].num = i;
    }
   while(m--) { scanf("%d %d", &l, &r); }  
   std::sort(p, p + n, cmp);
   for(int i = 0; i < n; i++)
        ans[p[i].num] = i%2==0 ? 1 : 0;
   for(int i = 0; i < n-1; i++)
         printf("%d ", ans[i]);
   printf("%d\n", ans[n-1]);
   return 0;
}
```



