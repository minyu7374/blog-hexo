---
title: "Leetcode #79 Word Search"
date: "2015-07-31T19:34:21+08:00"
categories:
tags:
---

                                            


Given a 2D board and a word, find if the word exists in the grid.

The word can be constructed from letters of sequentially adjacent cell, where "adjacent" cells are those horizontally or vertically neighboring. The same letter cell may not be used more than once.

For example,

Given board =
[
  ["ABCE"],
  ["SFCS"],
  ["ADEE"]
]

word = <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);line-height:30px;">"ABCCED"</code>,
 -> returns <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);line-height:30px;">true</code>,<br style="color:rgb(51,51,51);font-family:'Helvetica Neue', Helvetica, Arial, sans-serif;font-size:14px;line-height:30px;" />word = <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);line-height:30px;">"SEE"</code>,
 -> returns <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);line-height:30px;">true</code>,<br style="color:rgb(51,51,51);font-family:'Helvetica Neue', Helvetica, Arial, sans-serif;font-size:14px;line-height:30px;" />word = <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);line-height:30px;">"ABCB"</code>,
 -> returns <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);line-height:30px;">false</code>.
      典型的回溯法，开始代码写的太冗杂，结果TLE了，TLE的代码如下，多开辟了一个vector来记录矩阵的每个元素是否已被访问，浪费了些空间，这也不算什么。最要命的设计是每次递归调用dfs时，都使用了substr()函数，大大折损了程序效率。还有那四个判断也是在自找麻烦。而实际上这些设计都是没有必要的。
```cpp
class Solution {
public:
    int row, col;

    bool exist(vector<vector<char>>& board, string word) {
        row = board.size(); col = board[0].size();
        vector<vector<bool>> isvisited;
        for(int i = 0; i < row; i++){
            vector<bool> temp (col, false);
            isvisited.push_back(temp);
        }
        for(int i = 0; i < row; i++)
            for(int j = 0; j < col; j++)
                if ( backtracking(board, isvisited, i, j, word) ) return true;
        return false;
    }

    bool backtracking(vector<vector<char>>& board, vector<vector<bool>>& isvisited, int i, int j, string word){
        if (word[0] == board[i][j]) {
            isvisited[i][j] = true;
            if (word.size() == 1) return true;
            if(i - 1 > 0 && !isvisited[i - 1][j] && backtracking(board, isvisited, i - 1, j, word.substr(1))) return true;
            if(i + 1 < row && !isvisited[i + 1][j] && backtracking(board, isvisited, i + 1, j, word.substr(1))) return true;
            if(j - 1 > 0 && !isvisited[i][j - 1] && backtracking(board, isvisited, i, j - 1, word.substr(1))) return true;
            if(j + 1 < col && !isvisited[i][j + 1] && backtracking(board, isvisited, i, j + 1, word.substr(1))) return true;
            isvisited[i][j] = false;
        }
        return false;
    }
};
```

简化后的代码如下，同时加入了对于board 或word为空时的容错处理。不过不写这两句，也能正常AC。运行耗时是64ms。
```cpp
class Solution {
public:
    int row, col;

    bool exist(vector<vector<char>>& board, string word) {
        if (board.empty() && word.empty()) return true;
        else if (board.empty()) return false;
        row = board.size(); col = board[0].size();
        for(int i = 0; i < row; i++)
            for(int j = 0; j < col; j++)
                if ( dfs(board, i, j, word, 0) ) return true;
        return false;
    }

    bool dfs(vector<vector<char>>& board, int i, int j, string word, int word_start){

        if(i < 0 || i >= row || j < 0 || j >= col) return false;
        if(board[i][j] == '*' || word[word_start] != board[i][j])  return false;
        if (word_start == word.size() - 1)  return true;

        char temp = board[i][j]; board[i][j] = '*';
        if(dfs(board, i - 1, j, word, word_start + 1) || dfs(board, i + 1, j, word, word_start + 1)
                || dfs(board, i, j - 1, word, word_start + 1) || dfs(board, i, j + 1, word, word_start + 1)) {
            board[i][j] = temp;
            return true;
        }
        board[i][j] = temp;
        return false;
    }
