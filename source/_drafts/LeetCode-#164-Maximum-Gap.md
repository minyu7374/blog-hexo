---
title: "LeetCode #164 Maximum Gap"
date: "2015-08-10T12:44:10+08:00"
categories:
tags:
---

                                            

Given an unsorted array, find the maximum difference between the successive elements in its sorted form.

Try to solve it in linear time/space.

Return 0 if the array contains less than 2 elements.

You may assume all elements in the array are non-negative integers and fit in the 32-bit signed integer range.

Credits:

Special thanks to [@porker2008](https://oj.leetcode.com/discuss/user/porker2008) for adding this problem and creating all test cases.
直接使用快排先排好序，再求解，时间复杂度o(n*logn)，无法达到o(n)。不过AC时间还算挺快，16ms。

```cpp
class Solution {
public:
    int maximumGap(vector<int>& nums) {
        int n = nums.size();
        if (n < 2) return 0;
        sort(nums.begin(), nums.end());
        int res = 0;
        for(int i = 1; i < nums.size(); i++){
            res = max(res, nums[i] - nums[i -1]);
        }
        return res;
    }
};
```有人使用桶排序，时间复杂度降到了O(n),AC耗时8ms


```cpp
class Solution {
public:
    int maximumGap(vector<int> &nums) {
        int sSize = nums.size();
        int i, res =0;
        int minV, maxV;
        int bucket_size, bucket_num, bucket_id;
        int maxGap = INT_MIN; int last_max;

        if(sSize < 2) return 0;

        minV =  maxV = nums[0];
        for(i = 1; i < sSize; i++){
            if(minV > nums[i]) minV = nums[i];
            else if(maxV < nums[i]) maxV = nums[i];
        }

        bucket_size = max(1, (maxV - minV ) / (sSize - 1));
        bucket_num  = (maxV - minV) / bucket_size + 1;

        if(bucket_num <= 1) return (maxV - minV);
        vector<int> bucket_max(bucket_num, INT_MIN);
        vector<int> bucket_min(bucket_num, INT_MAX);
        vector<int> bucket_count(bucket_num, 0);

        for(i = 0; i < sSize; i++){
            bucket_id = (nums[i] - minV) / bucket_size;
            bucket_count[bucket_id]++;
            bucket_min[bucket_id] = bucket_min[bucket_id] > nums[i] ? nums[i] : bucket_min[bucket_id];
            bucket_max[bucket_id] = bucket_max[bucket_id] < nums[i] ? nums[i] : bucket_max[bucket_id];
        }

        last_max = minV;
        for(i = 0; i < bucket_num; i++){
            if(bucket_count[i] > 0){
                maxGap = max(maxGap, bucket_min[i]- last_max);
                last_max = bucket_max[i];
            }
        }
        return maxGap;
    }
};
```

