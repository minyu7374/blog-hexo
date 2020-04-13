---
title: "LeetCode Find Minimum in Rotated Sorted Array系列"
date: "2015-08-10T20:16:59+08:00"
categories:
tags:
---

                                            

#153 Find Minimum in Rotated Sorted Array


Suppose a sorted array is rotated at some pivot unknown to you beforehand.

(i.e., <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">0 1 2 4 5 6 7</code> might become <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">4
 5 6 7 0 1 2</code>).

Find the minimum element.

You may assume no duplicate exists in the array.




#154 Find Minimum in Rotated Sorted Array II



Follow up for "Find Minimum in Rotated Sorted Array":

What if duplicates are allowed?

Would this affect the run-time complexity? How and why? 

显然两道题有着同一个简单的解法：


```cpp
class Solution {
public:
    int findMin(vector<int>& nums) {
        for(int i = 1; i < nums.size(); i++)
            if(nums[i -1] > nums[i]) return nums[i];
        return nums[0];
    }
};
```当然这样效率较低，没有充分利用数组已排好序的信息，下面分别是两道题的二分查找解法:


#153 Find Minimum in Rotated Sorted Array



```cpp
class Solution { 
public: 
    int findMin(vector<int>& nums) { 
        int left = 0, right = nums.size() - 1; 
        while(left < right){ 
            int mid = (left + right) >> 1; 
            if(nums[mid] > nums[right])  left = mid + 1; 
            else right = mid; 
        } 
        return nums[left]; 
    } 
};
```


#154 Find Minimum in Rotated Sorted Array II

```cpp
class Solution { 
public: 
    int findMin(vector<int>& nums) { 
        int left = 0, right = nums.size() - 1; 
        while(left < right){ 
            int mid = (left + right) >> 1; 
            if(nums[mid] > nums[right])  left = mid + 1; 
            else right = mid; 
        } 
        return nums[left]; 
    } 
