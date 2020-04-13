---
title: "POJ1458 Common Subsequence"
date: "2014-07-14T20:54:14+08:00"
categories:
tags:
---

                                            
URL : [http://poj.org/problem?id=1458](http://poj.org/problem?id=1458)
      LCS 的水题，做另外一个动态规划题没思路，就找到了它放松下脑子，代码：
```cpp
#include <cstdio>
#include <iostream>
#include <string>
using namespace std;
int main(){
    string s1, s2;
    while(cin >> s1 >>s2){
         int m = s1.size(), n = s2.size();
         int LCS[m+1][n+1];
         for(int i = 0; i <= n; i++)
            LCS[0][i] = 0;
         for(int j = 0; j <= m; j++)
            LCS[j][0] = 0;
         for(int i = 1; i <= m; i++)
             for(int j = 1; j <= n; j++)
                 if(s1[i-1] == s2[j-1])
                     LCS[i][j] = LCS[i-1][j-1] + 1;
                 else
                     LCS[i][j] = LCS[i][j-1] > LCS[i-1][j] ? LCS[i][j-1] : LCS[i-1][j];
         printf("%d\n", LCS[m][n]);
    }
    return 0;
