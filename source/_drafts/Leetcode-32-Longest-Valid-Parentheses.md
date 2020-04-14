---
title: "Leetcode #32 Longest Valid Parentheses"
date: "2015-08-14T12:50:45+08:00"
categories:
tags:
---

                                            
Given a string containing just the characters <code>'('</code> and <code>')'</code>, find the length of the longest valid (well-formed) parentheses substring.
For <code>"(()"</code>, the longest valid parentheses substring is <code>"()"</code>, which has length = 2.
Another example is <code>")()())"</code>, where the longest valid parentheses substring is
<code>"()()"</code>, which has length = 4.


```cpp
class Solution {
public:
    int longestValidParentheses(string s) {
        int n = s.size(), res = 0;
        vector<int> dp(n, 0);

        for (int i = 0; i < n; i++) {
            if (s[i] == ')' && i - 1 >= 0) {
                if (s[i - 1] == '(')
                    dp[i] = i >= 2 ? 2 + dp[i - 2] : 2;
                else if(i-1 - dp[i-1] >= 0 && s[i-1 - dp[i-1]] == '(')
                    dp[i] = dp[i-1] + 2 + (i-1 - dp[i -1] -1 >= 0 ? dp[i-1 - dp[i -1] -1] : 0);
                res = max(res, dp[i]);
            }
        }
        return res;
    }
