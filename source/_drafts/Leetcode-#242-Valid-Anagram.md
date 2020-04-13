---
title: "Leetcode  #242  Valid Anagram"
date: "2015-08-01T19:57:25+08:00"
categories:
tags:
---

                                            
Given two strings <em>s</em> and <em>t</em>, write a function to determine if <em>
t</em> is an anagram of <em>s</em>.
For example,
<em>s</em> = "anagram", <em>t</em> = "nagaram", return true.
<em>s</em> = "rat", <em>t</em> = "car", return false.
<strong>Note:</strong>

You may assume the string contains only lowercase alphabets.
一、直接统计各字母个数，12ms


```cpp
class Solution {
public:
    bool isAnagram(string s, string t) {
        int ss[26] = {}; int tt[26] = {};
        for(auto c : s) ss[c - 'a'] ++;
        for(auto c : t) tt[c - 'a'] ++;
        for(int i = 0; i < 26; i ++){
            if(tt[i] != ss[i]) return false;
        }
        return true;
    }
};
```

二、使用multiset 仅需一行代码，228ms


```cpp
      return multiset<char>(s.begin(), s.end()) == multiset<char>(t.begin(), t.end());

```
三、相对于1更简洁的写法，少开了一个数组，但耗时仍为12ms。
```cpp
class Solution {
public:
    bool isAnagram(string s, string t) {
        int cmp[26] = {};
        for(auto c : s) cmp[c - 'a']++;
        for(auto c : t) cmp[c - 'a']--;
        for(int i = 0; i < 26; i++)
            if(cmp[i]) return false;
        return true;
    }
};
```


一、三 代码改成c语言后，均是0ms。
```cpp
bool isAnagram(char* s, char* t) {
    int cmp[26] = {};
    while (*s) ++cmp[*s++ - 'a'];
    while (*t) --cmp[*t++ - 'a'];
    for (int i = 0; i < 26; i++)
        if (cmp[i])
            return false;
    return true;
}

```

