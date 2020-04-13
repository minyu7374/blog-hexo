---
title: "ZOJ 1654 Place the Robots"
date: "2014-07-17T18:33:33+08:00"
categories:
tags:
---

                                            

<center style="text-align:left;">URL: [http://acm.zju.edu.cn/onlinejudge/showProblem.do?problemId=654](http://acm.zju.edu.cn/onlinejudge/showProblem.do?problemId=654)</center>
<center style="font-family:Arial, Helvetica, Verdana, sans-serif;font-size:15px;">Place the Robots</center>

<hr style="font-family:Arial, Helvetica, Verdana, sans-serif;font-size:15px;" />Robert is a famous engineer. One day he was given a task by his boss. The background of the task was the following:


Given a map consisting of square blocks. There were three kinds of blocks: Wall, Grass, and Empty. His boss wanted to place as many robots as possible in the map. Each robot held a laser weapon which could shoot to four directions (north, east, south, west)
 simultaneously. A robot had to stay at the block where it was initially placed all the time and to keep firing all the time. The laser beams certainly could pass the grid of Grass, but could not pass the grid of Wall. A robot could only be placed in an Empty
 block. Surely the boss would not want to see one robot hurting another. In other words, two robots must not be placed in one line (horizontally or vertically) unless there is a Wall between them.


Now that you are such a smart programmer and one of Robert's best friends, He is asking you to help him solving this problem. That is, given the description of a map, compute the maximum number of robots that can be placed in the map.
<strong>

Input</strong>


The first line contains an integer T (<= 11) which is the number of test cases. 


For each test case, the first line contains two integers m and n (1<= m, n <=50) which are the row and column sizes of the map. Then m lines follow, each contains n characters of '#', '*', or 'o' which represent Wall, Grass, and Empty, respectively.

<strong>Output</strong>


For each test case, first output the case number in one line, in the format: "Case :id" where id is the test case number, counting from 1. In the second line just output the maximum number of robots that can be placed in that map.

<strong>Sample Input</strong>
2

4 4

o***

*###

oo#o

***o

4 4

#ooo

o#oo

oo#o

***#

<strong>Sample Output</strong>
Case :1

3

Case :2

5
       二分图最大匹配算法很简单，但却能高效地解决很多问题．它的代码写出来很容易，而且也很方便套用模板，可难的是要有足够的洞察力，将一些看似无关的实际问题通过某种方式的抽象和提取，转化为我们想要看到的二分图最大匹配问题．
       这道题,我最先是在一本图论算法书里看到的．也许，对于一些大神来说它是个很明显的二分匹配题，可对于我来说，如果没这本书，我不可能想到它可以用二分匹配解决．

　　其实,解题思路并不复杂，只是你要想得到才行:

　　在水平方向上，将每一行被墙隔住且包含空地的连续区域看作一"块"，显然在一块之中，最多只能放置一个robot．给这些块编上号；同样把垂直方向上的块也编上号．

　　这样做相当于将行和列进行拆分而重新编号，也即如果某一行（列）中有一堵墙，那么将墙前面和后面视为不同的一行（列）．拆分之后，对于任何一块空地，要独立占用一个行和一个列（意即：该行号和该列号所组成的＂坐标＂能唯一确定这块空地而不能再容纳其它空地）．对于每一块空地，将其所对应的行号和列号分为图的两个部分，构成二分图。二分图中边的含义就是某一行和某一列匹配．总而言之，一组边对应一组坐标，对应一个能够放置机器人的空地，所以最大匹配即为求解在每一行和每一列最多匹配一次的情况下最多能放置多少个robot。

　　代码：

　　
```cpp
#include <cstdio>
#include <cstring>
#define maxn 55
#define maxp 1255  //在水平方向或垂直方向最多能分50*25个块

char map[maxn][maxn];
int  xid[maxn][maxn], yid[maxn][maxn];
bool state[maxp], graph[maxp][maxp];
int  link[maxp];  
int  xn, yn;

bool find(int p){
    for(int i = 1; i <= yn; i++){
     	if(graph[p][i] && !state[i]){
            state[i] = 1;  
            int j = link[i];
            if( !j  || find(j) ){
                link[i] = p; return true;
            }
        }
    }
    return false;
}

int main(){
    int T, m, n, ans;
    scanf("%d", &T);
    for(int t = 1; t <= T; t++){
        scanf("%d %d", &m, &n);
        for(int i = 0; i < m; i++)
        	scanf("%s", map + i);
                 
        bool flag ;  xn = 0;
        memset(xid, 0, sizeof(xid));
        for(int i = 0; i < m; i++ ){
        	flag = 1;
        	for(int j = 0; j < n; j++)
        		if(map[i][j] == 'o'){
        			if(flag)  xn++;
        			xid[i][j] = xn; 
        			flag = 0;
        		}
        		else if(map[i][j] == '#')
        		    flag = 1;         		
        }
        yn = 0;
        memset(yid, 0, sizeof(yid));
        for(int i = 0; i < n; i++ ){
        	flag = 1; 
        	for(int j = 0; j < m; j++)
        		if(map[j][i] == 'o'){
        			if(flag)  yn++;
        			yid[j][i] = yn; 
        			flag = 0;
        		}
        		else if(map[j][i] == '#')
        		    flag = 1; 
        }

        memset(graph, 0, sizeof(graph));
        for(int i = 0; i < m; i++)
            for(int j = 0; j < n; j++)
                if(xid[i][j])
                     graph[ xid[i][j] ][ yid[i][j] ] = 1; 

        ans = 0;
        memset(link, 0, sizeof(link));
        for(int i = 1; i <= xn; i++){
	        memset(state, 0, sizeof(state));
                if(find(i))   ans++;   
	}

        printf("Case :%d\n%d\n", t, ans);    
    }    
    return 0;
} 
```

