---
title: "leetcode #1 Two Sum"
date: "2015-03-22T15:33:10+08:00"
categories:
tags:
---

                                            
URL: [
https://leetcode.com/problems/two-sum/](https://leetcode.com/problems/two-sum/)

题目描述：

Given an array of integers, find two numbers such that they add up to a specific target number.
The function twoSum should return indices of the two numbers such that they add up to the target, where index1 must be less than index2. Please note that your returned answers (both index1 and index2) are not zero-based.
You may assume that each input would have exactly one solution.
<strong>Input:</strong> numbers={2, 7, 11, 15}, target=9
<strong>Output:</strong> index1=1, index2=2


   第一次做leetcode上的题，虽然这是第一道，难度也只是Medium，但能一次性通过，可谓“出师告捷”，挺高兴的！题目本来是很简单的（要是不卡时间的话），看到这题，第一反应当然是两层循环，可这样时间复杂度就 n2 了。这道题是要想办法把复杂度降到 n 的，于是，我牺牲了很大的数组空间，用于记录每个数据的下标，本来还担心卡空间呢，结果顺利通过了，真是个惊喜！代码如下：
Language：cpp   Run Time：19 ms


```cpp
#define MAX_INT 0x7FFF
#define MIN_INT 0x8000

class Solution {
    public:
        vector<int> twoSum(vector<int> &numbers, int target) {

             int max = MIN_INT, min = MAX_INT;
             for(int i = 0; i < numbers.size(); i++){
                 max = max > numbers[i] ? max : numbers[i];
                 min = min < numbers[i] ? min : numbers[i];
             }
             max = max > (target - min) ? max : (target - min);
             min = min < (target - max) ? min : (target - max);

             int index_lenth = max - min + 1;
             int index_table[index_lenth];
             memset(index_table, 0xff, sizeof(index_table));

             int first_index = -1, second_index = 0;
             while(second_index < numbers.size()){
                  first_index = index_table[target - numbers[second_index] - min];
                  if(first_index != -1)  break;
                  index_table[numbers[second_index] - min] = second_index;
                  second_index ++;
             }
             vector<int> anser;
             anser.push_back(first_index + 1);
             anser.push_back(second_index + 1);
             return anser;
        }
};
```


      

