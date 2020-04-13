---
title: "ZOJ1649 Rescue 路径深度图算法"
date: "2014-08-11T18:12:05+08:00"
categories:
tags:
---

                                            

<center style="text-align:left;font-family:Arial, Helvetica, Verdana, sans-serif;font-size:15px;">
URL: [http://acm.zju.edu.cn/onlinejudge/showProblem.do?problemCode=1649](http://acm.zju.edu.cn/onlinejudge/showProblem.do?problemCode=1649)</center>
<center style="text-align:left;font-family:Arial, Helvetica, Verdana, sans-serif;font-size:15px;">

</center>
<center style="font-family:Arial, Helvetica, Verdana, sans-serif;font-size:15px;"></center>

Angel was caught by the MOLIGPY! He was put in prison by Moligpy. The prison is described as a N * M (N, M <= 200) matrix. There are WALLs, ROADs, and GUARDs in the prison.
Angel's friends want to save Angel. Their task is: approach Angel. We assume that "approach Angel" is to get to the position where Angel stays. When there's a guard in the grid, we must
 kill him (or her?) to move into the grid. We assume that we moving up, down, right, left takes us 1 unit time, and killing a guard takes 1 unit time, too. And we are strong enough to kill all the guards.
You have to calculate the minimal time to approach Angel. (We can move only UP, DOWN, LEFT and RIGHT, to the neighbor grid within bound, of course.)

<strong>Input</strong>
First line contains two integers stand for N and M.
Then N lines follows, every line has M characters. "." stands for road, "a" stands for Angel, and "r" stands for each of Angel's friend.
Process to the end of the file.

<strong>Output</strong>
For each test case, your program should output a single integer, standing for the minimal time needed. If such a number does no exist, you should output a line containing "Poor ANGEL
 has to stay in the prison all his life."

<strong>Sample Input</strong>
7 8 

#.#####. 

#.a#..r. 

#..#x... 

..#..#.# 

#...##.. 

.#...... 

........

<strong>Sample Output</strong>
13
        本题适宜用BFS算法求解，而一般的BFS算法得到的最优解是步数最少的解，由于到达不同的方格花费的时间不同，步数最少的解未必是本题的最优解，因此算法需要一些调整。如果通过广搜把所有可能的路径找到并记录时间，然后再把其中的最小时间输出，程序效率会很低。解决方案是通过维护一个关于求解到的时间的优先队列进行剪枝，大量减少搜索负担。
        因为去年做一个迷宫游戏的课程设计时接触到了路径深度图算法，而此算法的理解和实现都比较简单，且算法时间复杂度也不高，所以做此类问题我优先选择此算法，这次也不列外。


```cpp
#include <cstdio> 
#include <cstring>
#define inf 0x3f3f3f3f

int n, m, dx, dy;
char map[210][210];
int time[210][210];

inline int min(int x, int y) {return x < y ? x : y;}

int main(){
    while(~scanf("%d %d", &n, &m)){
	    for(int i = 0; i < n; i++)
			scanf("%s", map + i);
		memset(time, 0x3f, sizeof(time));
		for(int i = 0; i < n; i++)
			for(int j = 0; j < m; j++)
				if(map[i][j] == 'r') time[i][j] = 0;
		        else if(map[i][j] == 'a') {dx = i; dy = j;}
		bool flag = true; int mint, add;
		while(flag){
		   flag = false;
		   for(int i = 0; i < n; i++)
			   for(int j = 0; j < m; j++)
				   if(map[i][j] != '#'){
					   if(map[i][j] == 'x')  add = 2;
					   else add = 1;
			           mint = time[i][j]; 
				       if(i - 1 >= 0 && map[i-1][j] != '#') 
						   mint = min(mint, time[i-1][j] + add);
					   if(i + 1 < n  && map[i+1][j] != '#')
						   mint = min(mint, time[i+1][j] + add);
					   if(j - 1 >= 0 && map[i][j-1] != '#')
						   mint = min(mint, time[i][j-1] + add);
					   if(j + 1 < m && map[i][j+1] != '#')
						   mint = min(mint, time[i][j+1] + add);
                       if(mint < time[i][j]){
					       time[i][j] = mint; flag = true;
					   }
				   }			   
		}
		if(time[dx][dy] != inf) printf("%d\n", time[dx][dy]);
		else printf("Poor ANGEL has to stay in the prison all his life.\n");
	}
	return 0;
}
```
