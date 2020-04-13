---
title: "ZOJ2110 Tempter of the Bone"
date: "2014-07-28T22:34:32+08:00"
categories:
tags:
---

                                            
﻿﻿
URL: [
http://acm.zju.edu.cn/onlinejudge/showProblem.do?problemId=1110](http://acm.zju.edu.cn/onlinejudge/showProblem.do?problemId=1110)
The doggie found a bone in an ancient maze, which fascinated him a lot. However, when he picked it up, the maze began to shake, and the doggie could feel the ground sinking. He realized that the bone was a trap, and he tried desperately to get out of this
 maze.


The maze was a rectangle with sizes N by M. There was a door in the maze. At the beginning, the door was closed and it would open at the T-th second for a short period of time (less than 1 second). Therefore the doggie had to arrive at the door on exactly the
 T-th second. In every second, he could move one block to one of the upper, lower, left and right neighboring blocks. Once he entered a block, the ground of this block would start to sink and disappear in the next second. He could not stay at one block for
 more than one second, nor could he move into a visited block. Can the poor doggie survive? Please help him.

<strong>Input</strong>


The input consists of multiple test cases. The first line of each test case contains three integers N, M, and T (1 < N, M < 7; 0 < T < 50), which denote the sizes of the maze and the time at which the door will open, respectively. The next N lines give the
 maze layout, with each line containing M characters. A character is one of the following:


'X': a block of wall, which the doggie cannot enter; 

'S': the start point of the doggie; 

'D': the Door; or

'.': an empty block.


The input is terminated with three 0's. This test case is not to be processed.

<strong>Output</strong>


For each test case, print in one line "YES" if the doggie can survive, or "NO" otherwise.

<strong>Sample Input</strong>


4 4 5

S.X.

..X.

..XD

....

3 4 5

S.X.

..X.

...D

0 0 0
<strong>

Sample Output</strong>


NO

YES


         DFS搜索，但要注意剪枝，否则会TLE。
```cpp
#include <cstdio>

char g[10][10];
int n, m, t, dx, dy;
bool flag;
int dir[4][2]{{1,0}, {0,1}, {-1, 0}, {0, -1}};

inline int fabs(int x) {return x > 0 ? x : -x;} 
inline bool ok(int x, int y){
    if(x < 0 || y < 0 || x >= n || y >= m) return false;
    if(g[x][y] == 'X') return false;
    return true;
}

void DFS(int x, int y, int cnt){
    if(x == dx && y == dy && cnt == t) {flag = 1; return;}
    int temp = t - cnt - fabs(dx - x) - fabs(dy - y);
    if(temp < 0 || temp % 2) return;
    int tx, ty;
    for(int i = 0; i < 4; i++){
    	tx = x + dir[i][0]; ty = y + dir[i][1];
    	if(ok(tx, ty)){
    		g[tx][ty] ='X';
    		DFS(tx, ty, cnt + 1);
    		if(flag) return;
    		g[tx][ty] = '.';
    	}
    }        
}

int main(){
    int sx, sy, wall; 
    while(~scanf("%d %d %d", &n, &m, &t) && (m || n || t)){
    	wall = 0;
    	for(int i = 0; i < n; i++){
    	    scanf("%s", g + i);
            for(int j = 0; j < m; j++)
                if(g[i][j] == 'S'){sx = i; sy = j;}
                else if(g[i][j] =='D'){dx = i; dy = j;}
                else if(g[i][j] == 'X') wall++;     
        }
        if(n * m - wall <= t) {printf("NO\n"); continue;}
        flag = 0; g[sx][sy] = 'X';
        DFS(sx, sy, 0);
        if(flag) printf("YES\n");
        else printf("NO\n");
    }
    return 0;
}
```


