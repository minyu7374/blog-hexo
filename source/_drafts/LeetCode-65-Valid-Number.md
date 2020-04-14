---
title: "LeetCode #65 Valid Number"
date: "2015-08-02T20:06:29+08:00"
categories:
tags:
---

                                            
Validate if a given string is numeric.
Some examples:
<code>"0"</code> => <code>true</code>
<code>" 0.1 "</code> => <code>true</code>
<code>"abc"</code> => <code>false</code>
<code>"1 a"</code> => <code>false</code>
<code>"2e10"</code> => <code>true</code>

<strong>Note:</strong> It is intended for the problem statement to be ambiguous. You should gather all requirements up front before implementing one.
        leetcode将本题的 Difficulty 定义为Hard，其实本题在Leetcode中并不能称上是难题，但本题确实需要注意很多细节，所以代码很容易出错。顺便说下，直到现在，本题在leetcode上的通过率也还是最低的(如下)。
![](https://img-blog.csdn.net/20150802192225766?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
```cpp
<pre name="code" class="cpp">class Solution {
public:
    bool isNumber(string s) {

        if(s.size() == 0) return false;

        int index = 0, num_cnt = 0, dot_cnt = 0;

        while(s[index] == ' ') index++;

        if(s[index] == '+' || s[index] == '-') index++;

        while(isdigit(s[index]) || s[index] == '.') s[index++] == '.' ? dot_cnt++ : num_cnt++;

        if(dot_cnt > 1 || num_cnt < 1) return false;

        if(s[index] == 'e'){
            index++; num_cnt = 0; dot_cnt = 0;
            if(s[index] == '+' || s[index] == '-') index++;
            while(isdigit(s[index]) || s[index] == '.') s[index++] == '.' ? dot_cnt++ : num_cnt++;
            if(dot_cnt > 0 || num_cnt < 1) return false;
        }

        while(index < s.size()){
            if(s[index++] != ' ') return false;
        }
        return true;
    }
};
```


