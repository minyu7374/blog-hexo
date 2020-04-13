---
title: "POJ2481 Cows"
date: "2014-07-16T14:53:29+08:00"
categories:
tags:
---

                                            
URL: [http://poj.org/problem?id=2481](http://poj.org/problem?id=2481)


Description

Farmer John's cows have discovered that the clover growing along the ridge of the hill (which we can think of as a one-dimensional number line) in his field is particularly good. 


Farmer John has N cows (we number the cows from 1 to N). Each of Farmer John's N cows has a range of clover that she particularly likes (these ranges might overlap). The ranges are defined by a closed interval [S,E]. 


But some cows are strong and some are weak. Given two cows: cow<sub>i</sub> and cow<sub>j</sub>, their favourite clover range is [Si, Ei] and [Sj, Ej]. If Si <= Sj and Ej <= Ei and Ei - Si > Ej - Sj, we say that cow<sub>i</sub> is stronger than cow<sub>j</sub>. 


For each cow, how many cows are stronger than her? Farmer John needs your help!
Input

The input contains multiple test cases. 

For each test case, the first line is an integer N (1 <= N <= 10<sup>5</sup>), which is the number of cows. Then come N lines, the i-th of which contains two integers: S and E(0 <= S < E <= 10<sup>5</sup>) specifying the start end location respectively of a
 range preferred by some cow. Locations are given as distance from the start of the ridge. 


The end of the input contains a single 0.
Output

For each test case, output one line containing n space-separated integers, the i-th of which specifying the number of cows that are stronger than cow<sub>i</sub>. 

Sample Input
3
1 2
0 3
3 4
0

Sample Output
1 0 0

   线段树单点更新，排序时先按s从小到大，再按e从大到小的顺序排，这样每次查询就可以方便的找出比当前e大的出现的数目。
这次做这个题有点坑，因为最开始定义数组的时候少打了一个零，以至于数组太小，一直 RE 。

```cpp
#include <cstdio>
#include <algorithm>
#define ls (s << 1)
#define rs (s << 1 | 1)

struct cow {
    int s, e, id;
}c[100010];
int sum[100010 << 2], ans[100010];

inline int max(int a, int b){
    return a > b ? a : b;
}

bool cmp(cow a, cow b) {
    if(a.s == b.s)
        return a.e > b.e;
    return a.s < b.s;
}

void build_tree(int l, int r, int s){
    sum[s] = 0;
    if (l == r)   return;
    int m = (l + r) >> 1;
    build_tree(l, m, ls);
    build_tree(m + 1, r, rs);
}

void insert_tree(int l, int r,  int s, int p){
    if (l == r) {
        sum[s]++;  return;
    }
    int m = (l + r) >> 1;
    if (p <= m) 
    	insert_tree(l, m, ls, p);
    else 
    	insert_tree(m + 1, r, rs, p);
    sum[s] = sum[ls] + sum[rs]; 
}

int query_tree(int l, int r, int s, int ll, int rr){
    if(ll <= l && r <= rr)  return sum[s];
    int m = (l + r) >> 1;
    int q = 0;
    if(ll <= m) q += query_tree(l, m, ls, ll, rr);
    if(rr > m)  q += query_tree(m + 1, r, rs, ll, rr);
    return q;
}

int main(){
    int n, maxe;
    while(~scanf("%d", &n) && n){
        maxe = 0;
        for(int i = 0; i < n; i++){
            scanf("%d %d", &c[i].s, &c[i].e);
            maxe = max(maxe, c[i].e);
            c[i].id = i;
        }
        std::sort(c, c + n, cmp);
        build_tree(1, maxe, 1);
        ans[ c[0].id ] = 0;
        insert_tree(1, maxe, 1, c[0].e);
        for(int i = 1; i < n; i++) {
            if(c[i].s == c[i - 1].s && c[i].e == c[i - 1].e)
                ans[ c[i].id ] = ans[ c[i - 1].id ];
            else
                ans[ c[i].id ] = query_tree(1, maxe, 1, c[i].e, maxe);
            insert_tree(1, maxe, 1, c[i].e);
        }
        for(int i = 0; i < n - 1; i++)
            printf("%d ", ans[i]);
        printf("%d\n", ans[n-1]);
    }
    return 0;
}
```




