---
title: "uva10405 - Longest Common Subsequence"
date: "2014-07-15T14:56:07+08:00"
categories:
tags:
---

                                            
URL:[http://uva.onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=1346](http://uva.onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=1346)
水题，但略有小陷阱，测试数据中空格也算在字符串内。

```cpp
#include <cstdio>
#include <cstring>
using namespace std;
int LCS[1010][1010];
char a[1010], b[1010];

int main(){
    while(gets(a+1) && gets(b+1)){
        int la = strlen(a+1), lb = strlen(b+1);
        memset(LCS, 0, sizeof(LCS));
        for(int i = 1; i <= la; i++)
            for(int j = 1; j <= lb; j++)
                if(a[i] == b[j]) LCS[i][j] = LCS[i-1][j-1] + 1;
                else LCS[i][j] = LCS[i-1][j] > LCS[i][j-1] ? LCS[i-1][j] : LCS[i][j-1];
        printf("%d\n", LCS[la][lb]);


    }
    return 0;
}
```


