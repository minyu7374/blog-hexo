---
title: "POJ3667 Hotel"
date: "2015-08-17T11:02:39+08:00"
categories:
tags:
---

                                            
URL[:http://poj.org/problem?id=3667](http://poj.org/problem?id=3667)


Description

The cows are journeying north to Thunder Bay in Canada to gain cultural enrichment and enjoy a vacation on the sunny shores of Lake Superior. Bessie, ever the competent travel agent, has named the Bullmoose Hotel on famed Cumberland Street as their vacation
 residence. This immense hotel has <em>N</em> (1 ≤ <em>N</em> ≤ 50,000) rooms all located on the same side of an extremely long hallway (all the better to see the lake, of course).
The cows and other visitors arrive in groups of size <em>D<sub>i</sub></em> (1 ≤<em>D<sub>i</sub></em> ≤ N) and approach the front desk to check in. Each group
<em>i</em> requests a set of <em>D<sub>i</sub></em> contiguous rooms from Canmuu, the moose staffing the counter. He assigns them some set of consecutive room numbers<em>r</em>..<em>r</em>+<em>D<sub>i</sub></em>-1 if they are available or, if no contiguous
 set of rooms is available, politely suggests alternate lodging. Canmuu always chooses the value of<em>r</em> to be the smallest possible.
Visitors also depart the hotel from groups of contiguous rooms. Checkout <em>i</em> has the parameters<em> X<sub>i</sub></em> and<em>D<sub>i</sub></em> which specify the vacating of rooms
<em>X<sub>i</sub></em> ..<em>X<sub>i</sub></em> +<em>D<sub>i</sub></em>-1 (1 ≤<em>X<sub>i</sub></em> ≤
<em>N</em>-<em>D<sub>i</sub></em>+1). Some (or all) of those rooms might be empty before the checkout.
Your job is to assist Canmuu by processing <em>M</em> (1 ≤ <em>M</em> < 50,000) checkin/checkout requests. The hotel is initially unoccupied.

Input

* Line 1: Two space-separated integers: <em>N</em> and <em>M</em>

* Lines 2..<em>M</em>+1: Line <em>i</em>+1 contains request expressed as one of two possible formats: (a) Two space separated integers representing a check-in request: 1 and<em>D<sub>i
</sub></em>(b) Three space-separated integers representing a check-out: 2,<em>X<sub>i</sub></em>, and
<em>D<sub>i </sub></em>

Output

* Lines 1.....: For each check-in request, output a single line with a single integer<em>r</em>, the first room in the contiguous sequence of rooms to be occupied. If the request cannot be satisfied, output 0.

Sample Input
10 6
1 3
1 3
1 3
1 3
2 5 5
1 6

Sample Output
1
4
7
0
5


线段树区间更新
Node节点含义：
mark               对应区间的状态，0 未定、1 全空、2 全满
ls                     左端最长空区间长度
rs                     右端最长空区间长度
ms                   区间内最长空区间的长度
pos                  空区间开始位置



```cpp
#include <cstdio>
#include <algorithm>
#include <cstring>
#define maxn 50010
using namespace std;

struct interval_tree{
    struct Node{
        int ls, rs, ms, pos, mark;
    } node[maxn << 2];
    
    void build(int l, int r, int i){
        node[i].ls = node[i].rs = node[i].ms = r - l + 1;
        node[i].pos = l;
        if(l == r) return;
        int mid = (l + r) >> 1;
        build(l, mid, i << 1);
        build(mid + 1, r, i << 1 | 1);
    }

    bool all_space(int l, int r, int i){
        return node[i].ls == r - l + 1;
    }

    void update(int l, int r, int i){
        if(!node[i].mark) return;
        if(node[i].mark == 1){
            int len = r -l + 1;
            node[i << 1].ls = node[i << 1].rs = node[i << 1].ms = (len + 1) / 2;
            node[i << 1].pos = l;
            node[i << 1 | 1].ls = node[i << 1 | 1].rs = node[i << 1 | 1].ms = len / 2;
            node[i << 1 | 1].pos = (l + r) >> 1 + 1;
            node[i << 1].mark = node[i << 1 |1].mark = 1;
        }
        else{
            node[i << 1].ls = node[i << 1].rs = node[i << 1].ms = 0;
            node[i << 1].pos = l;
            node[i << 1 | 1].ls = node[i << 1 | 1].rs = node[i << 1 | 1].ms = 0;
            node[i << 1 | 1].pos = (l + r) >> 1 + 1;
            node[i << 1].mark = node[i << 1 |1].mark = 2;
        }
        node[i].mark = 0;
    }

    int query(int d, int l, int r, int i){
        update(l, r, i);
        if(node[i].ms < d) return 0;
        if(node[i].ms == d) return node[i].pos;
        int mid = (l + r) >> 1;
        if(node[i << 1].ms >= d) return query(d, l, mid, i << 1);
        if(node[i << 1].rs + node[i << 1 | 1].ls >= d) return mid - node[i << 1].rs + 1;
        return query(d, mid + 1, r, i << 1 | 1);
    }
    
    void change(int tl, int tr, int l, int r, int i, bool flag){
        if(tr < l || tl > r) return;
        if(tl <= l && r <= tr) {
            if(flag) {
                node[i].ls = node[i].rs = node[i].ms = 0;
                node[i].pos = l;
                node[i].mark = 2;
            }
            else{
                node[i].ls = node[i].rs = node[i].ms = r - l + 1;
                node[i].pos = l;
                node[i].mark = 1;
            }
            return;
        }
        update(l, r, i);
        int mid = (l + r) >> 1;
        change(tl, tr, l, mid, i << 1, flag);
        change(tl, tr, mid + 1, r, i << 1 | 1, flag);
        node[i].ls = node[i << 1].ls;
        if(all_space(l, mid, i << 1))
            node[i].ls += node[i << 1 | 1].ls;
        node[i].rs = node[i << 1 | 1].rs;
        if(all_space(mid + 1, r, i << 1 | 1))
            node[i].rs += node[i << 1].rs;
        node[i].ms = max(node[i << 1].rs + node[i << 1 | 1].ls, max(node[i << 1].ms, node[i << 1 | 1].ms));
        if(node[i].ms == node[i << 1].ms)
            node[i].pos = node[i << 1].pos;
        else if(node[i].ms == node[i << 1].rs + node[i << 1| 1].ls)
            node[i].pos = mid - node[i << 1].rs + 1;
        else
            node[i].pos = node[i << 1 | 1].pos;
    }
} tree;


int main(){
    int n, q;
    scanf("%d %d", &n, &q);
    memset(tree.node, 0, sizeof(tree.node));
    tree.build(1, n, 1);
    int k, x, d;
    while(q--){
        scanf("%d", &k);
        if(k == 1){
            scanf("%d", &d);
            int res = tree.query(d, 1, n, 1);
            printf("%d\n", res);
            if(res)
                tree.change(res, res + d - 1, 1, n, 1, 1);
        }
        else{
            scanf("%d %d", &x, &d);
            tree.change(x, x + d - 1, 1, n, 1, 0);
        }

    }
    return 0;
}
```

 





