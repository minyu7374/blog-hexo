---
title: "LeetCode #215 Kth Largest Element in an Array"
date: "2015-08-06T22:04:10+08:00"
categories:
tags:
---

                                            
Find the <strong>k</strong>th largest element in an unsorted array. Note that it is the kth largest element in the sorted order, not the kth distinct element.
For example,

Given <code>[3,2,1,5,6,4]</code> and k = 2, return 5.
<strong>Note: </strong>

You may assume k is always valid, 1 ≤ k ≤ array's length.
<strong>Credits:</strong>

Special thanks to [
@mithmatt](https://leetcode.com/discuss/user/mithmatt) for adding this problem and creating all test cases.


求数组第K大者的算法很多，下面列举一些比较常用的解法：
        解法1：选择排序或交互排序，K次选择后即可得到第k大的数。 我们可以对这个数组按照从大到小先行排序，然后取出第k大，时间复杂度为O(n*logn)；


        解法2： 利用选择排序或交互排序，K次选择后即可得到第k大的数。总的时间复杂度为O(n*k)

 

        解法3： 利用近似于快速排序的思想，从数组S中随机找出一个元素X，把数组分为两部分Sa和Sb。Sa中的元素大于等于X，Sb中元素小于X。这时有两种情况：

                               1. Sa中元素的个数小于k，则Sb中的第k-|Sa|个元素即为第k大数；

                               2. Sa中元素的个数大于等于k，则返回Sa中的第k大数。
                        时间复杂度近似为O(n)


        解法4： 二分[Smin,Smax]查找结果X，统计X在数组中出现，且整个数组中比X大的数目为k-1的数即为第k大数。时间复杂度平均情况为O(n*logn)


        解法5：用O(4*n)的方法对原数组建最大堆，然后pop出k次即可。时间复杂度为O(4*n + k*logn)


        解法6：维护一个k大小的最小堆，对于数组中的每一个元素判断与堆顶的大小，若堆顶较大，则不管，否则，弹出堆顶，将当前值插入到堆中。时间复杂度O(n * logk)


        解法7：利用hash保存数组中元素Si出现的次数，利用计数排序的思想，线性从大到小扫描过程中，前面有k-1个数则为第k大数，平均情况下时间复杂度O(n)


在此采用第三种解法，实现简单，且效率较高。同时由于leetcode上的数据不够强，代码的C++版时间是4ms，而c语言版达到了0ms。

```cpp
class Solution {
public:
    int findKthLargest (vector<int>& nums, int k) {

        int low = 0, high = nums.size() - 1;

        while(1){
            if(low >= high) return nums[low];

            int i = low, j = high, pos = low, temp = nums[low];
            while(i < j){
                while(nums[j] <= temp && i < j) j--;
                if(i < j ){
                    nums[pos] = nums[j];
                    pos = j;
                }
                while(nums[i] >= temp && i < j) i++;
                if(i < j){
                    nums[pos] = nums[i];
                    pos = i;
                }
            }
            nums[pos] = temp;

            if(pos == k - 1)
                return nums[pos];
            else if(pos > k - 1)
                high = pos - 1;
            else
                low = pos + 1;
        }
    }
};
```

另外C++采用第一种方法，直接使用stl的话，只需两行代码，而且耗时才8ms。
```cpp
        sort(nums.begin(), nums.end());
        return nums[nums.size() - k];
```


