---
title: "LeetCode #3 Longest Substring Without Repeating Characters"
date: "2015-03-22T20:27:20+08:00"
categories:
tags:
---

                                            
题目描述：

Given a string, find the length of the longest substring without repeating characters. For example, the longest substring without repeating letters for "abcabcbb" is "abc", which the length is 3. For "bbbbb" the longest substring is "b", with the length
 of 1.


这道题是看了大神的解法后写的。按一般的思路，依次从母串中的每一位开始扫描，求得各自能得到的最大子串长度，最后就能求得问题全局的的最大长度，需要两层循环，时间复杂度 o(n2)。但实际上，每次从头开始扫描时，重复了过去的不少工作，造成了时间浪费——这一点有点像模式匹配中的BF算法，而后者重复工作的缺点，是可以用KMP算法优化的。那么这个问题呢，我们是不是也能有相应的方法优化？


为了降低时间复杂度，我们可以只扫描母串，直接从母串中取出最长的无重复子串。
对于s[i]：
       如果s[i]没有在当前子串中出现过，那么子串的长度加1；
       如果s[i]在当前子串中出现过，那么就得到了当前子串所能达到的最大长度。此时我们又要考察新的子串了，假设s[j]出现位置的下标为j，那么新子串的起始位置必须大于j，为了使新子串尽可能的长，所以起始位置选为j+1。

代码如下：
Runtime: <strong>23 ms</strong>

```cpp
class Solution {
     public:
           int lengthOfLongestSubstring(string s) {
                if(s.empty()) return 0;

                int max = 0;
                int index = -1;

                int location[256];
                memset(location, 0xff, sizeof(location));

                for (int i = 0; i < s.size(); i++) {
                    if (location[s[i]] > index) {
                        index = location[s[i]];
                    }
                    if (i - index > max) {
                        max = i - index;
                    }
                    location[s[i]] = i;
                }
                return max;

           }
