---
title: "Leetcode #209 Minimum Size Subarray Sum"
date: "2015-08-07T10:38:01+08:00"
categories:
tags:
---

                                            
Given an array of <strong>n</strong> positive integers and a positive integer <strong>
s</strong>, find the minimal length of a subarray of which the sum ≥ <strong>s</strong>. If there isn't one, return 0 instead.
For example, given the array <code>[2,3,1,2,4,3]</code> and <code>s = 7</code>,

the subarray <code>[4,3]</code> has the minimal length under the problem constraint.


```cpp
class Solution {
public:
    int minSubArrayLen(int s, vector<int>& nums) {
        int sum  = 0, start = 0, end = 0, res = nums.size() + 1;
        while( end < nums.size() ) {

            while( sum < s && end < nums.size() ) {
                sum += nums[end++];
            }
            while(sum >= s && start <= end){
                res = min(res, end - start);
                sum -= nums[start++];
            }
        }
        return res == nums.size() + 1 ? 0 : res;
    }
