---
title: "leetcode #5 Longest Palindromic Substring"
date: "2015-05-17T12:15:44+08:00"
categories:
tags:
---

                                            
Given a string <em>S</em>, find the longest palindromic substring in <em>S</em>. You may assume that the maximum length of<em>S</em> is 1000, and there exists one unique longest palindromic substring.

```cpp
class Solution {
public:
    string longestPalindrome(string s) {
        int n = s.length();
        int longestBegin = 0;
        int maxLen = 1;
        bool table[1000][1000] = {false};
        for (int i = 0; i < n; i ++) {
            table[i][i] = true;
        }
        for (int i = 0; i < n - 1; i ++) {
            if (s[i] == s[i+1]) {
                table[i][i+1] = true;
                longestBegin = i;
                maxLen = 2;
            }
        }
  
        for (int len = 3; len <= n; len ++) {
            for (int i = 0; i < n - len +1; i ++) {
                int j = i+len-1;
                if (s[i] == s[j] && table[i+1][j-1]) {
                    table[i][j] = true;
                    longestBegin = i;
                    maxLen = len;
                }  
            }  
        }  
        return s.substr(longestBegin, maxLen);
    } 
}; 
```


