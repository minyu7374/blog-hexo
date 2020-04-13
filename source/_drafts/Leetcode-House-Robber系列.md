---
title: "Leetcode House Robber系列"
date: "2015-08-07T20:24:53+08:00"
categories:
tags:
---

                                            

 
# 
[Leetcode #198 House Robber](http://blog.csdn.net/u010129448/article/details/47344517)



You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed, the only constraint stopping you from robbing each of them is that adjacent houses have security system connected and it
 will automatically contact the police if two adjacent houses were broken into on the same night.

Given a list of non-negative integers representing the amount of money of each house, determine the maximum amount of money you can rob tonight without alerting the police.


```cpp
class Solution {
public:
    int rob(vector<int> &num) {
        int n = num.size();
        if(n == 0) return 0;
        if(n == 1) return num[0];

        vector<int> dp(n, 0);
        dp[0] = num[0];  dp[1] = max(num[0], num[1]);
        for(int i = 2; i < n; i ++)
            dp[i] = max(dp[i-2] + num[i], dp[i-1]);
        return dp[n-1];
    }
};
```


 
# 
[Leetcode #213 House Robber II](http://blog.csdn.net/u010129448/article/details/47344517)


# 

Note: This is an extension of [House Robber](https://leetcode.com/problems/house-robber/).

After robbing those houses on that street, the thief has found himself a new place for his thievery so that he will not get too much attention. This time, all houses at this place are arranged in a circle. That means the
 first house is the neighbor of the last one. Meanwhile, the security system for these houses remain the same as for those in the previous street.

Given a list of non-negative integers representing the amount of money of each house, determine the maximum amount of money you can rob tonight without alerting the police.



# 
[](http://blog.csdn.net/u010129448/article/details/47344517)```cpp
class Solution {
public:
    int rob(vector<int> &num) {
        int n = num.size();
        if(n == 0) return 0;
        if(n == 1) return num[0];
        if(n == 2) return max(num[0], num[1]);

        vector<int> dp(n, 0);
        
        dp[1] = num[1]; dp[2] = max(num[1], num[2]);
        for(int i = 3; i < n; i ++)
            dp[i] = max(dp[i-2] + num[i], dp[i-1]);
            
        int ans =  dp[n-1];
        
        dp[0] = num[0]; dp[1] = max(num[0], num[1]);
        for(int i = 2; i < n - 1; i ++)
            dp[i] = max(dp[i-2] + num[i], dp[i-1]);
            
        ans = max(ans, dp[n-2]);
        return ans;
    }
};
```









