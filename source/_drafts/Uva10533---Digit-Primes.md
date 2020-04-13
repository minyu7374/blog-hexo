---
title: "Uva10533 - Digit Primes"
date: "2014-07-26T22:25:02+08:00"
categories:
tags:
---

                                            
A prime number is a positive number, which is divisible by exactly two different integers. A digit prime is a prime number whose sum of digits is also prime. For example the prime number <strong>41</strong> is
 a digit prime because <strong>4+1=5</strong> and <strong>5</strong> is a prime number. <strong>17</strong> is not a digit prime because <strong>1+7 = 8</strong>, and <strong>8</strong> is not a prime number. In this problem your job is to find out the number
 of digit primes within a certain range less than <strong>1000000</strong>.
 
Input
First line of the input file contains a single integer <strong>N (0<N<=500000) </strong>that indicates the total number of inputs. Each of the next <strong>N</strong> lines contains two integers <strong>t1</strong> and <strong>t2 (0<t1<=t2<1000000).</strong>
 
Output
# For each line of input except the first line produce one line of output containing a single integer that indicates the number of digit primes betweent1 and t2 (inclusive).

# <strong>Sample Input</strong>


 3
10 20
10 100
100 10000

# <strong>Sample Output</strong>

1
10
576
```cpp
#include <cstdio>
#include <cstring>

bool u[1000010];
int su[500010];
int uu[1000010];

bool ok(int x){
    int t = 0;
    while(x){
        t += x % 10;
        x /= 10;
    }
    return u[t];
} 

int main(){
    int i, j, k, n, num = 0;

    memset(u, true, sizeof(u));
	for(i = 2; i < 1000000; i++){
	    if(u[i]) su[num++] = i;
		for(j = 0; j < num; j++){
		    if( i * su[j] > 1000000)  break;
			u[ i*su[j] ] = false;
			if(i % su[j] == 0) break;
		}
	}

    memset(uu, 0, sizeof(uu));
    for(i = 2; i < 1000000; i++)
        if(u[i] && ok(i)) uu[i] = 1;
    for(i = 2; i < 1000000; i++)
        uu[i] += uu[i-1];
    scanf("%d", &k);
    while(k--){
         scanf("%d %d", &i, &j);
         printf("%d\n", uu[j] - uu[i-1]);
    }
    return 0;
}
```








