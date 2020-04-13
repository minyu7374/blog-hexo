---
title: "LeetCode #217 Contains Duplicate"
date: "2015-08-03T17:41:43+08:00"
categories:
tags:
---

                                            
Given an array of integers, find if the array contains any duplicates. Your function should return true if any value appears at least twice in the array, and it should return false if every element is distinct.
代码一 

先排序，之后很方便查看是否有重复数据。40ms。


```cpp
class Solution {
public:
    bool containsDuplicate(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        for (int i = 1; i < nums.size(); i++)
            if (nums[i] == nums[i - 1])  return true;
        return false;
    }
};

```

代码二

利用stl的set，不断向set中插入数据，一旦发现要插入的数据已经存在，返回true。96ms

```cpp
class Solution {
public:
    bool containsDuplicate(vector<int>& nums) {
        set<int> num_set;
        for(auto num : nums){
            if(num_set.find(num) != num_set.end())
                return true;
            num_set.insert(num);
        }
        return false;
    }
};
```

代码三

同样利用set，一次性插入所有数据，比较set与vector的长度，若不等，说明有重复数据。48ms
代码只需一行，如下：

```cpp
return (new set<int>(nums.begin(), nums.end()))->size() != nums.size();
```由于排序，对代码效率有所限制，改成 unordered_set（如下） 后44ms，效率仍然没有超过第一个方法。 
```cpp
return (new unordered_set<int>(nums.begin(), nums.end()))->size() != nums.size();

```


代码四
有点浪费空间，不过效率确实高。
数组的大小设定受vector内数据的取值范围的影响，还好leetcode上的数据不强，不然这个程序是不好写的。

```cpp
class Solution { 
public: 
    bool containsDuplicate(vector<int>& nums) {

        bool array[0xFFFFF] = {};
        // memset(array, 0, sizeof(array));
        for(auto num : nums)
            if(array[num]) return  true;
            else array[num] = true;
        return false;
    }
};
```

直接提交是WA的，因为没有考虑负数的情况
![](https://img-blog.csdn.net/20150803182107719?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

修改后代码如下，AC的时间是24ms

```cpp
class Solution {
public:
    bool containsDuplicate(vector<int>& nums) {

        bool array[0xFFFFF] = {};
        //memset(array, 0, sizeof(array));
        for(auto num : nums)
            if(array[(num + 0x7FFFF) % 0xFFFFF]) return  true;
            else array[(num + 0x7FFFF) % 0xFFFFF] = true;
        return false;
    }
};
```




