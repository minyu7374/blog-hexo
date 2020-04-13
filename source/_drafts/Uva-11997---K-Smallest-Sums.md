---
title: "Uva 11997 - K Smallest Sums"
date: "2014-07-15T19:26:40+08:00"
categories:
tags:
---

                                            
URL:  [http://uva.onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=3148](http://uva.onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=3148)

<center style="font-family:'Times New Roman';font-size:14px;">
# Problem K
## K Smallest Sums
</center>

You're given k arrays, each array has k integers. There are k<sup>k</sup> ways to pick exactly one element in each array and calculate the sum of the integers. Your task is to find the k smallest sums
 among them.
## Input
There will be several test cases. The first line of each case contains an integer k (2<=k<=750). Each of the following k lines contains k positive integers in each array. Each of these integers does not
 exceed 1,000,000. The input is terminated by end-of-file (EOF). The size of input file does not exceed 5MB.
## Output
For each test case, print the k smallest sums, in ascending order.
## Sample Input
3
1 8 5
9 2 5
10 7 6
2
1 1
1 2

## Output for the Sample Input
9 10 12
2 2

  
运用优先队列，代码如下：
```cpp
#include <cstdio>
#include <algorithm>
#include <queue>
using namespace std;


struct item{
    int val;
    int pos;
    bool operator < (const item &B) const {
        return val > B.val;
    }
};


int main(){
    int k, L1[800], L2[800];
    while(~scanf("%d", &k)){
        for (int i = 0; i < k; i++) scanf("%d", L1 + i);
        sort(L1, L1 + k);
 
        for (int t = 1; t < k; t++) {
            for (int i = 0; i < k; i++) scanf("%d", L2 +i);
            sort(L2, L2 + k);
            
            priority_queue<item> PQ;
            for (int i = 0; i < k; i++) 
                PQ.push({L1[i] + L2[0], 0});  


            for (int i = 0; i < k; i++){
                item tmp = PQ.top();
                PQ.pop();
                L1[i] = tmp.val;
                if (tmp.pos+1 < k)
                    PQ.push({tmp.val - L2[tmp.pos] + L2[tmp.pos+1], tmp.pos + 1});
            }
        }
        
        for (int i = 0; i < k - 1; i++)
            printf("%d ", L1[i]);
        printf("%d\n", L1[k-1]);
    }
} 
