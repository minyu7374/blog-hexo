---
title: "leetcode #6 ZigZag Conversion"
date: "2015-05-17T21:50:14+08:00"
categories:
tags:
---

                                            
The string <code>"PAYPALISHIRING"</code> is written in a zigzag pattern on a given number of rows like this: (you may want to display this pattern in a fixed font for better legibility)
P   A   H   N
A P L S I I G
Y   I   R

And then read line by line: <code>"PAHNAPLSIIGYIR"</code>
Write the code that will take a string and make this conversion given a number of rows:
string convert(string text, int nRows);
<code>convert("PAYPALISHIRING", 3)</code> should return <code>"PAHNAPLSIIGYIR"</code>.
zigzag 循环对角线结构

```cpp
class Solution {
public:
    string convert(string s, int numRows) {
        if(numRows == 1) return s;
        
        string res[numRows];
        int i = 0, j;
        while(i < s.size()){
            for(j = 0; i < s.size() && j < numRows; ++j) res[j] += s[i++];
            for(j = numRows-2; i < s.size() && j > 0; --j) res[j] += s[i++];
        }
        
        string str = "";
        for(i = 0; i < numRows; ++i)
            str += res[i];
        return str;
    }
};
```
