---
title: "LeetCode #201 Bitwise AND of Numbers Range"
date: "2015-08-09T21:33:34+08:00"
categories:
tags:
---

                                            
Given a range [m, n] where 0 <= m <= n <= 2147483647, return the bitwise AND of all numbers in this range, inclusive.
For example, given the range [5, 7], you should return 4.
<strong>Credits:</strong>

Special thanks to [
@amrsaqr](https://leetcode.com/discuss/user/amrsaqr) for adding this problem and creating all test cases.
结合二进制的特点，不难得到下面的结论：
          起始位置数据二进制位数不相同的话，结果必然为0（因为从n位向n+ 1位二进制数过度时必然有2^n,而其0～n-1位为0， 而对于小于2^n的二进制数可以看做其n位以上都是0）；
          起始位置二进制位数相同，结果也与两数字位数相同，结果的形式为：从两数字高位开始连续对齐的1 加后面补 0 。
```cpp
class Solution {  
public:  
    int rangeBitwiseAnd(int m, int n) {  
        int offset = 0;  
        while (m && n) {  
            if (m == n)  return m << offset;  
            m >>= 1; n >>= 1; offset++;  
        }  
      
        return 0;  
    }  
};
```
