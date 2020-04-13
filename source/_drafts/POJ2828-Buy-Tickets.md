---
title: "POJ2828 Buy Tickets"
date: "2014-07-16T16:27:34+08:00"
categories:
tags:
---

                                            
URL: [http://poj.org/problem?id=2828](http://poj.org/problem?id=2828)

Description

<em>Railway tickets were difficult to buy around the Lunar New Year in China, so we must get up early and join a long queue…</em>
The Lunar New Year was approaching, but unluckily the Little Cat still had schedules going here and there. Now, he had to travel by train to Mianyang, Sichuan Province for the winter camp selection of the national team of Olympiad in Informatics.
It was one o’clock a.m. and dark outside. Chill wind from the northwest did not scare off the people in the queue. The cold night gave the Little Cat a shiver. Why not find a problem to think about? That was none the less better than freezing to death!
People kept jumping the queue. Since it was too dark around, such moves would not be discovered even by the people adjacent to the queue-jumpers. “If every person in the queue is assigned an integral value and all the information about those who have jumped
 the queue and where they stand after queue-jumping is given, can I find out the final order of people in the queue?” Thought the Little Cat.

Input

There will be several test cases in the input. Each test case consists of <em>
N</em> + 1 lines where <em>N</em> (1 ≤ <em>N</em> ≤ 200,000) is given in the first line of the test case. The next
<em>N</em> lines contain the pairs of values <em>Pos<sub>i</sub></em> and <em>Val<sub>i</sub></em> in the increasing order of
<em>i</em> (1 ≤ <em>i</em> ≤ <em>N</em>). For each <em>i</em>, the ranges and meanings of
<em>Pos<sub>i</sub></em> and <em>Val<sub>i</sub></em> are as follows:
<ul><li><em>Pos<sub>i</sub></em> ∈ [0, <em>i</em> − 1] — The <em>i</em>-th person came to the queue and stood right behind the
<em>Pos<sub>i</sub></em>-th person in the queue. The booking office was considered the 0th person and the person at the front of the queue was considered the first person in the queue.</li><li><em>Val<sub>i</sub></em> ∈ [0, 32767] — The <em>i</em>-th person was assigned the value
<em>Val<sub>i</sub></em>.</li></ul>There no blank lines between test cases. Proceed to the end of input.

Output

For each test cases, output a single line of space-separated integers which are the values of people in the order they stand in the queue.

Sample Input
4
0 77
1 51
1 33
2 69
4
0 20523
1 19243
1 3890
0 31492
Sample Output
77 33 69 51
31492 20523 3890 19243
       这个题目用线段树是需要换个思维的，我们不能按照题目中的输入顺序依次处理数据——因为后面的人插入时可能会让前面的人后移，使得已确定过的位置发生改变。所以我们要从后向前处理数据，这样就可以保证每次插入的位置在之后的插入过程中不再发生改变。
      用线段树的每个节点记录这一段的空位置数，从第n个人开始，每次插入时把第 i 个人插入到第pos[i]+ 1个空位置，在查找插入位置的过程中更新相关节点所记录的空位置数。这样做是很合理的，因为前面人的位置被后面的人占据之后，他的位置就要向后移一格，这一点恰好对应于后面的人先插入使得他所占据的位置的空位置从原来的第k+1个空位置变为第k个。
       代码：
```cpp
#include <cstdio>
#define maxn 200010
#define lson id << 1
#define rson id << 1 | 1

struct interval_tree{
    int s, e, len;
}t[maxn << 2];
int n, ans[maxn], person[maxn][2];

void build_tree(int l, int r, int id){
    t[id].s = l, t[id].e = r, t[id].len = r-l+1;
    if(l == r)  return;
    int mid = (l+r) >> 1;
    build_tree(l, mid, lson);
    build_tree(mid + 1, r, rson);
}

int query_tree(int id, int pos){
    t[id].len--;
    if(t[id].s == t[id].e) 
        return t[id].s;
    if(pos <= t[lson].len) 
        return query_tree(lson, pos);
    else return query_tree(rson, pos - t[lson].len);
}

int main(){
    while(~scanf("%d", &n)){
        for(int i = 1; i <= n; i++) 
        	scanf("%d %d", &person[i][0], &person[i][1]);
        build_tree(1, n, 1);
        for(int i = n; i > 0; i--) 
        	ans[ query_tree(1, person[i][0]+1) ] = person[i][1];
        for(int i = 1; i < n; i++)
            printf("%d ", ans[i]);
        printf("%d\n", ans[n]);
    }
    return 0;
}
```

[](http://poj.org/problem?id=2828)
