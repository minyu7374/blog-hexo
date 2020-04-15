---
title: "Codeforces Round #243 (Div. 1) C  Sereja and Two Sequences"
date: "2014-05-11T11:37:47+08:00"
categories:
- [Algorithm, DP]
- [Codeforces]
tags:
- DP
- Codeforces
---

> 原题链接 ：[http://codeforces.com/contest/425/problem/C](http://codeforces.com/contest/425/problem/C)

<h2><center>Sereja and Two Sequences</center></h2>

sereja has two sequences *a~1~, a~2~, ..., a~n~* and *b~1~, b~2~, ..., b~m~*, consisting of integers. One day Sereja got bored and he decided two play with them. The rules of the game was very simple. Sereja makes several moves, in one move he can perform one of the following actions:

1. Choose several (at least one) first elements of sequence *a* (non-empty prefix of *a*), choose several (at least one) first elements of sequence *b* (non-empty prefix of *b*); the element of sequence a with the maximum index among the chosen ones must be equal to the element of sequenceb with the maximum index among the chosen ones; remove the chosen elements from the sequences.
2. Remove all elements of both sequences.

The first action is worth e energy units and adds one dollar to Sereja's electronic account. The second action is worth the number of energy units equal to the number of elements Sereja removed from the sequences before performing this action. After Sereja performed the second action, he gets all the money that he earned on his electronic account during the game.

Initially Sereja has s energy units and no money on his account. What maximum number of money can Sereja get? Note, the amount of Seraja's energy mustn't be negative at any time moment.

## Input

The first line contains integers *n, m, s, e* (*1 ≤ n, m ≤ 10^5^; 1 ≤ s ≤ 3·10^5^; 10^3^ ≤ e ≤ 10^4^*). The second line contains n integers *a~1~, a~2~, ..., a~n~*(*1 ≤ a~i~ ≤ 10^5^*). The third line containsm integers *b~1~,b~2~,...,b~m~*(*1 ≤ b~i~ ≤ 10^5^*).

## Output

Print a single integer — maximum number of money in dollars that Sereja can get.

## Sample test(s)

### Input
```
5 5 100000 1000
1 2 3 4 5
3 2 4 5 1
```

### Output

```
3
```

### Input

```
3 4 3006 1000
1 2 3
1 2 4 3
```

### Output

```
2
```

简单的DP问题，可我开始没读懂题意（英语有待提高），看了大神的解释和代码，才明白怎么回事儿。

记下大神写的题目大意：两个长度分别为n,m的序列，序列中均为不超过100000的正数，现有两种操作， 操作1消耗e点能量，可以选择两个序列的前缀，保证这两个前缀的最后一个数相同，然后删去这两个前缀， 分数+1；操作2消耗当前两个序列中被删掉的数的个数，然后清空两个序列，得到由操作1累加起来的分数。现在给定两个序列和总能量s以及操作1消耗的能量e，求最大的分数。

用`dp[i][j]`表示 对于a序列中的前i个数，在作第k次第一种操作时b序列的最靠前位置。在代码里可以把
第一维给压缩掉（这也是DP常用的技俩）。

```cpp
#include <cstdio>
#include <cstring>
#include <algorithm>
#include <vector>
using namespace std;
#define maxn 100010

int a[maxn], b[maxn];
int dp[333];
vector<int> site[maxn];

int main(){
    int n, m, s, e;
    scanf("%d %d %d %d", &n,&m,&s,&e);
    memset(dp, 0x3f, sizeof(dp));
    dp[0] = 0;
    for(int i = 1; i <= n; i++)  scanf("%d", a+i);
    for(int i = 1; i <= m; i++)  scanf("%d", b+i), site[b[i]].push_back(i);
    int ans = 0;
    for(int i = 1; i <= n; i++){
         for(int j = s/e; j >= 0; j--){
             vector<int>::iterator it = upper_bound(site[a[i]].begin(), site[a[i]].end(), dp[j]);
             if(it == site[a[i]].end()) continue;
             dp[j+1] = min(*it, dp[j+1]);
             if(i+dp[j+1]+(j+1)*e <= s)
                 ans = max(ans,j+1);
         }
    }
    printf("%d\n",ans);
    return 0;
}
```
