---
title: "Codeforces Round #243 (Div. 1) A Sereja and Swaps"
date: "2014-05-10T23:52:31+08:00"
categories:
- [Algorithm, 穷举]
- [Codeforces]
tags:
- 穷举
- Codeforces
---

> URL：[http://codeforces.com/contest/425/problem/A](http://codeforces.com/contest/425/problem/A)

## 题目描述

<h3><center>A. Sereja and Swaps</center></h3>
<center>time limit per test                                    memory limit per test</center>
<center>    1 second                                                256 megabytes</center>

As usual, Sereja has array **a**, its elements are integers: `a[1],a[2],...,a[n]`. Let's introduce notation:

![codeforces 425A](http://espresso.codeforces.com/eeff175d11496a6af7bbd528a58e3e5c10fdf69d.png)

A swap operation is the following sequence of actions:
- choose two indexes `i, j (i ≠ j)`;
- perform assignments `tmp = a[i], a[i] = a[j], a[j] = tmp`.

## Input
The first line contains two integers *n* and *k* (1 ≤ *n* ≤ 200; 1 ≤ *k* ≤ 10). The next line contains *n* integers *a*[1], *a*[2], ..., *a*[*n*] ( - 1000 ≤ *a*[*i*] ≤ 1000).

## Output

In a single line print the maximum value of *m*(*a*) that Sereja can get if he is allowed to perform at most *k* swap operations.

##  Sample test(s)

### Input

```
10 2
10 -1 2 2 2 2 2 2 -1 10
```

### Output

```
32
```

###  Input

```
5 10
-1 -1 -1 -1 -1

```

### Output

```
-1
```

### 解题思路

穷举所有范围内能取得的最大值，对于某一范围，将此范围内的数据单独拿出并排序，再把此范围外的数据存入另一数组并排序，在k次之内，每次拿后者的最大值a替换前者的最小值b（前提是a>b）。

### 代码

```cpp
#include
#include
using namespace std;
int main(){
     int n, k, a[210], b[210], c[210];
     scanf("%d %d", &n, &k);
     for(int i = 1; i <= n; i++)
           scanf("%d",&a[i]);
     int i, j, p, q, ans= -1e9;
     for(int l = 1; l <= n; l++){
           for(int r = l; r <= n; r++){
                  for(p = 1, i = l;   i <= r;  i++,p++)   b[p] = a[i];
                  for(q = 1, j = 1;   j=1;  i++,j--){
                          if(c[j] > b[i])   swap(b[i], c[j]);
                          else break;
                  }
                  int s = 0;
                  for(int i = 1; i < p; i++)
                         s += b[i];
                  ans = max(ans, s);
           }
     }
     printf("%d\n",ans);
     return 0;
}
```