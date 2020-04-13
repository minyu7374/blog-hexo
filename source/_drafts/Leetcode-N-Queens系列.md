---
title: "Leetcode N-Queens系列"
date: "2015-08-09T20:55:54+08:00"
categories:
tags:
---

                                            
<strong>#51</strong> N-Queens


The <em>n</em>-queens puzzle is the problem of placing <em>n</em> queens on an<em>n</em>×<em>n</em> chessboard such that no two queens attack each other.
![](http://www.leetcode.com/wp-content/uploads/2012/03/8-queens.png)
Given an integer <em>n</em>, return all distinct solutions to the <em>n</em>-queens puzzle.
Each solution contains a distinct board configuration of the <em>n</em>-queens' placement, where<code>'Q'</code> and
<code>'.'</code> both indicate a queen and an empty space respectively.
For example,

There exist two distinct solutions to the 4-queens puzzle:

[
 [".Q..",  // Solution 1
  "...Q",
  "Q...",
  "..Q."],

 ["..Q.",  // Solution 2
  "Q...",
  "...Q",
  ".Q.."]
]

       经典的回溯问题，为了减少对每个方格是否可放置皇后的判断，提前用一个数组记录下来。
        代码中 isvalid 不同下标范围具有不同的含义：
                  0  ~ n- 1                         index = col  代表 第 col  列的状态（共n列）
                  n  ~ 3n-2                        index = n + row + col 代表（row，col）所在的正斜线的状态（共2n -1个正斜线）
                  3n -1 ~  5n -3                index = 3n - 2 + n -row + col 代表（row, col）所在反斜线的状态（共2n -1个反斜线）


```cpp
class Solution {
public:
    vector< vector<string> > solveNQueens(int n) {

        vector< vector<string> > res;
        if (n == 0) return res;

        int row = 0;
        vector<int> isvalid(n + 2 * (2 * n - 1), 1);
        vector<int> col(n, -1);

        while(row >= 0){
            if(col[row] != -1) {
                isvalid[col[row]] = isvalid[n + row + col[row]] = isvalid[3 * n - 2 + n  - row + col[row]] = 1;
            }
            col[row] ++;
            while(col[row] < n){
                if(isvalid[col[row]] && isvalid[n + row + col[row]] && isvalid[3 * n - 2 + n - row + col[row]] ) break;
                col[row] ++;
            }

            if(col[row] == n)  row--; //回溯
            else if(row == n -1){
                vector<string> one;
                for(int i = 0; i < n; i ++){
                    string s = "";
                    s.insert(0, n - 1, '.');
                    s.insert(col[i], 1, 'Q');
                    one.push_back(s);
                }
                res.push_back(one);
            }
            else{
                isvalid[col[row]] = isvalid[n + row + col[row]] = isvalid[3 * n - 2 + n - row + col[row]] = 0;
                col[++row] = -1;
           }
        }
        return res;
    }
};
```




### #52 N-Queens II


Follow up for N-Queens problem.
Now, instead outputting board configurations, return the total number of distinct solutions.
由上面代码稍加修改即可：

```cpp
class Solution {
public:
    int totalNQueens(int n) {
        if (n == 0) return 0;

        int res = 0, row = 0;
        vector<int> isvalid(n + 2 * (2 * n - 1), 1);
        vector<int> col(n, -1);

        while(row >= 0){
            if(col[row] != -1) {
                isvalid[col[row]] = isvalid[n + row + col[row]] = isvalid[3 * n - 2 + n  - row + col[row]] = 1;
            }
            col[row] ++;
            while(col[row] < n){
                if(isvalid[col[row]] && isvalid[n + row + col[row]] && isvalid[3 * n - 2 + n - row + col[row]] ) break;
                col[row] ++;
            }

            if(col[row] == n)  row--; //回溯
            else if(row == n -1) res ++;
            else{
                isvalid[col[row]] = isvalid[n + row + col[row]] = isvalid[3 * n - 2 + n - row + col[row]] = 0;
                col[++row] = -1;
           }
        }
        return res;
    }
};
```

可以写成递归形式如下：

```cpp
class Solution {
public:
    void dfs(int &res, vector<int> &isvalid, int row, int n) {
        if (row == n){
            ++res; return;
        }

        for (int col = 0; col < n; col++) {
            if (isvalid[col] && isvalid[n + row + col] && isvalid[3 * n - 2 + n - row + col]){
                isvalid[col] = isvalid[n + row + col] = isvalid[3 * n - 2 + n - row + col] = 0;
                dfs(res, isvalid, row + 1, n);
                isvalid[col] = isvalid[n + row + col] = isvalid[3 * n - 2 + n  - row + col] = 1;
            }
        }
        return;
    }
    int totalNQueens(int n) {
        if (n == 0) return 0;
        int res = 0;
        vector<int> isvalid(n + 2 * (2 * n - 1), 1);
        dfs(res, isvalid, 0, n);
        return res;
    }
};
```




