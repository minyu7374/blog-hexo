---
title: "SOJ1824: The Suspects"
date: "2014-07-15T20:51:08+08:00"
categories:
tags:
---

                                            
URL: [http://cstest.scu.edu.cn/soj/problem.action?id=1824](http://cstest.scu.edu.cn/soj/problem.action?id=1824)
 简单的并查集问题，代码：
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
                union_set(s,t);
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



