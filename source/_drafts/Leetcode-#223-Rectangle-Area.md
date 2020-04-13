---
title: "Leetcode #223 Rectangle Area"
date: "2015-08-02T17:16:27+08:00"
categories:
tags:
---

                                            
Find the total area covered by two <strong>rectilinear</strong> rectangles in a
<strong>2D</strong> plane.
Each rectangle is defined by its bottom left corner and top right corner as shown in the figure.
![Rectangle Area](https://leetcode.com/static/images/problemset/rectangle_area.png)

Assume that the total area is never beyond the maximum possible value of <strong>
int</strong>.

<strong>Credits:</strong>

Special thanks to [
@mithmatt](https://leetcode.com/discuss/user/mithmatt) for adding this problem, creating the above image and all test cases.


```cpp
class Solution {
public:
    int computeArea(int A, int B, int C, int D, int E, int F, int G, int H) {
        int ans = (C- A) * (D - B) + (G - E) * (H - F);
        if(C <= E || G <= A || D <= F || H <= B) return ans;  //两矩形不相交
        int x[4] = {A, C, E, G};   int y[4] = {B, D, F, H};
        sort(x, x + 4); sort(y, y + 4);
        return ans - (x[2] - x[1]) * (y[2] - y[1]);          //分别取在x，y轴方向上相交线段的长度相乘即为重合部分面积。
    }
};
```
对两矩形是否相交的判断及处理可以进一步简化，最终代码只需一行：

```cpp
return (C-A) * (D-B) + (G-E) * (H-F) - max(0, min(G,C) - max(A,E)) * max(0, min(D,H) - max(B,F));
```

但提交后却在最后一组数据WA了。


<img src="https://img-blog.csdn.net/20150802170033452?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center" align="middle" alt="" />

原因在于该组case中 计算min(G, C) - max(A,E)时数据溢出。

故仅需修改成long long型，如下，即可顺利AC。

```cpp
 return (C-A) * (D-B) + (G-E) * (H-F) - max((long long)0, ((long long)min(G,C) - (long long) max(A,E))) * max((long long)0,  (long long)(min(D,H) - max(B,F)));

```





