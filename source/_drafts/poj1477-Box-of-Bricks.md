---
title: "poj1477 Box of Bricks"
date: "2014-06-20T17:54:41+08:00"
categories:
tags:
---

                                            
      在OJ题目分类里找到的题， 稍微有点贪心的思想。

```cpp
#include <stdio.h>
int n, s, ans, cases, wall[110];
int main(){
    cases = 0;
    while(~scanf("%d", &n) && n){
        s = 0; ans = 0; cases ++;
        for(int i = 0; i < n; i++){
            scanf("%d", wall + i);
            s += wall[i];
        }
        s /= n;
        for(int i = 0; i < n; i++)
            if(wall[i] > s)
                ans += wall[i]-s;
        printf("Set #%d\nThe minimum number of moves is %d.\n\n", cases,ans);
   }
   return 0;
}
```


    

