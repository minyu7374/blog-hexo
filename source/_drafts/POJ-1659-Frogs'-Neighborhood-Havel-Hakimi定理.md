---
title: "POJ 1659 Frogs' Neighborhood Havel-Hakimi定理"
date: "2014-07-27T19:58:34+08:00"
categories:
tags:
---

                                            
URL: [http://poj.org/problem?id=1659](http://poj.org/problem?id=1659)
Description

未名湖附近共有<em>N</em>个大小湖泊<em>L</em><sub>1</sub>, <em>L</em><sub>2</sub>, ..., <em>L<sub>n</sub></em>(其中包括未名湖)，每个湖泊<em>L<sub>i</sub></em>里住着一只青蛙<em>F<sub>i</sub></em>(1 ≤ <em>i</em> ≤ <em>N</em>)。如果湖泊<em>L<sub>i</sub></em>和<em>L<sub>j</sub></em>之间有水路相连，则青蛙<em>F<sub>i</sub></em>和<em>F<sub>j</sub></em>互称为邻居。现在已知每只青蛙的邻居数目<em>x</em><sub>1</sub>, <em>x</em><sub>2</sub>,
 ..., <em>x<sub>n</sub></em>，请你给出每两个湖泊之间的相连关系。

Input

第一行是测试数据的组数<em>T</em>(0 ≤ <em>T</em> ≤ 20)。每组数据包括两行，第一行是整数N(2 < <em>N</em> < 10)，第二行是<em>N</em>个整数，<em>x</em><sub>1</sub>, <em>x</em><sub>2</sub>,..., <em>x</em><sub>n</sub>(0 ≤ <em>x<sub>i</sub></em> ≤ <em>N</em>)。

Output

对输入的每组测试数据，如果不存在可能的相连关系，输出"NO"。否则输出"YES"，并用<em>N</em>×<em>N</em>的矩阵表示湖泊间的相邻关系，即如果湖泊<em>i</em>与湖泊<em>j</em>之间有水路相连，则第<em>i</em>行的第<em>j</em>个数字为1，否则为0。每两个数字之间输出一个空格。如果存在多种可能，只需给出一种符合条件的情形。相邻两组测试数据之间输出一个空行。

Sample Input
3
7
4 3 1 5 4 2 1 
6
4 3 1 4 2 0 
6
2 3 1 1 2 1 

Sample Output
YES
0 1 0 1 1 0 1 
1 0 0 1 1 0 0 
0 0 0 1 0 0 0 
1 1 1 0 1 1 0 
1 1 0 1 0 1 0 
0 0 0 1 1 0 0 
1 0 0 0 0 0 0 

NO

YES
0 1 0 0 1 0 
1 0 0 1 1 0 
0 0 0 0 0 1 
0 1 0 0 0 0 
1 1 0 0 0 0 
0 0 1 0 0 0 
   Havel-Hakimi定理：由非负整数组成的非增序列S：d1,d2,d3………dn（n >= 2，d1 >= 1）是可图的，当且仅当序列S1：d2 - 1, d3 - 1， ………… d（d1 + 1）-1，d（d1 + 2）…………dn 是可图的。
   利用此定理不仅可以判断一个序列是否可图，还能将构造出满足此序列的图，代码如下：
```cpp
#include <cstdio>
#include <cstring>
#include <algorithm>

struct ver{
    int degree, index;
}v[12];
int edge[12][12];

bool cmp(ver a, ver b){
    return a.degree > b.degree;
} 

int main(){
	int t, n;
	scanf("%d", &t);
	while(t--){
		scanf("%d", &n);
		for(int  i = 0; i < n; i++){
		    scanf("%d", &v[i].degree);
			v[i].index = i;
		}
		memset(edge, 0, sizeof(edge));
		bool flag = 1;  int count;
		for(int i = 0; i < n && flag; i++){
			std::sort(v + i, v + n, cmp);
			count = v[i].degree;
			if(count > n - i - 1) {flag = 0; break;} 
			for(int j = 1; j <= count; j++){
			    if(v[i+j].degree < 1) {flag = 0; break;}
				v[i+j].degree--;
				edge[ v[i].index ][ v[i+j].index ] = edge[ v[i+j].index ][ v[i].index ] = 1;
			}
		}
        if(flag){
		    printf("YES\n");
			for(int i = 0; i < n; i ++){
			    for(int j = 0; j < n - 1; j++)
					printf("%d ", edge[i][j]);
				printf("%d\n", edge[i][n-1]);
			}
			printf("\n");
		}
		else
			printf("NO\n\n");
	}
    return 0;
}
```


