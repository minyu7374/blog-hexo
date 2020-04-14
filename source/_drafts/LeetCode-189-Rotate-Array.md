---
title: "LeetCode #189 Rotate Array"
date: "2015-03-30T12:50:20+08:00"
categories:
tags:
---

                                            

Rotate an array of <em>n</em> elements to the right by <em>k</em> steps.
For example, with <em>n</em> = 7 and <em>k</em> = 3, the array <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">[1,2,3,4,5,6,7]</code> is
 rotated to <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">[5,6,7,1,2,3,4]</code>.
<strong style="font-weight:700;">Note:</strong>

Try to come up as many solutions as you can, there are at least 3 different ways to solve this problem.
<strong style="font-weight:700;">Hint:</strong>

Could you do it in-place with O(1) extra space?
题目很简单，不过要注意它可没说
 k 一定小于 n，因为开始没想到这一点，

第一次提交就RE了：

Submission Details

Status: Runtime Error

Last executed input:    [1,2,3,4,5,6], 11


O（1）空间复杂度的算法：

Runtime: <strong>11 ms</strong>
<strong></strong>```cpp
void reverse(int nums[], int s, int e){
    int temp;
    while(e - s > 0 ){
        temp = *(nums + s);
        *(nums + (s++))= *(nums + e);
        *(nums + (e--)) = temp;
    }
}

void rotate(int nums[], int n, int k){
     k = k % n;
     reverse(nums, n - k, n -1 );
     reverse(nums, 0, n - k - 1);
     reverse(nums, 0, n - 1);
}
```
