---
title: "UVA10944 - Nuts for nuts.. 状态压缩"
date: "2014-05-13T21:22:29+08:00"
categories:
tags:
---

                                            
原题链接  [
http://uva.onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&category=21&page=show_problem&problem=1885](http://uva.onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&category=21&page=show_problem&problem=1885)




##                                        Nuts for nuts..
So as Ryan and Larry decided that they don't really taste so good, they realized that there are some nuts located in certain places of the island.. and they love them! Since they're lazy, but greedy, they want to know the shortest tour that they
 can use to gather every single nut!

Can you help them? 

### Input
You'll be given <strong>x</strong>, and <strong>y</strong>, both less than 20, followed by x lines of y characters each as a map of the area, consisting sorely
 of ".", "#", and "L". Larry and Ryan are currently located in "L", and the nuts are represented by "#". They can travel in all 8 adjacent direction in one step. See below for an example. There will be at most 15 places where there are nuts, and "L" will only
 appear once.
### Output
On each line, output the minimum amount of steps starting from "L", gather all the nuts, and back to "L". 

### Sample Input
5 5
L....
#....
#....
.....
#....
5 5
L....
#....
#....
.....
#....

### Sample Output
8
8

Larry and Ryan will go south for a nut, then south again for another nut, then south twice for another nut, and then back where they are.




       题目中最多有15个位置有nuts，加上“ L”，亦即最多有16个有意义的位置（对于选择最短路径而言其它位置无需考虑）。用 1 和 0 分别表示每个位置在某一决策状态之下是否已被访问过（即曾到此点采到nuts），也就可以用16位以内的二进制数来表示所有可能的状态，这个数据并不算大，在题目要求的时间内还是可以解决问题的。注意题目中 Ryan and Larry 是可以沿对角线走的，这样两点之间的最短距离将会是对应 x、y 坐标差值中的最大值。"L"位置用 0 表示，用 f{i,j} 表示在 j
 状态下且最后一个被访问的位置是 i 所需的最短路径，则 f {i,111·····111}即为从起点出发采集所有所有 nuts 且最后一个被采集的位置是 i 的最短路径。用 map{i,j} 表示 i 、j 两点之间的距离，那么 min{  f {i,111·····111}+map{i,0} ，0<i<=num(nuts总数)  }即为所求。
代码如下：




```cpp
#include <cstdio>
#include <cstring>
#define max(a,b) ((a) > (b) ? (a) : (b))

const int inf = 0x3f3f3f3f;
int map[20][20];
int f[20][1 << 20];
struct  point{
    int x;
    int y;
}nut[20];

inline int abs(int x) {return  x >= 0 ? x : -x;}
inline int update(int &x, int y) {if(x > y)  x = y;}

int main(){
     int x, y;  char temp[25];
     while(~scanf("%d %d", &x,&y)){
          int num = 0;
          for(int i = 0; i < x; i ++){
               scanf("%s", temp);
               for(int j = 0; j < y; j++)
                    if(temp[j] == '#')  {nut[++num].x = i; nut[num].y = j;}
                    else if(temp[j] == 'L')   {nut[0].x = i; nut[0].y = j;}
      }
          if(num == 0) {printf("0\n"); continue;}
          for(int i = 0; i <= num; i++)
               for(int j = i; j <= num; j++){
             map[i][j] = map[j][i] = max(abs( nut[i].x - nut[j].x ),abs( nut[i].y - nut[j].y ));
          }
          int max_status = (1 << num) - 1;
          for(int i = 0; i <= num; i++)
                for(int j = 0; j <= max_status; j++)
                      f[i][j] = inf;
          for(int i = 1; i <= num; i++)
               f[i][1 << (i - 1)] =  map[0][i];       
          for(int i = 0; i <= max_status; i++)
               for(int j = 1; j <= num; j++)
                    if(i & (1 << (j -1)))
                         for(int k = 1; k <= num; k++)
                               if(!(i & (1 << (k - 1))))
                                     update( f[k][i + (1 << (k - 1))] ,f[j][i] + map[j][k] );
          int ans = inf;
          for(int i = 1; i <= num; i++)
                update(ans , f[i][max_status] + map[0][i]);
          printf("%d\n", ans);
     }
     return 0;
}

```




