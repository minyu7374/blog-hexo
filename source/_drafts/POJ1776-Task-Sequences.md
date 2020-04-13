---
title: "POJ1776 Task Sequences"
date: "2015-08-18T21:31:11+08:00"
categories:
tags:
---

                                            
URL:[http://poj.org/problem?id=1776](http://poj.org/problem?id=1776)
Description

Tom has received a lot of tasks from his boss, which are boring to deal with by hand. Fortunately,Tom got a special machine - Advanced Computing Machine (ACM) to help him. 

ACM works in a really special way. The machine can finish one task in a short time, after it's finishing one task, it should smoothly move to the next one, otherwise the machine will stop automatically. You must start it up again to make it continue working.
 Of course, the machine cannot move arbitrarily from one task to another. So each time before it starts up, one task sequence should be well scheduled. Specially, a single task also can be regarded as a sequence. In the sequence, the machine should be able
 to smoothly move from one task to its successor (if exists). After started up, the machine always works according to the task sequence, and stops automatically when it finishes the last one. If not all the tasks have been finished, the machine has to start
 up again and works according to a new sequence. Of course, the finished tasks can't be scheduled again. 

For some unknown reasons, it was guaranteed that for any two tasks i and j, the machine can smoothly move from i to j or from j to i or both. Because the startup process is quite slow, Tom would like to schedule the task sequences properly, so that all the
 tasks can be completed with minimal number of startup times. It is your task to help him achieve this goal.
Input

Input contains several testcases. For each testcase, the first line contains only one integer n, (0 < n <= 1,000), representing the number of tasks Tom has received. Then n lines follow. Each line contains n integers, 0 or 1, separated by white spaces. If the
 j<sup>th</sup>integer in the i<sup>th</sup> line is 1, then the machine can smoothly move from task i to task j, otherwise the machine can not smoothly move from task i to task j. The tasks are numbered from 1 to n. 

Input is terminated by end of file.
Output

For each testcase, the first line of output is only one integer k, the minimal number of startup times needed. And 2k lines follow, to describe the k task sequences. For each task sequence, the first line should contain one integer m, representing the number
 of tasks in the sequence. And the second line should contain m integers, representing the order of the m tasks in the sequence. Two consecutive integers in the same line should be separated by just one white space. Extra spaces are not allowed. There may be
 several solutions, any appropriate one is accepted.
Sample Input
3
0 1 1
1 0 1
0 0 0
Sample Output
1
3
2 1 3


竞赛图一定存在哈密尔顿路径，所以机器肯定只需启动一次，下面的任务就是找这条路径了。
```cpp
#include <cstdio>
#include <cstring>
using namespace std;

#define maxn 1010 
bool graph[maxn][maxn];
int next[maxn];
int head, n;
char str[maxn << 1];

int main() {
    int i, j, k;
    while(~scanf("%d\n", &n)){
        for(i = 0; i < n; i ++) {
            gets(str);
            for(j = 0; j < n; j ++)
                graph[i][j] = str[j << 1] - '0';
        }
        memset(next, 0xff, sizeof(next));
        head = 0;
        for(i = 1; i < n; i++) {
            if(graph[i][head]) {
                next[i] = head; head = i;
                continue;
            }
            j = head; k = next[j];
            while(k != -1) {
                if(graph[j][i] && graph[i][k]) break;
                j = k; k = next[j];
            }
            next[i] = k;
            next[j] = i;
        }
        printf("1\n%d\n", n);
        for(i = 0; i < n; i++) {
            printf(i == 0 ? "%d" : " %d", head + 1);
            head = next[head];
        }
        printf("\n");
    }
    return 0;
}
```


