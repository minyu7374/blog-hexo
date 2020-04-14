---
title: "LeetCode #187	Repeated DNA Sequences"
date: "2015-05-17T00:08:04+08:00"
categories:
tags:
---

                                            


All DNA is composed of a series of nucleotides abbreviated as A, C, G, and T, for example: "ACGAATTCCG". When studying DNA, it is sometimes useful to identify repeated sequences within the DNA.

Write a function to find all the 10-letter-long sequences (substrings) that occur more than once in a DNA molecule.

For example,
Given s = "AAAAACCCCCAAAAACCCCCCAAAAAGGGTTT",

Return:
["AAAAACCCCC", "CCCCCAAAAA"].
利用( s[i] - 'A' + 1 ) % 5 )可把A,C,G,T,转换为1,3,2,0 这样每个字符可用两个二进制位来存储，共20位

```cpp
class Solution {
public:
    vector<string> findRepeatedDnaSequences(string s) {
        vector<string> result;
        unordered_map<int,int> seq_map;
        unordered_map<int,int>::iterator it;
        int t;

        for (int i = 0; i < s.size(); i++) {
            t = ( (t<<2) & 0xfffff) | ( ( s[i] - 'A' + 1 ) % 5 );
            if (i < 9)  continue;
            it = seq_map.find(t);
            if (it == seq_map.end())
                seq_map[t] = 1;
            else if (++seq_map[t] == 2)
                result.push_back(s.substr(i - 9, 10));
        }
        return result;
    }
