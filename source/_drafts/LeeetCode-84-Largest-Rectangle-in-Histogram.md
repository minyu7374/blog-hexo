---
title: "LeeetCode #84 Largest Rectangle in Histogram"
date: "2015-08-14T19:17:44+08:00"
categories:
tags:
---

                                            

Given n non-negative integers representing the histogram's bar height where the width of each bar is 1, find the area of largest rectangle in the histogram.

![](http://www.leetcode.com/wp-content/uploads/2012/04/histogram.png)


Above is a histogram where width of each bar is 1, given height = <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:9.89999961853027px;color:rgb(199,37,78);">[2,1,5,6,2,3]</code>.



![](http://www.leetcode.com/wp-content/uploads/2012/04/histogram_area.png)


The largest rectangle is shown in the shaded area, which has area = <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:9.89999961853027px;color:rgb(199,37,78);">10</code> unit.



For example,

Given height = <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">[2,1,5,6,2,3]</code>,

return <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">10</code>.
```cpp
class Solution{
public:
     int largestRectangleArea(vector<int>& height) {
        height.push_back(0);
        int n = height.size();
        stack<int> s;
        int i = 0, max_a = 0;
        while (i < n) {
            if (s.empty() || height[i] >= height[s.top()]) s.push(i++);
            else {
                int h = s.top(); s.pop();
                max_a = max(max_a, height[h] * (s.empty() ? i : i - s.top() - 1));
            }
        }
        return max_a;
    }
};
```
