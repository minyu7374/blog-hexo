---
title: "leetcode #9 Palindrome Number"
date: "2015-05-18T23:09:50+08:00"
categories:
tags:
---

                                            
Determine whether an integer is a palindrome. Do this without extra space.
[click to show spoilers.](https://leetcode.com/problems/palindrome-number/#)
<strong>Some hints:</strong>
Could negative integers be palindromes? (ie, -1)
If you are thinking of converting the integer to string, note the restriction of using extra space.
You could also try reversing an integer. However, if you have solved the problem "Reverse Integer", you know that the reversed integer might overflow. How would you handle such case?
There is a more generic way of solving this problem.
      根据提示，负数不用考虑，直接输出false；对于正数，可以重用"Reverse Integer"一题的函数。不过，稍作分析就会发现，提示上说的溢出对结果的正确与否没有任何影响，因为是否为回文数字的判定标准是该数字与其反转是否相等。

       如果该数是回文数字，则它的反转跟它原来的值相同，不可能溢出；
       如果不是回文数字，反转后即使会溢出，得到的值也是负值，必然不会和原数值相等，不会影响判断。
代码如下：

```cpp
int reverse(int x) {  
    int result = 0;  
    while(x){
        result = result * 10 + x % 10;  
        x /= 10;  
    }  
    return result;
}  
  

bool isPalindrome(int x) {
    if (x < 0) return false;
    return x == reverse(x);
}
```


