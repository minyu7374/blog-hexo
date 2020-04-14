---
title: "leetcode #8 String to Integer (atoi)"
date: "2015-05-18T22:33:59+08:00"
categories:
tags:
---

                                            

Implement atoi to convert a string to an integer.
<strong>Hint:</strong> Carefully consider all possible input cases. If you want a challenge, please do not see below and ask yourself what are the possible input cases.
<strong>Notes:</strong> It is intended for this problem to be specified vaguely (ie, no given input specs). You are responsible to gather all the input requirements up front.

<strong>Update (2015-02-10):</strong>

The signature of the <code>C++</code> function had been updated. If you still see your function signature accepts a
<code>const char *</code> argument, please click the reload button 
to reset your code definition.
[spoilers alert... click to show requirements for atoi.](https://leetcode.com/problems/string-to-integer-atoi/#)
<strong>Requirements for atoi:</strong>
The function first discards as many whitespace characters as necessary until the first non-whitespace character is found. Then, starting from this character, takes an optional initial plus or minus sign followed by as many numerical digits as possible, and
 interprets them as a numerical value.
The string can contain additional characters after those that form the integral number, which are ignored and have no effect on the behavior of this function.
If the first sequence of non-whitespace characters in str is not a valid integral number, or if no such sequence exists because either str is empty or it contains only whitespace characters, no conversion is performed.
If no valid conversion could be performed, a zero value is returned. If the correct value is out of the range of representable values, INT_MAX (2147483647) or INT_MIN (-2147483648) is returned.
开始没考虑到数据可能会超出long long 的范围，WA了:![](https://img-blog.csdn.net/20150518224323831?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDEyOTQ0OA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
有问题的代码：

```cpp
int myAtoi(char* str) {
    if(str == NULL) return 0;
    while (*str == ' ')
        str++;
    int sign = 1;
    if(*str == '-'){
        sign = -1; str++;
    }
    else if(*str == '+')
        str++;

    long long ret = 0;

    while (*str >= '0' && *str <= '9'){
        ret = ret * 10 + *str - '0';
        str++; 
    }
   
    ret *= sign;
    if(ret > INT_MAX)
        return INT_MAX;
    if(ret < INT_MIN)
        return INT_MIN;
    return (int)ret;
}
```

修正后的代码：

```cpp
int myAtoi(char* str) {
    if(str == NULL) return 0;
    while (*str == ' ')
        str++;
    int sign = 1;
    if(*str == '-'){
        sign = -1; str++;
    }
    else if(*str == '+')
        str++;
    long long ret = 0;
    while (*str >= '0' && *str <= '9'){
        ret = ret * 10 + *str - '0';
        if(ret > INT_MAX)
            return sign < 0 ? INT_MIN : INT_MAX;
        str++; 
    }
    ret *= sign;
    return (int)ret;
