---
title: "LeetCode # 149 	Max Points on a Line"
date: "2015-08-02T22:19:34+08:00"
categories:
tags:
---

                                            
Given <em>n</em> points on a 2D plane, find the maximum number of points that lie on the same straight line.
      本题有点戏剧性，在本地测试代码的时候，答案并不正确，经过很长时间反复排查逻辑后最后，硬着头皮提交竟然AC了，本来还以为是我GCC-C++版本浮点型计算的精度问题，最后才发现是自己写的Point构造函数错了。

```cpp
class Solution {
public:
    int maxPoints(vector<Point>& points) {

        if(points.size() < 3) return points.size();

        int result = 0;

        for(int i = 0; i < points.size(); i++) {
            int repeat_points = 1, line_maxpoint = 0;
            map<float, int> m;

            for (int j = i + 1; j < points.size(); j++) {
                if(points[j].x == points[i].x && points[j].y == points[i].y) repeat_points++;
                else if(points[j].x == points[i].x) m[INFINITY]++;
                else m[(float)(points[j].y - points[i].y) / (points[j].x - points[i].x)]++;
            }

            for(auto line : m)
                line_maxpoint = max(line_maxpoint, line.second);
            result = max(result, line_maxpoint + repeat_points);
        }
        return result;
    }
};
```


