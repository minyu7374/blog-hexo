---
title: "LeetCode #214 Shortest Palindrome"
date: "2015-08-07T19:57:41+08:00"
categories:
tags:
---

                                            

Given a string S, you are allowed to convert it to a palindrome by adding characters in front of it. Find and return the shortest palindrome you can find by performing this transformation.

For example:

Given <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">"aacecaaa"</code>, return <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">"aaacecaaa"</code>.

Given <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">"abcd"</code>, return <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">"dcbabcd"</code>.
下面的代码是从Discuss中看到的，借用BM算法的思想，效率很高。
```cpp
class Solution {
public:
    string shortestPalindrome(string s) {
        int n = s.length();
        if (n < 2) return s;

        string rs = s;
        reverse(rs.begin(), rs.end());

        int right[26];
        for (int i = 0; i < n; i++)  right[s[i] - 'a'] = i;

        int i = 0, j, tmp;
        while (i < n) {
            for (j = n - 1 - i; j >= 0; j--) {
                if (s[j] != rs[i + j]) {
                    tmp = j - right[rs[i + j] - 'a'];
                    if (tmp <= 0) {
                        tmp = i + j + 1;
                        while (tmp < n && rs[tmp] != s[j]) tmp++;
                        tmp = tmp - i - j;
                    }
                    i += tmp;
                    break;
                }
            }
            if (j < 0)  return rs.substr(0, i) + s;
        }
        return rs.substr(0, n - 1) + s;
    }
