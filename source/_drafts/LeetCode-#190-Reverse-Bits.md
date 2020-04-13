---
title: "LeetCode #190 Reverse Bits"
date: "2015-03-25T02:09:10+08:00"
categories:
tags:
---

                                            

Reverse bits of a given 32 bits unsigned integer.
For example, given input 43261596 (represented in binary as <strong>00000010100101000001111010011100</strong>), return 964176192 (represented in binary as
<strong>00111001011110000010100101000000</strong>)


Runtime: <strong>3 ms</strong>

```cpp
uint32_t reverseBits(uint32_t n) {
    uint32_t anser = 0;
    int c = 32;
    while(c--){
        anser = (anser << 1) | (n % 2);
        n = n >> 1;
    }
    return anser;
