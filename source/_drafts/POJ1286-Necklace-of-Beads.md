---
title: "POJ1286  Necklace of Beads"
date: "2014-06-22T23:56:29+08:00"
categories:
tags:
---

                                            
Description
Beads of red, blue or green colors are connected together into a circular necklace of n beads ( n < 24 ). If the repetitions that are produced by rotation around the center of the circular necklace or reflection to the axis of
 symmetry are all neglected, how many different forms of the necklace are there? 
<center>![](http://poj.org/images/1286_1.jpg)</center>


Input
The input has several lines, and each line contains the input data n.

-1 denotes the end of the input file. 

Output
The output should contain the output data: Number of different forms, in each line correspondent to the input data.
Sample Input
4
5
-1

Sample Output
21
39



polya计数定理的应用（学算法，离散数学的知识很重要），代码如下：
```cpp
#include <cstdio>

int gcd(int a, int b){
    return ( b ? gcd(b, a%b) : a );
}

long long ex(int n){
    long long r = 1;
    while(n--)
         r *= 3;
    return r;
}

int main(){
    int n; long long ans;
    while(~scanf("%d", &n) && (n+1)){
        if(!n){
            printf("0\n");continue;
        }
        ans = 0;
        for(int i = 0; i < n; i++)
            ans += ex(gcd(n,i));
        if(n & 1) 
            ans += ex(n/2 + 1) * n;
        else
            ans += (ex(n/2) + ex(n/2 + 1) )* n/2;
        printf("%lld\n", ans/2/n);
    }
    return 0;
}
```
