---
title: "LeetCode#221 Maximal Square"
date: "2015-08-03T14:58:27+08:00"
categories:
tags:
---

                                            
Given a 2D binary matrix filled with 0's and 1's, find the largest square containing all 1's and return its area.
For example, given the following matrix:
1 0 1 0 0
1 0 1 1 1
1 1 1 1 1
1 0 0 1 0

Return 4.


```cpp
class Solution{
public:
    int maximalSquare(vector<vector<char>>& matrix){
        if(matrix.empty()) return 0;
        int row = matrix.size(), col = matrix[0].size();
        int dp[row][col], ans = 0;

        for(int i = 0; i < row; i ++){
            for(int j = 0; j < col; j ++){
                if(matrix[i][j] == '0') dp[i][j] = 0;
                else if(i == 0 || j == 0) dp[i][j] = 1;
                else dp[i][j] = min(dp[i - 1][j - 1], min(dp[i - 1][j], dp[i][j -1])) + 1;
                ans = max(ans, dp[i][j]);
            }
        }

        return ans * ans;
    }
};
```

