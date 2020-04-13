---
title: "POJ1466 Girls and Boys"
date: "2014-07-17T22:03:55+08:00"
categories:
tags:
---

                                            

Description
In the second year of the university somebody started a study on the romantic relations between the students. The relation "romantically involved" is defined between one girl and one boy. For the study reasons it is necessary to
 find out the maximum set satisfying the condition: there are no two students in the set who have been "romantically involved". The result of the program is the number of students in such a set.
Input
The input contains several data sets in text format. Each data set represents one set of subjects of the study, with the following description:


the number of students

the description of each student, in the following format

student_identifier:(number_of_romantic_relations) student_identifier1 student_identifier2 student_identifier3 ...

or

student_identifier:(0)


The student_identifier is an integer number between 0 and n-1 (n <=500 ), for n subjects.
Output
For each given data set, the program should write to standard output a line containing the result.
Sample Input
7
0: (3) 4 5 6
1: (2) 4 6
2: (0)
3: (0)
4: (2) 0 1
5: (1) 0
6: (2) 0 1
3
0: (2) 1 2
1: (1) 0
2: (1) 0
Sample Output
5
2


求最大点独立集,其实就是求 点的总数 - 最小点覆盖数(最大点独立集与最小点覆盖集互为补集), 而 最小点覆盖数 == 最大匹配,基本属于模板题,代码很好写,但因为一点小细节WA了两次,坑!

```cpp
#include <cstdio>
#include <cstring>

int n, link[505];
bool graph[505][505], state[505];  

bool find(int p){
    for(int i = 0; i < n; i++){
     	if(graph[p][i] && !state[i]){
            state[i] = 1;
            int j = link[i];
            if( j == -1 || find(j) ){
                link[i] = p; link[p] = i; //开始只写了link[i] = p, WA了两次
                return true; 
             }
        }
    }
    return false;
}

int main(){
    int  x, y, t, cot,ans; char c;
    while(~scanf("%d", &n)){
        cot = 0;
        memset(graph, 0, sizeof(graph)); 
        for(int i = 0; i < n; i++){
            scanf("%d%c%c%c%d%c", &x, &c, &c, &c, &t, &c);
            if(!t) cot++;
            while(t--){
                scanf("%d", &y);
                graph[x][y] = 1;
            }   
        }
        ans = n;
        memset(link, -1, sizeof(link));
        for(int i = 0; i < n; i++){
            if(link[i] == -1){
	        memset(state, 0, sizeof(state));
                if(find(i)) ans--;   
	    }
        }
	printf("%d\n", ans);    
    }    
    return 0;
} 
```











































































