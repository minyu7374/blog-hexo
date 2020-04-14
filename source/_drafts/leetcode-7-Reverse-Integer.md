---
title: "leetcode #7 Reverse Integer"
date: "2015-05-17T23:11:32+08:00"
categories:
tags:
---

                                            
Reverse digits of an integer.


Example1: x = 123, return 321

Example2: x = -123, return -321


click to show spoilers.


Have you thought about this?

Here are some good questions to ask before coding. Bonus points for you if you have already thought through this!


If the integer's last digit is 0, what should the output be? ie, cases such as 10, 100.


Did you notice that the reversed integer might overflow? Assume the input is a 32-bit integer, then the reverse of 1000000003 overflows. How should you handle such cases?


For the purpose of this problem, assume that your function returns 0 when the reversed integer overflows.


Update (2014-11-10):
Test cases had been added to test the overflow behavior.
代码里没用 long long型的 x1之前，结果是这样的：
![](https://img-blog.csdn.net/20150517231823701?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDEyOTQ0OA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
其实不用改成 long long ，单独对 -2147483648 处理也能过了


```cpp
class Solution {
public:
    int reverse(int x) {
        long long x1 = x;
        return x1 >= 0 ? ( reverse_z(x1) > 2147483647 ? 0 : (int) reverse_z(x1) ) : ( reverse_z(-x1) > 2147483648 ? 0 : (int)-reverse_z(-x1) );
    }

    long long reverse_z(long long x){
        long long result = 0;
        while(x){
            result = result * 10 + x % 10;
            x /= 10;
        }
        return result;
    }
};
```

