---
title: "poj 2262 Goldbach's Conjecture 素数筛"
date: "2014-07-26T21:16:03+08:00"
categories:
tags:
---

                                            
Description
In 1742, Christian Goldbach, a German amateur mathematician, sent a letter to Leonhard Euler in which he made the following conjecture:

<blockquote>Every even number greater than 4 can be

written as the sum of two odd prime numbers. </blockquote>


For example: 
<blockquote>8 = 3 + 5. Both 3 and 5 are odd prime numbers. 

20 = 3 + 17 = 7 + 13. 

42 = 5 + 37 = 11 + 31 = 13 + 29 = 19 + 23. </blockquote>


Today it is still unproven whether the conjecture is right. (Oh wait, I have the proof of course, but it is too long to write it on the margin of this page.)


Anyway, your task is now to verify Goldbach's conjecture for all even numbers less than a million.

Input
The input will contain one or more test cases. 

Each test case consists of one even integer n with 6 <= n < 1000000. 

Input will be terminated by a value of 0 for n. 
Output
For each test case, print one line of the form n = a + b, where a and b are odd primes. Numbers and operators should be separated by exactly one blank like in the sample output below. If there is more than one pair of odd primes
 adding up to n, choose the pair where the difference b - a is maximized. If there is no such pair, print a line saying "Goldbach's conjecture is wrong."

Sample Input
8
20
42
0

Sample Output
8 = 3 + 5
20 = 3 + 17
42 = 5 + 37



        最近做网络流的题不太顺，就找个水题练练手，先利用欧拉筛算法离线计算出2到1000000之间的素数并从小到大存入数组，每次输入一个偶数，再从数组里搜索满足条件的素数对。
 ```cpp
#include <cstdio>
#include <cstring>

bool u[1000010];
int su[1000010];

int main(){
    int i, j,n, num = 0;
    memset(u, true, sizeof(u));
	for(i = 2; i < 1000000; i++){
	    if(u[i]) su[num++] = i;
		for(j = 0; j < num; j++){
		    if( i * su[j] > 1000000)  break;
			u[ i*su[j] ] = false;
			if(i % su[j] == 0) break;
		}
	}
    while(~scanf("%d", &n) && n){
	    bool flag = false;
		for(i = 0; i < num; i++){
		    if(su[i] * 2 > n)  break;
			if(u[ n-su[i] ]){
			    flag = true; break;
			}
		}
	    if(flag) printf("%d = %d + %d\n", n, su[i], n - su[i] );
		else  printf("Goldbach's conjecture is wrong.\n");
	}
	return 0;
}
```



