---
title: "Leetcode #239 Sliding Window Maximum"
date: "2015-07-31T09:49:12+08:00"
categories:
tags:
---

                                            
Given an array <em>nums</em>, there is a sliding window of size <em>k</em> which is moving from the very left of the array to the very right. You can only see the
<em>k</em> numbers in the window. Each time the sliding window moves right by one position.
For example,

Given <em>nums</em> = <code>[1,3,-1,-3,5,3,6,7]</code>, and <em>k</em> = 3.
Window position                Max
---------------               -----
[1  3  -1] -3  5  3  6  7       3
 1 [3  -1  -3] 5  3  6  7       3
 1  3 [-1  -3  5] 3  6  7       5
 1  3  -1 [-3  5  3] 6  7       5
 1  3  -1  -3 [5  3  6] 7       6
 1  3  -1  -3  5 [3  6  7]      7

Therefore, return the max sliding window as <code>[3,3,5,5,6,7]</code>.
<strong>Note: </strong>

You may assume <em>k</em> is always valid, ie: 1 ≤ k ≤ input array's size for non-empty array.
<strong>Follow up:</strong>

Could you solve it in linear time?
<strong>Hint:</strong>
<ol id="hints"><li class="hint animated fadeInLeft" style="display:list-item;">How about using a data structure such as deque (double-ended queue)?</li><li class="hint animated fadeInLeft" style="display:list-item;">The queue size need not be the same as the window’s size.</li><li class="hint animated fadeInLeft" style="display:list-item;">Remove redundant elements and the queue should store only elements that need to be considered.</li></ol>          比较直接的思路是使用优先队列，代码如下，此处使用multiset可以保证集合中同时存在相同元素。
          代码耗时是152ms。
```cpp
class Solution {
public:
    vector<int> maxSlidingWindow(vector<int>& nums, int k) {
        vector<int> res;
        multiset<int> heap;

        for(int i = 0; i < k; i++) {
            heap.insert(nums[i]);
        }
        res.push_back(*heap.rbegin());

        for (int i = k; i < nums.size(); i++) {
            heap.erase(heap.find(nums[i - k]));
            heap.insert(nums[i]);
            res.push_back(*heap.rbegin());
        }
        return res;
    }
};
```
         在本题的Discuss中，有人用deque写了如下代码，思路要巧妙很多，耗时100ms。

```cpp
class Solution {
public:
    vector<int> maxSlidingWindow(vector<int>& nums, int k) {
        vector<int> res;
        deque<int> q;
        for (int i = 0; i < nums.size(); ++i) {
            if (!q.empty() && q.front() == i - k) q.pop_front();
            while (!q.empty() && nums[q.back()] < nums[i]) q.pop_back();
            q.push_back(i);
            if (i >= k - 1) res.push_back(nums[q.front()]);
        }
        return res;
    }
