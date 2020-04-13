---
title: "Leetcode #230 Kth Smallest Element in a BST"
date: "2015-08-01T18:27:42+08:00"
categories:
tags:
---

                                            
Given a binary search tree, write a function <code>kthSmallest</code> to find the
<strong>k</strong>th smallest element in it.

<strong>Note: </strong>

You may assume k is always valid, 1 ≤ k ≤ BST's total elements.
<strong>Follow up:</strong>

What if the BST is modified (insert/delete operations) often and you need to find the kth smallest frequently? How would you optimize the kthSmallest routine?
根据BST的特点，采用中序遍历

```cpp
class Solution {
public:
    int kthSmallest(TreeNode* root, int k) {
        int count = 0;
        bool flag = false;
        return midOrderTraverse(root, k, count, flag);
    }
    int midOrderTraverse(TreeNode* node, int k, int &count, bool &flag) {
        if(node == NULL) {
            flag = false;
            return 0;
        }
        int tmp = midOrderTraverse(node->left, k, count, flag);
        if(flag)
            return tmp;
        count++;
        if(count == k) {
            flag = true;
            return node->val;
        }
        tmp = midOrderTraverse(node->right, k, count, flag);
        if(flag)
            return tmp;
    }
