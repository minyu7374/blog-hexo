---
title: "POJ 3436 ACM Computer Factory"
date: "2014-07-25T21:29:10+08:00"
categories:
tags:
---

                                            

Description

As you know, all the computers used for ACM contests must be identical, so the participants compete on equal terms. That is why all these computers are historically produced at the same factory.
Every ACM computer consists of P parts. When all these parts are present, the computer is ready and can be shipped to one of the numerous ACM contests.
Computer manufacturing is fully automated by using <em>N</em> various machines. Each machine removes some parts from a half-finished computer and adds some new parts (removing of parts is sometimes necessary as the parts cannot be added to a computer in
 arbitrary order). Each machine is described by its performance (measured in computers per hour), input and output specification.
Input specification describes which parts must be present in a half-finished computer for the machine to be able to operate on it. The specification is a set of <em>P</em> numbers 0, 1 or 2 (one number for each part), where 0 means that corresponding part
 must not be present, 1 — the part is required, 2 — presence of the part doesn't matter.
Output specification describes the result of the operation, and is a set of <em>P</em> numbers 0 or 1, where 0 means that the part is absent, 1 — the part is present.
The machines are connected by very fast production lines so that delivery time is negligibly small compared to production time.
After many years of operation the overall performance of the ACM Computer Factory became insufficient for satisfying the growing contest needs. That is why ACM directorate decided to upgrade the factory.
As different machines were installed in different time periods, they were often not optimally connected to the existing factory machines. It was noted that the easiest way to upgrade the factory is to rearrange production lines. ACM directorate decided to
 entrust you with solving this problem.

Input

Input file contains integers <em>P N</em>, then <em>N</em> descriptions of the machines. The description of <em>i</em>th machine is represented as by 2 <em>P</em> + 1 integers <em>Q<sub>i</sub> S<sub>i</sub></em><sub>,1</sub> <em>Si</em><sub>,2</sub>...<em>S<sub>i</sub></em><sub>,<em>P</em></sub> <em>D<sub>i</sub></em><sub>,1</sub> <em>D<sub>i</sub></em><sub>,2</sub>...<em>D<sub>i</sub></em><sub>,<em>P</em></sub>,
 where <em>Q<sub>i</sub></em> specifies performance, <em>S<sub>i</sub></em><sub>,<em>j</em></sub> — input specification for part <em>j</em>, <em>D<sub>i</sub></em><sub>,<em>k</em></sub> — output specification for part <em>k</em>.
<strong>Constraints</strong>
1 ≤ <em>P</em> ≤ 10, 1 ≤ <em>N </em>≤ 50, 1 ≤ <em>Q<sub>i</sub></em> ≤ 10000

Output

Output the maximum possible overall performance, then <em>M</em> — number of connections that must be made, then <em>M</em> descriptions of the connections. Each connection between machines <em>A</em> and <em>B</em> must be described by three positive numbers <em>A B W</em>,
 where <em>W</em> is the number of computers delivered from <em>A</em> to <em>B</em> per hour.
If several solutions exist, output any of them.

Sample Input
<strong>Sample input 1</strong>
3 4
15  0 0 0  0 1 0
10  0 0 0  0 1 1
30  0 1 2  1 1 1
3   0 2 1  1 1 1
<strong>Sample input 2</strong>
3 5
5   0 0 0  0 1 0
100 0 1 0  1 0 1
3   0 1 0  1 1 0
1   1 0 1  1 1 0
300 1 1 2  1 1 1
<strong>Sample input 3</strong>
2 2
100  0 0  1 0
200  0 1  1 1
Sample Output
<strong>Sample output 1</strong>
25 2
1 3 15
2 3 10
<strong>Sample output 2</strong>
4 5
1 3 3
3 5 3
1 2 1
2 4 1
4 5 1
<strong>Sample output 3</strong>
0 0


       不少人解决这个问题，方法是把工厂拆分成两个点。开始，我也是这样做的，可写好后一直找不到代码哪里错了，连样例的数据都过不了。后来又在一篇博客里看到了大神没拆分点的做法，感觉实现起来比拆分的简单多了。
```cpp
#include <cstdio>
#include <cstring>
#define inf 0x3f3f3f3f
#define maxn 55

int s, t, n, P, N;
int c[maxn][maxn], mark[maxn]; 
int queue[maxn], qs, qe;
int Q[maxn], speci[maxn][21];
int backup[maxn][maxn];
int links[maxn][3];

void init(){
    scanf("%d %d", &P, &N);
    memset(c, 0, sizeof(c));
    s = 0;  t = N + 1; n = N + 2; 

    for(int i = 1; i <= N; i++){
    	scanf("%d", Q + i);
        for(int j = 0; j < P + P ; j++)
            scanf("%d", &speci[i][j]); 
    }

    bool flag_s, flag_d;
    for(int i = 1; i <= N; i++){
        flag_s = flag_d = 1;
        for(int k = 0; k < P; k++){
            if(speci[i][k] == 1)   flag_s = 0;
            if(speci[i][P+k] == 0)  flag_d = 0;
        }
        if(flag_s)   c[s][i] = Q[i];
        if(flag_d)   c[i][t] = Q[i];

        bool flag = 1;
        for(int j = 1; j <= N; j++)
	    if(i != j){
                flag = 1;
                for(int k = 0; k < P && flag; k++)
		    if(speci[i][P+k] + speci[j][k] == 1)  flag = 0;
                if(flag)
		    c[i][j] = Q[i] < Q[j] ? Q[i] : Q[j]; 
            }
    }
}

int maxflow(){    
    int u, v, minflow, flow = 0;
    while(true){
        memset(mark, -1, sizeof(mark));
        qs = 0; queue[qs] = s; qe = 1;
        while(qs != qe){
            u = queue[qs]; qs = (qs + 1) % maxn;
            for(int i = 0; i < n  && mark[t] == -1; i++)
               if(c[u][i] > 0 && mark[i] == -1){
                    mark[i] = u;
                    queue[qe] = i; qe = (qe + 1) % maxn;
               }
        }

        if(mark[t]==-1) break;

        minflow = inf;
        for(u = mark[v = t]; v!=s; v = u, u = mark[v])
            if(c[u][v] < minflow)    minflow = c[u][v];            

        for(u = mark[v = t]; v != s; v = u,u = mark[v]){
            c[u][v] -= minflow;  
            c[v][u] += minflow;  
        }

        flow += minflow;  
    }
    return flow;
}

int main(){
    init();
    memcpy(backup, c, sizeof(c));

    int flow = maxflow(), line = 0;
    for(int i = 1; i <= N; i++) 
		for(int j = 1; j <= N; j++)
            if(c[i][j] < backup[i][j]){
                links[line][0] = i;    
                links[line][1] = j;
                links[line][2] = backup[i][j] - c[i][j];
                line++;
            }

    printf("%d %d\n", flow, line);
    for(int i = 0; i < line; i++)
    	printf("%d %d %d\n", links[i][0], links[i][1], links[i][2]);
    return 0;
