---
title: "LeetCode #174 Dungeon Game"
date: "2015-08-10T11:40:34+08:00"
categories:
tags:
---

                                            

The demons had captured the princess (P) and imprisoned her in the bottom-right corner of a dungeon. The dungeon consists of M x N rooms laid out in a 2D grid. Our valiant knight (K)
 was initially positioned in the top-left room and must fight his way through the dungeon to rescue the princess.

The knight has an initial health point represented by a positive integer. If at any point his health point drops to 0 or below, he dies immediately.

Some of the rooms are guarded by demons, so the knight loses health (negative integers) upon entering these rooms; other rooms are either empty (0's) or contain magic orbs that increase the knight's health (positive integers).

In order to reach the princess as quickly as possible, the knight decides to move only rightward or downward in each step.
<br style="color:rgb(51,51,51);font-family:'Helvetica Neue', Helvetica, Arial, sans-serif;font-size:14px;line-height:30px;" />
Write a function to determine the knight's minimum initial health so that he is able to rescue the princess.

For example, given the dungeon below, the initial health of the knight must be at least 7 if he follows the optimal path <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">RIGHT->
 RIGHT -> DOWN -> DOWN</code>.
<table class="dungeon" style="border-spacing:0px;border-collapse:collapse;border:3px solid #000000;color:rgb(51,51,51);font-family:'Helvetica Neue', Helvetica, Arial, sans-serif;font-size:14px;line-height:30px;"><tbody><tr><td style="border:3px solid #000000;text-align:center;width:70px;">
-2 (K)</td>
<td style="border:3px solid #000000;text-align:center;width:70px;">
-3</td>
<td style="border:3px solid #000000;text-align:center;width:70px;">
3</td>
</tr><tr><td style="border:3px solid #000000;text-align:center;width:70px;">
-5</td>
<td style="border:3px solid #000000;text-align:center;width:70px;">
-10</td>
<td style="border:3px solid #000000;text-align:center;width:70px;">
1</td>
</tr><tr><td style="border:3px solid #000000;text-align:center;width:70px;">
10</td>
<td style="border:3px solid #000000;text-align:center;width:70px;">
30</td>
<td style="border:3px solid #000000;text-align:center;width:70px;">
-5 (P)</td>
</tr></tbody></table><br style="color:rgb(51,51,51);font-family:'Helvetica Neue', Helvetica, Arial, sans-serif;font-size:14px;line-height:30px;" />
Notes:
<ul style="color:rgb(51,51,51);font-family:'Helvetica Neue', Helvetica, Arial, sans-serif;font-size:14px;line-height:30px;"><li>The knight's health has no upper bound.</li></ul>
<ul style="color:rgb(51,51,51);font-family:'Helvetica Neue', Helvetica, Arial, sans-serif;font-size:14px;line-height:30px;"><li>Any room can contain threats or power-ups, even the first room the knight enters and the bottom-right room where the princess is imprisoned.</li></ul>```cpp
class Solution {
public:
    int calculateMinimumHP(vector<vector<int> >& d) {
        vector<int> dp(d[0].size() + 1, INT_MAX);
        dp[d[0].size() - 1] = 1;
        for (int i = d.size() - 1; i >= 0; i--)
            for (int j = d[0].size() - 1; j >= 0; j--)
                dp[j] = max(1, min(dp[j + 1], dp[j]) - d[i][j]);
        return dp[0];
    }
};
```

