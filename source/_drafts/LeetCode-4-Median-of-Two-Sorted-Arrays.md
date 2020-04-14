---
title: "LeetCode #4 Median of Two Sorted Arrays"
date: "2015-03-22T23:12:34+08:00"
categories:
tags:
---

                                            
题目描述：

There are two sorted arrays A and B of size m and n respectively. Find the median of the two sorted arrays. The overall run time complexity should be O(log (m+n)).


很经典的题， O(log (m+n))的时间复杂度，确实很难想，看了大神的解法，有点快排的思想，代码如下：


Runtime: <strong>17 ms</strong>


```cpp
double find_K(int A[], int m , int B[], int n, int k){
    if(m > n)   return find_K(B, n, A, m, k);
    if(m == 0)  return B[k-1];
    if(k == 1)  return A[0] < B[0] ? A[0] : B[0];
    int a = k / 2 < m ? k / 2 : m, b = k - a;

    if(A[a - 1] < B[b - 1])
        return find_K(A + a, m - a, B, n, b);
    else if (A[a - 1] > B[b - 1])
        return find_K(A, m, B + b, n - b, a);
    else
        return A[a - 1];

}

double findMedianSortedArrays(int A[], int m, int B[], int n){
      int mn = m + n;
      if (mn % 2 == 1)
          return find_K(A, m, B, n, mn / 2 + 1);
      else
          return (find_K(A, m, B, n, mn / 2)  + find_K(A, m, B, n, mn / 2 + 1)) / 2;
