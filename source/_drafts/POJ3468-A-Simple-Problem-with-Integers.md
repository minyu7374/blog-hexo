---
title: "POJ3468 A Simple Problem with Integers"
date: "2015-08-16T12:33:40+08:00"
categories:
tags:
---

                                            

URL:[http://poj.org/problem?id=3468](http://poj.org/problem?id=3468)



Description

You have <em>N</em> integers, <em>A</em><sub>1</sub>, <em>A</em><sub>2</sub>, ... ,
<em>A<sub>N</sub></em>. You need to deal with two kinds of operations. One type of operation is to add some given number to each number in a given interval. The other is to ask for the sum of numbers in a given interval.

Input

The first line contains two numbers <em>N</em> and <em>Q</em>. 1 ≤ <em>N</em>,<em>Q</em> ≤ 100000.

The second line contains <em>N</em> numbers, the initial values of <em>A</em><sub>1</sub>,
<em>A</em><sub>2</sub>, ... , <em>A<sub>N</sub></em>. -1000000000 ≤ <em>A<sub>i</sub></em> ≤ 1000000000.

Each of the next <em>Q</em> lines represents an operation.

"C <em>a b c</em>" means adding <em>c</em> to each of <em>A<sub>a</sub></em>, <em>
A<sub>a</sub></em><sub>+1</sub>, ... , <em>A<sub>b</sub></em>. -10000 ≤ <em>c</em> ≤ 10000.

"Q <em>a b</em>" means querying the sum of <em>A<sub>a</sub></em>, <em>A<sub>a</sub></em><sub>+1</sub>, ... ,
<em>A<sub>b</sub></em>.

Output

You need to answer all <em>Q</em> commands in order. One answer in a line.

Sample Input
10 5
1 2 3 4 5 6 7 8 9 10
Q 4 4
Q 1 10
Q 2 4
C 3 6 3
Q 2 4

Sample Output
4
55
9
15
Hint
The sums may exceed the range of 32-bit integers.

 线段树子区间更新维护

```cpp
#include <cstdio>

struct interval_tree{
    int nums[100010];
    struct Node{
        long long mark, sum;
    } node[100010 << 2];

    void build(int l, int r, int i) {
        if (l == r) {node[i].sum = nums[l]; return;}
        int mid = (l + r) >> 1;
        build(l, mid, i << 1);
        build(mid + 1, r, i << 1 | 1);
        node[i].sum = node[i << 1].sum + node[i << 1 | 1].sum;
    }

    void update(int l, int r, int i) {
        if (!node[i].mark) return;
        int mid = (l + r) >> 1;
        node[i << 1].sum += node[i].mark * (mid - l + 1);
        node[i << 1].mark += node[i].mark;
        node[i << 1 | 1].sum += node[i].mark * (r - mid);
        node[i << 1 | 1].mark += node[i].mark;
        node[i].mark = 0;
    }

    void add(int tl, int tr, int l, int r, int i, int val) {
        if (tr < l || tl > r) return;
        if (tl <= l && r <= tr) {
            node[i].sum += (long long)val * (r -l + 1);
            node[i].mark += val;
            return;
        }
        update(l, r, i);
        int mid = (l + r) >> 1;
        add(tl, tr, l, mid, i << 1, val);
        add(tl, tr, mid + 1, r, i << 1 | 1, val);
        node[i].sum = node[i << 1].sum + node[i << 1 | 1].sum;
    }

    long long query(int tl, int tr, int l, int r, int i) {
        if (tr < l || tl > r) return 0;
        if (tl <= l && r <= tr) return node[i].sum;
        update(l, r, i);
        int mid = (l + r) >> 1;
        return query(tl, tr, l, mid, i << 1) + query(tl, tr, mid + 1, r, i << 1 | 1);
    }

} tree;

int main(){
    int n, q;
    scanf("%d %d", &n, &q);
    for (int i = 1; i <= n; i++)
        scanf("%d", tree.nums + i );
    getchar();
    tree.build(1, n, 1);

    while(q--) {
        int tl, tr, val; char c;
        scanf("%c", &c);
        if(c == 'Q'){
            scanf("%d %d\n", &tl, &tr);
            printf("%lld\n", tree.query(tl, tr, 1, n, 1));
        }
        else{
            scanf("%d %d %d\n", &tl, &tr, &val);
            tree.add(tl, tr, 1, n, 1, val);
        }
    }

    return 0;
}
```


