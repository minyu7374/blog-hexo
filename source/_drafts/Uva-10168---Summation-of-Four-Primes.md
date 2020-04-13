---
title: "Uva 10168 - Summation of Four Primes"
date: "2014-07-26T21:51:34+08:00"
categories:
tags:
---

                                            
URL: [
http://uva.onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=1109](http://uva.onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=1109)

Euler proved in one of his classic theorems that prime numbers are infinite in number. But can every number be expressed as a summation of four positive primes? I don’t know the answer. May be you can help!!! I want your solution
 to be very efficient as I have a 386 machine at home. But the time limit specified above is for a Pentium III 800 machine. The definition of prime number for this problem is “A prime number is a positive number which has exactly two distinct integer factors”.
 As for example 37 is prime as it has exactly two distinct integer factors 37 and 1.
<strong> </strong>
<strong>Input</strong>
The input contains one integer number <strong>N (N<=10000000)</strong> in every line. This is the number you will have to express as a summation of four primes. Input is terminated by end of file.
 
<strong>Output</strong>
For each line of input there is one line of output, which contains four prime numbers according to the given condition. If the number cannot be expressed as a summation of four prime numbers print the line <strong>“Impossible.”</strong> in
 a single line. There can be multiple solutions. Any good solution will be accepted.
<strong> </strong>
<strong>Sample Input:</strong>
24

36

46
<strong> </strong>
<strong>Sample Output:</strong>
3 11 3 7

3 7 13 13

11 11 17 7
```cpp
#include <cstdio>
#include <cstring>

bool u[10000010];
int su[5000010];

int main(){
    int i, j,n, num = 0;
    memset(u, true, sizeof(u));
	for(i = 2; i < 10000000; i++){
	    if(u[i]) su[num++] = i;
		for(j = 0; j < num; j++){
		    if( i * su[j] > 10000000)  break;
			u[ i*su[j] ] = false;
			if(i % su[j] == 0) break;
		}
	}
    while(~scanf("%d", &n) && n){
    	if(n < 8)  {printf("Impossible.\n"); continue;}
        if(n % 2 == 0){printf("2 2 "); n -= 4;}
        else {printf("2 3 "); n -= 5;}
        for(i = 0; i < num; i++)
        	if(u[ n-su[i] ]){
                printf("%d %d\n", su[i], n - su[i]);
                break;
        	}
	}
	return 0;
