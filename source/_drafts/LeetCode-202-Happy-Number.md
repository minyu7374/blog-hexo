---
title: "LeetCode #202 Happy Number"
date: "2015-08-09T13:10:49+08:00"
categories:
tags:
---

                                            
Write an algorithm to determine if a number is "happy".
A happy number is a number defined by the following process: Starting with any positive integer, replace the number by the sum of the squares of its digits, and repeat the process until the number equals 1 (where it will stay), or it loops endlessly in a
 cycle which does not include 1. Those numbers for which this process ends in 1 are happy numbers.
<strong>Example: </strong>19 is a happy number
<ul style="list-style:none;"><li>1<sup>2</sup> + 9<sup>2</sup> = 82</li><li>8<sup>2</sup> + 2<sup>2</sup> = 68</li><li>6<sup>2</sup> + 8<sup>2</sup> = 100</li><li>1<sup>2</sup> + 0<sup>2</sup> + 0<sup>2</sup> = 1</li></ul>直接用hash表倒也很简单：

```cpp
bool isHappy(int n) {
    set<int> nums;
    while(1){
        int sum = 0;
        while(n) { sum += (n%10) * (n%10); n /= 10; }
        if(sum == 1) return true;
        if(nums.find(sum) != nums.end()) return false;
        nums.insert(sum);
        n = sum;
    }
}
```
不过还是有人知道happy number的规律的，
在Discuss中找到一下两种总结
一、 所有非happly number 最终终结于包含[2, 6]中某数的循环之中。

 all numbers in [2, 6] are not happy，and all not happy numbers end on a cycle that hits this interval
相应代码如下：
```cpp
bool isHappy(int n) {
    while(n > 6) {
        int sum = 0;
        while(n) {sum += (n%10)*(n%10); n /= 10;}
        n = next;
    }
    return n == 1;
}
```
二、这个更直接，所有非happly number 最终终结于包含4中某数的循环之中，当然比起第一个总结，在对某些数字的判断上会多走几步。

If it was not happy, we enter a cycle that contains the number 4
```cpp
bool isHappy(int n) {
    while(1) {
        int sum = 0;
        while(n) {sum += (n%10)*(n%10); n /= 10;}
        if(sum == 1) return true;
        else if(sum == 4) return false;
        n = sum;
    }
}
```
