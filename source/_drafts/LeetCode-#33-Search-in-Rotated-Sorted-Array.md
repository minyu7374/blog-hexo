---
title: "LeetCode #33 Search in Rotated Sorted Array"
date: "2015-08-14T16:31:12+08:00"
categories:
tags:
---

                                            
Suppose a sorted array is rotated at some pivot unknown to you beforehand.
(i.e., <code>0 1 2 4 5 6 7</code> might become <code>4 5 6 7 0 1 2</code>).
You are given a target value to search. If found in the array return its index, otherwise return -1.
You may assume no duplicate exists in the array.
```cpp
class Solution {
private:
    int find_rotate_index(vector<int>& nums) {
        int left = 0, right = nums.size() - 1;
        while(left < right){
            int mid = (left + right) >> 1;
            if(nums[mid] > nums[right])  left = mid + 1;
            else right = mid;
        }
        return left;
    }

public:
    int search(vector<int>& nums, int target) {
        int rotate_index = find_rotate_index(nums);
        int left, right, last_index = nums.size() - 1;
        if(target > nums[last_index]) {left = 0; right = rotate_index - 1;}
        else if(target < nums[last_index]) {left = rotate_index; right = last_index - 1;}
        else return last_index;

        while(left <= right){
            int mid = (left + right) >> 1;
            if(nums[mid] < target) left = mid + 1;
            else if(nums[mid] > target) right = mid - 1;
            else return mid;
        }
        return -1;
    }
};
```


