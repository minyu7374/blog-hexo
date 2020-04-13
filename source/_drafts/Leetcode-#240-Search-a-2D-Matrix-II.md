---
title: "Leetcode #240 Search a 2D Matrix II"
date: "2015-07-30T20:00:59+08:00"
categories:
tags:
---

                                            
Write an efficient algorithm that searches for a value in an <em>m</em> x <em>
n</em> matrix. This matrix has the following properties:

<ul><li>Integers in each row are sorted in ascending from left to right.</li><li>Integers in each column are sorted in ascending from top to bottom.</li></ul>For example,
Consider the following matrix:
[
  [1,   4,  7, 11, 15],
  [2,   5,  8, 12, 19],
  [3,   6,  9, 16, 22],
  [10, 13, 14, 17, 24],
  [18, 21, 23, 26, 30]
]

Given <strong>target</strong> = <code>5</code>, return <code>true</code>.
Given <strong>target</strong> = <code>20</code>, return <code>false</code>.


本题思路很有意思：
        从右上角（行数为0，列数为总列长 - 1）开始查找，如果该数大于target，则target不可能在该列，列数 减 1；如果该数大于target，则target不可能在该行，行数加1。当行列值超出范围时，说明矩阵中不含target。
        代码时间复杂度为 m+n。

```cpp
class Solution {
public:
    bool searchMatrix( vector<vector<int> >& matrix, int target) {
        int row = matrix.size(), col = matrix[0].size();
        int i = 0, j = col - 1;
        while(i < row && j >= 0){
            if(target == matrix[i][j]) return true;
            else if(target < matrix[i][j]) j--;
            else i++;
        }
        return false;
    }
