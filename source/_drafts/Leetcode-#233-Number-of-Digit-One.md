---
title: "Leetcode #233 Number of Digit One"
date: "2015-08-01T14:23:27+08:00"
categories:
tags:
---

                                            
Given an integer n, count the total number of digit 1 appearing in all non-negative integers less than or equal to n.
For example:



Given n = 13,

Return 6, because digit 1 occurred in the following numbers: 1, 10, 11, 12, 13.



显然，每  10 ^ n  个数，在 10 ^ (n-1)  位上要有 10  ^ (n-1) 个 1（从0 开始数），因此，一位一位的计算会比较简单。
计算过程中注意区分以下三类情况：

         1、 n在要计算的那一位上对应的数字为 0，如 2034 = 2 * 1000 + 34， 则在2000之前百位上有200个 1；

         2 、n在要计算的那一位上对应的数字为 1，如 2134 = 2 * 1000 + 134， 则除在2000之前百位上已有200个 1外， 后面从2100 到2 134之间又有 34 + 1 = 35 个 百位上的1；
         3、 n在要计算的那一位上对应的数字 >=2,  如 2334 = 2 * 1000 + 334，  则除在2000之前百位上已有200个 1外， 后面从2100 到2 199之间又有 100个 百位上的1；
综上可得:
        百位上的1的个数 =
                                                 n  / 1000  * 100,                                           （n /100 %10 == 0）

                                                 n / 1000 * 100 + n %100 + 1,                    （n /100 %10 == 1）
                                                 n /1000 * 100 + 100,                                   （n /100 %10 >= 2）

        上式可进一步简化为：
                                               (n /100 + 8)  / 10 * 100  + n %100 + 1          (n /100 % 10  == 1)
                                               (n /100 + 8)  / 10 * 100                                    (n /100 % 10   != 1)
         加8的作用就在于调整（n /100 %10 >= 2）的情况，使式子可以自动加上后面的100。
其他位的计算与此相同。

代码如下：
```cpp
class Solution {
public:
    int countDigitOne(int n) {
        int ones = 0;
        for (long long m = 1; m <= n; m *= 10)
            ones += (n / m + 8) / 10 * m + (n / m % 10 == 1) * (n % m + 1);
        return ones;
    }
};
```
