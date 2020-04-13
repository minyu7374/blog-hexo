---
title: "LeetCode #191 Number of 1 Bits"
date: "2015-03-25T01:49:25+08:00"
categories:
tags:
---

                                            
Write a function that takes an unsigned integer and returns the number of ’1' bits it has (also known as the[Hamming weight](http://en.wikipedia.org/wiki/Hamming_weight)).
For example, the 32-bit integer ’11' has binary representation <code>00000000000000000000000000001011</code>, so the function should return 3.


5ms的代码：

```cpp
int hammingWeight(uint32_t n) {
    int anser = 0;
    uint32_t test = 1;
    while(test){
         anser += (test & n) == 0 ? 0 : 1;
         test = test << 1;
    }
    return anser;
}
```


4ms的代码：

```cpp
int hammingWeight(uint32_t n) {
    int anser = 0;
    while(n){
         anser += n%2;
         n = n >> 1;
    }
    return anser;
}
```

实在想不到更快的了，不知道0ms怎么写。



