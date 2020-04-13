---
title: "POJ1716  Integer Intervals"
date: "2014-07-13T22:27:14+08:00"
categories:
tags:
---

                                            
URL: [http://poj.org/problem?id=1716](http://poj.org/problem?id=1716)

Description
An integer interval [a,b], a < b, is a set of all consecutive integers beginning with a and ending with b.


Write a program that: finds the minimal number of elements in a set containing at least two different integers from each interval.
Input
The first line of the input contains the number of intervals n, 1 <= n <= 10000. Each of the following n lines contains two integers a, b separated by a single space, 0 <= a < b <= 10000. They are the beginning and the end of an
 interval. 
Output
Output the minimal number of elements in a set containing at least two different integers from each interval.

Sample Input
4
3 6
2 4
0 2
4 7

Sample Output
4



      各区间以未尾元素的大小排序；求解过程中，若某个区间内包含已选出整数的个数不足两个，则要又要选出新的整数，此时选取该区间最靠后的元素，这样能尽量使后面的区间在包含最大程度上包含新选的整数。
       代码如下：
```cpp
#include <cstdio>
#include <algorithm>
struct interval{
    int a;
    int b;
};
bool cmp(interval x,interval y){
    return x.b < y.b;
}
int main(){
    int n, s, e, ans;
    scanf("%d", &n); 
    interval v[n];
    for(int i = 0; i < n; i++)
         scanf("%d %d", &v[i].a, &v[i].b);
    std::sort(v, v + n, cmp);
    e = v[0].b; s = e - 1; ans = 2;
    for(int i = 1; i < n; i++){
        if(e < v[i].a){
            ans += 2; e = v[i].b; s = e-1;
        }
        else if(s < v[i].a){
            ans += 1; s = e; e = v[i].b;
       }
    }
    printf("%d\n", ans);
    return 0;
