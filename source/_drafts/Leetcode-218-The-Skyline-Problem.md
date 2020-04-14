---
title: "Leetcode #218 The Skyline Problem"
date: "2015-07-29T20:21:19+08:00"
categories:
tags:
---

                                            



A city's skyline is the outer contour of the silhouette formed by all the buildings in that city when viewed from a distance. Now suppose you are given the locations and height of all the buildings as shown on a cityscape
 photo (Figure A), write a program to output the skyline formed by these buildings collectively (Figure B).
<a href="https://leetcode.com/static/images/problemset/skyline1.jpg" rel="nofollow" style="color:rgb(0,85,128);font-family:'Helvetica Neue', Helvetica, Arial, sans-serif;font-size:14px;line-height:30px;"><img src="https://leetcode.com/static/images/problemset/skyline1.jpg" border="0" alt="Buildings" style="border:0px;vertical-align:middle;" /> </a><a href="https://leetcode.com/static/images/problemset/skyline2.jpg" rel="nofollow" style="color:rgb(0,136,204);text-decoration:none;font-family:'Helvetica Neue', Helvetica, Arial, sans-serif;font-size:14px;line-height:30px;"><img src="https://leetcode.com/static/images/problemset/skyline2.jpg" border="0" alt="Skyline Contour" style="border:0px;vertical-align:middle;" /></a>

The geometric information of each building is represented by a triplet of integers <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">[Li,
 Ri, Hi]</code>, where <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">Li</code> and <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">Ri</code> are
 the x coordinates of the left and right edge of the ith building, respectively, and <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">Hi</code> is
 its height. It is guaranteed that <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">0 ≤ Li, Ri ≤ INT_MAX</code>, <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">0
 < Hi ≤ INT_MAX</code>, and <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">Ri - Li > 0</code>. You may assume all buildings are
 perfect rectangles grounded on an absolutely flat surface at height 0.

For instance, the dimensions of all buildings in Figure A are recorded as: <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">[ [2 9
 10], [3 7 15], [5 12 12], [15 20 10], [19 24 8] ] </code>.

The output is a list of "key points" (red dots in Figure B) in the format of <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">[
 [x1,y1], [x2, y2], [x3, y3], ... ]</code> that uniquely defines a skyline. A key point is the left endpoint of a horizontal line segment. Note that the last key point, where the rightmost building ends, is merely used to
 mark the termination of the skyline, and always has zero height. Also, the ground in between any two adjacent buildings should be considered part of the skyline contour.

For instance, the skyline in Figure B should be represented as:<code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">[ [2 10], [3 15],
 [7 12], [12 0], [15 10], [20 8], [24, 0] ]</code>.

Notes:
<ul style="color:rgb(51,51,51);font-family:'Helvetica Neue', Helvetica, Arial, sans-serif;font-size:14px;line-height:30px;"><li>The number of buildings in any input list is guaranteed to be in the range <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">[0,
 10000]</code>.</li><li>The input list is already sorted in ascending order by the left x position <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">Li</code>.</li><li>The output list must be sorted by the x position.</li><li>There must be no consecutive horizontal lines of equal height in the output skyline. For instance, <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">[...[2
 3], [4 5], [7 5], [11 5], [12 7]...]</code> is not acceptable; the three lines of height 5 should be merged into one in the final output as such: <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">[...[2
 3], [4 5], [12 7], ...]</code></li></ul>
       uva 105 是该题的简单版本，主要区别在于uva上"All coordinates of buildings are integers less than 10,000",这样直接开一个横坐标的数组，然后直接记下每一点的最大高度即可。

       本题比较简单的AC代码如下：

```cpp
class Solution {
public:
    vector< pair<int, int> > getSkyline(vector< vector<int> > & buildings) {
        vector< pair<int, int> > height;
        for (auto &b : buildings) { 
            height.push_back({b[0], -b[2]});
            height.push_back({b[1], b[2]});
        }
        sort(height.begin(), height.end());
        multiset<int> heap;
        heap.insert(0);
        vector< pair<int, int> > res;
        int pre = 0, cur = 0;
        for (auto &h : height) {
            if (h.second < 0) {
                heap.insert(-h.second);
            } else {
                heap.erase(heap.find(h.second));
            }   
            cur = *heap.rbegin();
            if (cur != pre) {
                res.push_back({h.first, cur});
                pre = cur;
            }
        }
        return res;
    }
};
```
