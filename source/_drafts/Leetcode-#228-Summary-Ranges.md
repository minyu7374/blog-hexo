---
title: "Leetcode #228 Summary Ranges"
date: "2015-08-01T21:48:03+08:00"
categories:
tags:
---

                                            
Given a sorted integer array without duplicates, return the summary of its ranges.
For example, given <code>[0,1,2,4,5,7]</code>, return <code>["0->2","4->5","7"].</code>
<strong>Credits:</strong>

Special thanks to [
@jianchao.li.fighter](https://leetcode.com/discuss/user/jianchao.li.fighter) for adding this problem and creating all test cases.



```cpp
class Solution { 
public: 
    vector<string> summaryRanges(vector<int>& nums) { 
        vector<string> result; 
        int start, index = 0; 
        while(index < nums.size()){ 
            start = nums[index]; 
            while(++index < nums.size() && nums[index] == nums[index - 1]  + 1); 
            if (start == nums[index - 1]) result.push_back(to_string(start)); 
            else result.push_back(to_string(start) + "->" + to_string(nums[index - 1])); 
        } 
        return result; 
    } 
};
```


