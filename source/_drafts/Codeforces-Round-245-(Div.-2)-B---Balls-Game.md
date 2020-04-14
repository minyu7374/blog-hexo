---
title: "Codeforces Round #245 (Div. 2) B - Balls Game"
date: "2014-05-14T17:51:19+08:00"
categories:
tags:
---

                                            
URL:  [
http://codeforces.com/contest/430/problem/B](http://codeforces.com/contest/430/problem/B)
                                                       B. Balls Game



Iahub is training for the IOI. What is a better way to train than playing a Zuma-like game?
There are <em>n</em> balls put in a row. Each ball is colored in one of<em>k</em> colors. Initially the row doesn't contain three or more contiguous balls with the same color. Iahub has a single
 ball of color<em>x</em>. He can insert his ball at any position in the row (probably, between two other balls). If at any moment there are three or more contiguous balls of the same color in the row, they are destroyed immediately.
 This rule is applied multiple times, until there are no more sets of 3 or more contiguous balls of the same color.
For example, if Iahub has the row of balls [black, black, white, white, black, black] and a white ball, he can insert the ball between two white balls. Thus three white balls are destroyed, and then four black balls become contiguous, so all four balls are
 destroyed. The row will not contain any ball in the end, so Iahub can destroy all 6 balls.
Iahub wants to destroy as many balls as possible. You are given the description of the row of balls, and the color of Iahub's ball. Help Iahub train for the IOI by telling him the maximum number of balls from the row he can destroy.


Input
The first line of input contains three integers: <em>n</em> (1 ≤ <em>n</em> ≤ 100),<em>k</em> (1 ≤ <em>k</em> ≤ 100) and<em>x</em>
 (1 ≤ <em>x</em> ≤ <em>k</em>). The next line contains<em>n</em> space-separated integers
<em>c</em><sub class="lower-index">1</sub>, <em>c</em><sub class="lower-index">2</sub>, ..., <em>c</em><sub class="lower-index"><em>n</em></sub> (1 ≤ <em>c</em><sub class="lower-index"><em>i</em></sub> ≤ <em>k</em>).
 Number<em>c</em><sub class="lower-index"><em>i</em></sub> means that the<em>i</em>-th ball in the row has color
<em>c</em><sub class="lower-index"><em>i</em></sub>.
It is guaranteed that the initial row of balls will never contain three or more contiguous balls of the same color.


Output
Print a single integer — the maximum number of balls Iahub can destroy.

Sample test(s)

Input
6 2 2
1 1 2 2 1 1



Output
6



Input
1 1 1
1


Output
0

水题，用穷举法即可

```cpp
#include <cstdio>
int n, k, x;
int a[110];

int main(){
  int i, l, r, cnt, tmp, ans = 0;
  scanf("%d %d %d", &n, &k, &x);
  for(i = 0; i < n; i++)
      scanf("%d", &a[i]);
  for(i = 0; i < n; i++)
      if(a[i] == x){
          l = r = i; cnt = 0;
          while(a[l] == a[r]) {
              tmp = 2;
              while(l > 0 && a[l-1] == a[l])   l--,tmp++;
              while(r < n-1 && a[r+1] == a[r])   r++,tmp++;
              --l; ++r;
              if(tmp < 3)  break;
              cnt += tmp;
              if(l < 0 || r >= n)  break;
                   }
      if(cnt-1 > ans) ans = cnt-1;
      }
   printf("%d\n", ans);
   return 0;
}
```

