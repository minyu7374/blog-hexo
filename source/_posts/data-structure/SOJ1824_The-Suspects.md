---
title: "SOJ1824 The Suspects"
date: "2014-07-15T20:51:08+08:00"
categories:
- [Data Structure, 并查集]
- [ACM, SOJ]
tags:
- ACM
- SOJ
- 并查集
---

> URL: [SOJ1824](http://cstest.scu.edu.cn/soj/problem.action?id=1824)

## Description

Severe acute respiratory syndrome (SARS), an atypical pneumonia of unknown aetiology, was recognized as a global threat in mid-March 2003. To minimize transmission to others, the best strategy is to separate the suspects from others.

In the Not-Spreading-Your-Sickness University (NSYSU), there are many student groups. Students in the same group intercommunicate with each other frequently, and a student may join several groups. To prevent the possible transmissions of SARS, the NSYSU collects the member lists of all student groups, and makes the following rule in their standard operation procedure (SOP).

Once a member in a group is a suspect, all members in the group are suspects.

However, they find that it is not easy to identify all the suspects when a student is recognized as a suspect. Your job is to write a program which finds all the suspects.
<!-- more -->

## Input

The input contains several cases. Each test case begins with two integers n and m in a line, where n is the number of students, and m is the number of groups. You may assume that `0 < n <= 30000` and `0 <= m <= 500`. Every student is numbered by a unique integer between `0` and `n-1`, and initially student 0 is recognized as a suspect in all the cases. This line is followed by m member lists of the groups, one line per group. Each line begins with an integer k by itself representing the number of members in the group. Following the number of members, there are k integers representing the students in this group. All the integers in a line are separated by at least one space.

A case with `n = 0` and `m = 0` indicates the end of the input, and need not be processed.

## Output

For each case, output the number of suspects in one line.

## Sample Input

```
100 4
2 1 2
5 10 13 11 12 14
2 0 1
2 99 2
200 2
1 5
5 1 2 3 4 5
1 0
0 0
```


## Sample Output

```
4
1
1
```

## 参考代码

```cpp
#include <cstdio>
#include <cstring>
int set[30010];

int find_set(int x){
    return set[x] == x ? x : ( set[x] = find_set(set[x]) );
}

void union_set(int x, int y){
    if( (x = find_set(x)) != (y = find_set(y)) )
       set[x] = y;
}

int main(){
    int n, m, k, t, s, fa, ans;
    while(~scanf("%d %d", &n, &m) && (m || n)){
        for(int i = 0; i < n; i++)
            set[i] = i;
        while(m--){
            scanf("%d %d", &k, &s); k--;
            while(k--){
                scanf("%d", &t);
                union_set(s, t);
            }
        }
        fa = find_set(0); ans = 0;
        for(int i = 0; i < n; i++)
            if(find_set(i) == fa)
                 ans++;
        printf("%d\n", ans);
    }
    return 0;
}
```
