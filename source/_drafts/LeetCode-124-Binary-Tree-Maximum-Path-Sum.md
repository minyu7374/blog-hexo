---
title: "LeetCode #124 Binary Tree Maximum Path Sum"
date: "2015-08-10T11:02:14+08:00"
categories:
tags:
---

                                            

Given a binary tree, find the maximum path sum.

The path may start and end at any node in the tree.

For example:

Given the below binary tree,
       1
      / \
     2   3




Return <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">6</code>.

```cpp
/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     TreeNode *left;
 *     TreeNode *right;
 *     TreeNode(int x) : val(x), left(NULL), right(NULL) {}
 * };
 */
class Solution {
public:
    int maxPathSum(TreeNode* root) {
        if(root == NULL) return 0;
        int res = root->val;
        getMax(root, res);
        return res;
    }
    int getMax(TreeNode *root, int &res){
        if(root == NULL) return 0;
        int left = getMax(root->left,res);
        int right = getMax(root->right, res);
        res = max(res, left + right + root->val);
        return max(0, max(left, right) + root->val);
    }
};
```
