---
title: "Leetcode #222 Count Complete Tree Nodes"
date: "2015-08-02T18:53:51+08:00"
categories:
tags:
---

                                            
Given a <strong>complete</strong> binary tree, count the number of nodes.

<strong><u>Definition of a complete binary tree from [
Wikipedia](http://en.wikipedia.org/wiki/Binary_tree#Types_of_binary_trees):</u></strong>

In a complete binary tree every level, except possibly the last, is completely filled, and all nodes in the last level are as far left as possible. It can have between 1 and 2<sup>h</sup> nodes inclusive at the last level h.



```cpp
class Solution {
public:
    int countNodes(TreeNode* root) {

        if (root == NULL)
            return 0;

        int hLeft = getHeight(root -> left);
        int hRight = getHeight(root -> right);

        if (hLeft == hRight)
            return (1 << hLeft) + countNodes(root -> right);
        else
            return (1 << hRight) + countNodes(root -> left);
    }

    int getHeight(TreeNode* root) {
        if (root == NULL)
            return 0;
        return getHeight(root -> left) + 1;
    }
