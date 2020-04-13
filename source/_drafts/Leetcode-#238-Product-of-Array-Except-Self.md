---
title: "Leetcode #238 Product of Array Except Self"
date: "2015-07-31T12:41:27+08:00"
categories:
tags:
---

                                            

Given an array of n integers where n > 1, <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">nums</code>,
 return an array <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">output</code> such that <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">output[i]</code> is
 equal to the product of all the elements of<code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">nums</code> except <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">nums[i]</code>.

Solve it without division and in O(n).

For example, given <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">[1,2,3,4]</code>, return <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">[24,12,8,6]</code>.

Follow up:

Could you solve it with constant space complexity? (Note: The output array does not count as extra space for the purpose of space complexity analysis.)


      题目很有意思，要求在不用除法的情况下时间复杂度仍为O（n），这确实需要动点脑筋。代码如下：
```cpp
class Solution {
  public:
    vector<int> productExceptSelf(vector<int>& nums) {
         vector<int>ret(nums.size());
         int temp = 1;
         for(int i = 0; i < nums.size(); i++){
            ret[i] = temp;
            temp *= nums[i];
         }
         temp = 1;
         for(int i = nums.size() - 1; i >= 0; i--){
             ret[i] *= temp;
             temp *= nums[i];
         }
         return ret;
    }
};
```
