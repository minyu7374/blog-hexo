---
title: "Leetcode Majority Element系列 摩尔投票法"
date: "2015-08-01T18:59:36+08:00"
categories:
tags:
---

                                            
<strong>leetcode #169 Majority Element</strong>

Given an array of size <em>n</em>, find the majority element. The majority element is the element that appears more than
<code>⌊ n/2 ⌋</code> times.
You may assume that the array is non-empty and the majority element always exist in the array.
```cpp
class Solution{
public:
    int majorityElement(vector<int>& nums) {

        int ans, cnt = 0;

        for(int n: nums){

            if (cnt == 0 || n == ans){
                cnt++; ans = n;
            }
            else
                cnt--;
        }
        return ans;
    }
};
```
<strong>leetcode #229 Majority Element II</strong>
Given an integer array of size <em>n</em>, find all elements that appear more than<code>⌊ n/3 ⌋</code> times. The algorithm should run in linear time and in O(1) space.

```cpp
public:
    vector<int> majorityElement(vector<int>& nums) {

        int cnt1 = 0, cnt2 = 0;
        int a, b;

        for(int n: nums){

            if (cnt1 == 0 || n == a){
                cnt1++; a = n;
            }
            else if (cnt2 == 0 || n == b){
                cnt2++; b = n;
            }
            else{
                cnt1--; cnt2--;
            }
        }

        cnt1 = cnt2 = 0;
        for(int n: nums){
            if (n == a)   cnt1++;
            else if (n == b) cnt2++;
        }

        vector<int> result;
        if (cnt1 > nums.size()/3)   result.push_back(a);
        if (cnt2 > nums.size()/3)   result.push_back(b);
        return result;
    }
};
```


