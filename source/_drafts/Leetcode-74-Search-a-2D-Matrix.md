---
title: "Leetcode #74 Search a 2D Matrix"
date: "2015-07-30T18:51:29+08:00"
categories:
tags:
---

                                            

Write an efficient algorithm that searches for a value in an <em>m</em> x <em>
n</em> matrix. This matrix has the following properties:

<ul><li>Integers in each row are sorted from left to right.</li><li>The first integer of each row is greater than the last integer of the previous row.</li></ul>For example,
Consider the following matrix:
[
  [1,   3,  5,  7],
  [10, 11, 16, 20],
  [23, 30, 34, 50]
]

Given <strong>target</strong> = <code>3</code>, return <code>true</code>.
      非常直接的二分查找问题，最直接的想法当然是先用二分查找找到target所在行，再从此行中找到target所在列，时间复杂度为 log m + log n 也就是log（m*n），但这样做，有点吃力不讨好的感觉，其实直接把矩阵看成一维数组，直接二分查找效率是一样的，可相对于前者，代码量轻易就减少了。

代码如下：


```cpp
class Solution {
public:
    int m, n;

    bool searchMatrix( vector<vector<int> >& matrix, int target) {
        m = matrix.size();
        n = matrix[0].size();
        return binary_search(matrix, 0, m * n - 1, target);
    }

    bool binary_search(vector< vector<int> >& array, int start, int end, int target){
        if (start > end) return false;
        int middle = (start + end) / 2;
        if (array[middle/n][middle%n] == target) return true;
        if (array[middle/n][middle%n] < target) return binary_search(array, middle + 1, end, target);
        return binary_search(array, start, middle - 1, target);
    }
