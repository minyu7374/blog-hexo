---
title: "Leetcode #11 Container With Most Water"
date: "2015-06-01T19:21:46+08:00"
categories:
tags:
---

                                            
Given <em>n</em> non-negative integers <em>a<sub>1</sub></em>, <em>a<sub>2</sub></em>, ...,
<em>a<sub>n</sub></em>, where each represents a point at coordinate (<em>i</em>, <em>
a<sub>i</sub></em>). <em>n</em> vertical lines are drawn such that the two endpoints of line
<em>i</em> is at (<em>i</em>, <em>a<sub>i</sub></em>) and (<em>i</em>, 0). Find two lines, which together with x-axis forms a container, such that the container contains the most water.
Note: You may not slant the container.
比较傻瓜的代码（TLE）：

```cpp
#define max(x, y) ( (x) > (y) ? (x) : (y) )
#define min(x, y) ( (x) < (y) ? (x) : (y) )

int maxArea( int* height, int heightSize ) {
    int i, j, ans = 0;
    for( i = 0; i < heightSize; i++ ) {
        for( j = i + 1; j < heightSize; j++ ) {
            ans = max ( ans, min( height[i], height[j] ) * (j - i) );
        }
    }
    return ans;
}
```

优化后8ms：
```cpp
#define max(x, y) ( (x) > (y) ? (x) : (y) )
#define min(x, y) ( (x) < (y) ? (x) : (y) )

int maxArea( int* height, int heightSize ) {
    int i = 0, j = heightSize - 1, ans = 0;
    while(i < j) {
        ans = max ( ans, min( height[i], height[j] ) * (j - i) );
        if(height[i] < height[j]) i++;
        else j--;
    }
    return ans;
