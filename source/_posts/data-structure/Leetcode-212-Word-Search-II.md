---
title: "Leetcode #212 Word Search II"
date: "2015-08-01T12:31:27+08:00"
categories:
- [Data Structure, Trie]
- [LeetCode]
tags:
- LeetCode
- DFS
- 回溯
- Trie
---

Given a 2D board and a list of words from the dictionary, find all words in the board.

Each word must be constructed from letters of sequentially adjacent cell, where "adjacent" cells are those horizontally or vertically neighboring. The same letter cell may not be used more than once in a word.

For example,

```
Given words = ["oath","pea","eat","rain"] and board =
[
  ['o','a','a','n'],
  ['e','t','a','e'],
  ['i','h','k','r'],
  ['i','f','l','v']
]
Return ["eat","oath"].
```
<!-- more -->


开始直接重用 第79道Word Serach的代码 *TLE* 了，代码如下：

```cpp
class Solution {
public:
    vector<string> findWords(vector<vector<char>>& board, vector<string>& words) {
        vector<string> ret;
        for(auto word : words)
            if (exist(board, word))
                ret.push_back(word);
        return ret;
    }

    bool exist(vector<vector<char>>& board, string word) {
        if (board.empty() && word.empty()) return true;
        else if (board.empty()) return false;
        int row = board.size(), col = board[0].size();
        for(int i = 0; i < row; i++)
            for(int j = 0; j < col; j++)
                if ( dfs(board, i, j, word, 0) ) return true;
        return false;
    }

    bool dfs(vector<vector<char>>& board, int i, int j, string word, int word_start){

        if(i < 0 || i >= board.size() || j < 0 || j >= board[0].size()) return false;
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
};
```

本题的hint中提到了trie（而它的前一个题211 Add and Search Word - Data structure design是个典型的trie），用trie的思路是先把所给的单词加到Trie字典里，然后再通过回溯（深搜）遍历矩阵中所有可能的单词，将存在于字典中的单词全部找出。另外，代码中需要注意的是，在回溯的过程中不同的路径上有可能会出现重复的单词，所以要用set记录这些单词，保证一个单词只被存储一次。等回溯结束，再将这些单词存到vector中。

*AC* 的代码如下，耗时是88ms。

```cpp
typedef struct TrieNode{
    TrieNode* child[26];
    bool isendWord;

    TrieNode():isendWord(false){
        for (int i = 0; i < 26; i ++)
            child[i] = NULL;
    }
}* trie_node;

class Trie {
public:
    Trie(vector<string>& words){
        root = new TrieNode();
        for(auto word : words) addWord(word);
    }

    trie_node getRoot(){
        return root;
    }

    void addWord(const string& word){
        trie_node p = root;
        for (int i = 0; i < word.size(); i ++) {
            int j = word[i] - 'a';
            if(!p -> child[j])
                p -> child[j] = new TrieNode();
            p = p -> child[j];
        }
        p -> isendWord = true;
    }

private:
    trie_node root;
};

class Solution {
public:
    vector<string> findWords(vector<vector<char>>& board, vector<string>& words) {

        trie_node root = (new Trie(words)) -> getRoot();

        set<string> res_set;
        for (int i = 0; i < board.size(); i++)
            for(int j = 0; j < board[0].size(); j++)
                searchWord(board, i, j, root, "", res_set);
        vector<string> res;
        for(auto word : res_set) res.push_back(word);
        return res;
    }

    void searchWord (vector< vector<char> >& board, int i, int j, trie_node root, string word, set<string>& res_set) {

        if(i < 0 || j < 0 || i >= board.size() || j >= board[0].size() || board[i][j] == '*') return;

        if(root -> child[board[i][j] - 'a']){
            word += board[i][j];
            root = root -> child[board[i][j] - 'a'];
            if(root -> isendWord) res_set.insert(word);

            char temp = board[i][j];
            board[i][j] = '*';
            searchWord(board, i - 1, j, root, word, res_set);
            searchWord(board, i + 1, j, root, word, res_set);
            searchWord(board, i, j - 1, root, word, res_set);
            searchWord(board, i, j + 1, root, word, res_set);
            board[i][j] = temp;

        }
    }

};
```
