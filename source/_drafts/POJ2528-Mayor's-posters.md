---
title: "POJ2528 Mayor's posters"
date: "2015-08-16T17:22:47+08:00"
categories:
tags:
---

                                            
URL:[http://poj.org/problem?id=2528](http://poj.org/problem?id=2528)

Description
The citizens of Bytetown, AB, could not stand that the candidates in the mayoral election campaign have been placing their electoral posters at all places at their whim. The city council has finally decided to build an electoral
 wall for placing the posters and introduce the following rules: 
<ul><li>Every candidate can place exactly one poster on the wall. 
</li><li>All posters are of the same height equal to the height of the wall; the width of a poster can be any integer number of bytes (byte is the unit of length in Bytetown).
</li><li>The wall is divided into segments and the width of each segment is one byte. 
</li><li>Each poster must completely cover a contiguous number of wall segments. </li></ul>

They have built a wall 10000000 bytes long (such that there is enough place for all candidates). When the electoral campaign was restarted, the candidates were placing their posters on the wall and their posters differed widely in width. Moreover, the candidates
 started placing their posters on wall segments already occupied by other posters. Everyone in Bytetown was curious whose posters will be visible (entirely or in part) on the last day before elections.

Your task is to find the number of visible posters when all the posters are placed given the information about posters' size, their place and order of placement on the electoral wall.

Input
The first line of input contains a number c giving the number of cases that follow. The first line of data for a single case contains number 1 <= n <= 10000. The subsequent n lines describe the posters in the order in which they
 were placed. The i-th line among the n lines contains two integer numbers l<sub>i</sub> and ri which are the number of the wall segment occupied by the left end and the right end of the i-th poster, respectively. We know that for each 1 <= i <= n, 1 <= l<sub>i</sub>
 <= ri <= 10000000. After the i-th poster is placed, it entirely covers all wall segments numbered l<sub>i</sub>, l<sub>i</sub>+1 ,... , ri.
Output
For each input data set print the number of visible posters after all the posters are placed.


The picture below illustrates the case of the sample input.
![](http://poj.org/images/2528_1.jpg)
Sample Input
1
5
1 4
2 6
8 10
3 4
7 10

Sample Output
4

        线段树子区间更新加离散化，很显然，对数据直接离散化显然是错的。如 [1, 5]、[1, 2]、[4, 5] 这类情况。
先放上来一个AC的代码，这个代码是按照《算法设计编程实验》的讲解写的，虽然AC了，但后来发现代码逻辑上还是不正确。
加上线段的中点的离散方法就是为了解决上面提到那种情况的错误，不过还是不能解决像 [1, 12]、[1, 2]、[4, 12]这种情况（此列中正确答案应该是3, 程序跑出结果却是2） 的错误。

```cpp
#include <algorithm>
#include <cstring>
#define maxn 10010
using namespace std;

struct interval_tree{
    bool tab[maxn];
    int n, l[maxn], r[maxn], x[maxn*3], num[maxn*3], node[maxn*12];

    int binary_search(int pos){
        int l = 1, r = 3 * n;
        while(r >= l){
            int mid = (l + r) >> 1;
            if(x[mid] <= pos) l = mid + 1;
            else r = mid - 1;
        }
        return num[r];
    }

    void update(int i){
        if(!node[i]) return;
        node[i << 1] = node[i << 1 | 1] = node[i];
        node[i] = 0;
    }

    void change(int tl, int tr, int l, int r, int i, int col){
        if(tr < l || tl > r) return;
        if(tl <= l && r <= tr){node[i] = col; return;}
        update(i);
        int mid = (l + r) >> 1;
        change(tl, tr, l, mid, i << 1, col);
        change(tl, tr, mid + 1, r, i << 1 | 1, col);
    }

    int require(int l, int r, int i){
        if(node[i]){
            if(!tab[node[i]]){
                tab[node[i]] = 1;
                return 1;
            }
            return 0;
        }
        if(l == r) return 0;
        int mid = (l + r) >> 1;
        return require(l, mid, i << 1) + require(mid + 1, r, i << 1 | 1);
    }

    void init(){
        scanf("%d\n", &n);
        for(int i = 1; i <= n; i ++){
            scanf("%d %d\n", l + i, r + i);
            x[i*3 - 2] = l[i]; x[i*3] = r[i]; x[i*3 - 1] = (l[i] + r[i]) >> 1;
        }
        sort(x + 1, x + 3*n + 1);
        memset(num, 0, sizeof(num));
        for(int i = 1; i <= 3*n; i ++){
            num[i] = num[i - 1];
            if(x[i] != x[i - 1]) num[i] ++;
        }

        for(int i = 1; i <= n; i++){
            l[i] = binary_search(l[i]);
            r[i] = binary_search(r[i]);
        }
    }

    void solve(){
        memset(node, 0, sizeof(node));
        for(int i = 1; i <= n; i++)
            change(l[i], r[i], 1, 3*n, 1, i);
        memset(tab, 0, sizeof(tab));
        printf("%d\n", require(1, 3*n, 1));
    }

} tree;

int main(){
    int t;
    scanf("%d\n", &t);
    while(t--){
        tree.init();
        tree.solve();
    }
    return 0;
}
```
下面是重新修改完善逻辑的代码，新的离散方法为：在相差大于1的数间加一个数。
如 [1, 12]、[1, 2]、[4, 12]中的 1 2 4 12 不再直接离散为 1 2 3 4，或加入中点离散为 1 2 3 6， 而是离散为 1 2 4 6。
代码提交上去，却WA了，个人认为是POJ的标程有问题。

```cpp
#include <cstdio>
#include <algorithm>
#include <cstring>
#define maxn 10010
using namespace std;

struct interval_tree{
    bool tab[maxn];
    int n, l[maxn], r[maxn], x[maxn*2], new_pos[maxn*2], node[maxn*12];

    int binary_search(int pos){
        int l = 1, r = 2 * n;
        while(r >= l){
            int mid = (l + r) >> 1;
            if(x[mid] <= pos) l = mid + 1;
            else r = mid - 1;
        }
        return new_pos[r];
    }

    void update(int i){
        if(!node[i]) return;
        node[i << 1] = node[i << 1 | 1] = node[i];
        node[i] = 0;
    }

    void change(int tl, int tr, int l, int r, int i, int col){
        if(tr < l || tl > r) return;
        if(tl <= l && r <= tr){node[i] = col; return;}
        update(i);
        int mid = (l + r) >> 1;
        change(tl, tr, l, mid, i << 1, col);
        change(tl, tr, mid + 1, r, i << 1 | 1, col);
    }

    int require(int l, int r, int i){
        if(node[i]){
            if(!tab[node[i]]){
                tab[node[i]] = 1;
                return 1;
            }
            return 0;
        }
        if(l == r) return 0;
        int mid = (l + r) >> 1;
        return require(l, mid, i << 1) + require(mid + 1, r, i << 1 | 1);
    }

    void init(){
        scanf("%d\n", &n);
        for(int i = 1; i <= n; i ++){
            scanf("%d %d\n", l + i, r + i);
            x[i * 2 - 1] = l[i]; x[i * 2] = r[i];
        }
        sort(x + 1, x + 2*n + 1);
        memset(new_pos, 0, sizeof(new_pos));
        new_pos[1] = 1;
        for(int i = 2; i <= 2*n; i ++){
            if(x[i] == x[i - 1]) new_pos[i] = new_pos[i -1];
            else if(x[i] > x[i - 1] + 1) new_pos[i] = new_pos[i - 1] + 2;
            else new_pos[i] = new_pos[i - 1] + 1;
        }
        for(int i = 1; i <= n; i++){
            l[i] = binary_search(l[i]);
            r[i] = binary_search(r[i]);
        }
    }

    void solve(){
        memset(node, 0, sizeof(node));
        for(int i = 1; i <= n; i++)
            change(l[i], r[i], 1, 3*n, 1, i);
        memset(tab, 0, sizeof(tab));
        printf("%d\n", require(1, 3*n, 1));
    }

} tree;

int main(){
    int t;
    scanf("%d\n", &t);
    while(t--){
        tree.init();
        tree.solve();
    }
    return 0;
}
```





