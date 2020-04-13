---
title: "uva10910 - Marks Distribution"
date: "2014-07-14T15:39:11+08:00"
categories:
tags:
---

                                            
URL:[ http://uva.onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=1851](http://uva.onlinejudge.org/index.php?option=com_onlinejudge&Itemid=8&page=show_problem&problem=1851)

In an examination one student appeared in <strong>N</strong> subjects and has got total <strong>T</strong> marks. He has passed in all the <strong>N</strong> subjects where minimum
 mark for passing in each subject is <strong>P</strong>. You have to calculate the number of ways the student can get the marks. For example, if <strong>N=3</strong>, <strong>T=34</strong> and <strong>P=10</strong>then the marks in the three subject could be
 as follows.
<table border="1" cellspacing="0" cellpadding="0" style="font-family:'Times New Roman';"><tbody><tr><td width="30" valign="top" class="Normal"> </td>
<td width="90" valign="top" class="Normal">
<strong>Subject 1</strong>
</td>
<td width="108" valign="top" class="Normal">
<strong>Subject 2</strong>
</td>
<td width="84" valign="top" class="Normal">
<strong>Subject 3</strong>
</td>
</tr><tr><td width="30" valign="top" class="Normal">
1
</td>
<td width="90" valign="top" class="Normal">
14
</td>
<td width="108" valign="top" class="Normal">
10
</td>
<td width="84" valign="top" class="Normal">
10
</td>
</tr><tr><td width="30" valign="top" class="Normal">
2
</td>
<td width="90" valign="top" class="Normal">
13
</td>
<td width="108" valign="top" class="Normal">
11
</td>
<td width="84" valign="top" class="Normal">
10
</td>
</tr><tr><td width="30" valign="top" class="Normal">
3
</td>
<td width="90" valign="top" class="Normal">
13
</td>
<td width="108" valign="top" class="Normal">
10
</td>
<td width="84" valign="top" class="Normal">
11
</td>
</tr><tr><td width="30" valign="top" class="Normal">
4
</td>
<td width="90" valign="top" class="Normal">
12
</td>
<td width="108" valign="top" class="Normal">
11
</td>
<td width="84" valign="top" class="Normal">
11
</td>
</tr><tr><td width="30" valign="top" class="Normal">
5
</td>
<td width="90" valign="top" class="Normal">
12
</td>
<td width="108" valign="top" class="Normal">
10
</td>
<td width="84" valign="top" class="Normal">
12
</td>
</tr><tr><td width="30" valign="top" class="Normal">
6
</td>
<td width="90" valign="top" class="Normal">
11
</td>
<td width="108" valign="top" class="Normal">
11
</td>
<td width="84" valign="top" class="Normal">
12
</td>
</tr><tr><td width="30" valign="top" class="Normal">
7
</td>
<td width="90" valign="top" class="Normal">
11
</td>
<td width="108" valign="top" class="Normal">
10
</td>
<td width="84" valign="top" class="Normal">
13
</td>
</tr><tr><td width="30" valign="top" class="Normal">
8
</td>
<td width="90" valign="top" class="Normal">
10
</td>
<td width="108" valign="top" class="Normal">
11
</td>
<td width="84" valign="top" class="Normal">
13
</td>
</tr><tr><td width="30" valign="top" class="Normal">
9
</td>
<td width="90" valign="top" class="Normal">
10
</td>
<td width="108" valign="top" class="Normal">
10
</td>
<td width="84" valign="top" class="Normal">
14
</td>
</tr><tr><td width="30" valign="top" class="Normal">
10
</td>
<td width="90" valign="top" class="Normal">
11
</td>
<td width="108" valign="top" class="Normal">
12
</td>
<td width="84" valign="top" class="Normal">
11
</td>
</tr><tr><td width="30" valign="top" class="Normal">
11
</td>
<td width="90" valign="top" class="Normal">
10
</td>
<td width="108" valign="top" class="Normal">
12
</td>
<td width="84" valign="top" class="Normal">
12
</td>
</tr><tr><td width="30" valign="top" class="Normal">
12
</td>
<td width="90" valign="top" class="Normal">
12
</td>
<td width="108" valign="top" class="Normal">
12
</td>
<td width="84" valign="top" class="Normal">
10
</td>
</tr><tr><td width="30" valign="top" class="Normal">
13
</td>
<td width="90" valign="top" class="Normal">
10
</td>
<td width="108" valign="top" class="Normal">
13
</td>
<td width="84" valign="top" class="Normal">
11
</td>
</tr><tr><td width="30" valign="top" class="Normal">
14
</td>
<td width="90" valign="top" class="Normal">
11
</td>
<td width="108" valign="top" class="Normal">
13
</td>
<td width="84" valign="top" class="Normal">
10
</td>
</tr><tr><td width="30" valign="top" class="Normal">
15
</td>
<td width="90" valign="top" class="Normal">
10
</td>
<td width="108" valign="top" class="Normal">
14
</td>
<td width="84" valign="top" class="Normal">
10
</td>
</tr></tbody></table>So there are 15 solutions. So <strong>F (3, 34, 10) = 15</strong>.
<strong>Input</strong>
In the first line of the input there will be a single positive integer <strong>K</strong> followed by <strong>K</strong> lines each containing a single test case. Each test case contains
 three positive integers denoting <strong>N</strong>, <strong>T</strong> and <strong>P</strong> respectively. The values of <strong>N</strong>, <strong>T</strong> and <strong>P</strong> will be at most 70. You may assume that the final answer will fit in a
 standard 32-bit integer.
<strong>Output</strong>
For each input, print in a line the value of <strong>F (N, T, P)</strong>.
<table width="100%" border="1" cellpadding="0" cellspacing="0" style="font-family:'Times New Roman';"><tbody><tr><td width="50%" valign="top" class="Normal">
<strong>Sample Input</strong>
</td>
<td width="50%" valign="top" class="Normal">
<strong>Output for Sample Input</strong>
</td>
</tr><tr><td valign="top" class="Normal">
<strong>2
3 34 10
3 34 10</strong>
</td>
<td valign="top" class="Normal">
<strong>15
15</strong>
</td>
</tr></tbody></table> 




```cpp
#include <cstdio>
int k, n, t, p, dp[75][75];
int main(){
	scanf("%d", &k);
    while(k--){
        scanf("%d %d %d", &n, &t, &p);
        for(int i = p; i <= t; i++)
            dp[1][i] = 1;
        for(int i = 2; i <= n; i++)
        	for(int j = p; j <= t; j++){
        		dp[i][j] = 0;
        		for(int k = p; k <= j-p; k++)
        			if(j-k >= p)
        				dp[i][j] += dp[i-1][j-k];
        	}
        printf("%d\n", dp[n][t]);
    }
    return 0;
}
```



