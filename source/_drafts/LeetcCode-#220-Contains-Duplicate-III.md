---
title: "LeetcCode #220 Contains Duplicate III"
date: "2015-08-03T15:46:21+08:00"
categories:
tags:
---

                                            
Given an array of integers, find out whether there are two distinct indices <em>
i</em> and <em>j</em> in the array such that the difference between <strong>nums[i]</strong> and<strong>nums[j]</strong> is at most<em>t</em> and the difference between<em>i</em> and<em>j</em> is at most<em>k</em>.
        本题的Tags是BST，可写BST有点麻烦，其实比较简单的一个思路是，可以定义一个结构体，分别保存nums中元素的值val和下标index，然后对此结构体构成的数组根据val的大小排序，这样就很方便地同时计算  k  值和 t  值了。
       实际上用C++写时，vector中元素的地址值本身就可以作下标用，所以也就没必要再去定义这个结构体了。由此，第一次写好的代码如下：

```cpp
bool cmp_ptr(int *a, int *b){
    return *a < *b;
}

class Solution {
public:
    bool containsNearbyAlmostDuplicate(vector<int>& nums, int k, int t) {

      const int n = nums.size();
      if(n <= 1 || k == 0) return false;

      vector<int*> num_ptrs(n);
      for(int i = 0; i < n; i++)  num_ptrs[i] = &nums[i];
      sort(num_ptrs.begin(), num_ptrs.end(), cmp_ptr);

      for(int i = 0; i < n; i++){
          for(int j = i + 1; j < n; j++){
              if(*num_ptrs[j] - *num_ptrs[i] > t) break;                    //the difference between nums[i] and nums[j] is at most t
              if(abs(num_ptrs[j] - num_ptrs[i]) <= k) return true;          //the difference between i and j is at most k
          }
      }

       return false;
    }
};
```



       本地测试没问题后，提交上去，又来了一个在最后一个case上WA！




![](https://img-blog.csdn.net/20150803150122305?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)
      不过WA的这个case给了我充足的提示：
              显然是*num_ptrs[j] - *num_ptrs[i] > t 这个判断条件 在INT_MAX - （-1）时溢出了。
       还好leetcode在WA时都给出出错的测试用列，不然根本不可能找到自己代码是在哪个地方死的。

修改后的代码如下，时间是20ms。


```cpp
bool cmp_ptr(int *a, int *b){
    return *a < *b;
}

class Solution {
public:
    bool containsNearbyAlmostDuplicate(vector<int>& nums, int k, int t) {

      const int n = nums.size();
      if(n <= 1 || k == 0) return false;

      vector<int*> num_ptrs(n);
      for(int i = 0; i < n; i++)  num_ptrs[i] = &nums[i];
      sort(num_ptrs.begin(), num_ptrs.end(), cmp_ptr);

      for(int i = 0; i < n; i++){
          for(int j = i + 1; j < n; j++){
              if(*num_ptrs[j] > *num_ptrs[i] + t) break;                    //the difference between nums[i] and nums[j] is at most t
              if(abs(num_ptrs[j] - num_ptrs[i]) <= k) return true;          //the difference between i and j is at most k
          }
      }

       return false;
    }
};
```

另外在Discuss里发现有人用set做了个滑窗，这个思路也挺好，代码量要少很多。不过相对于上一个方法，效率要低些，AC的时间是48ms。

```cpp
class Solution {
  public:
    bool containsNearbyAlmostDuplicate(vector<int>& nums, int k, int t) {
        set<int> window; // set is ordered automatically 
        for (int i = 0; i < nums.size(); i++) {
            if (i > k) window.erase(nums[i-k-1]); // keep the set contains nums i j at most k
            // -t <= x - nums[i] <= t;
            auto pos = window.lower_bound(nums[i] - t); // x >= nums[i] - t
            if (pos != window.end() && *pos - nums[i] <= t) // x <= nums[i] + t
                   return true;
            window.insert(nums[i]);
        }
        return false;
    }
};
```


