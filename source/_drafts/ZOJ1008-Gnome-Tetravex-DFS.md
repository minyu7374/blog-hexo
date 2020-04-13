---
title: "ZOJ1008 Gnome Tetravex DFS"
date: "2014-08-10T10:47:46+08:00"
categories:
tags:
---

                                            
URL: [http://acm.zju.edu.cn/onlinejudge/showProblem.do?problemCode=1008](http://acm.zju.edu.cn/onlinejudge/showProblem.do?problemCode=1008)
Time Limit: 10 Seconds      Memory
 Limit: 32768 KB


Hart is engaged in playing an interesting game, Gnome Tetravex, these days. In the game, at the beginning, the player is given n*n squares. Each square is divided into four triangles marked four numbers (range from 0 to 9). In a square, the triangles are the
 left triangle, the top triangle, the right triangle and the bottom triangle. For example, Fig. 1 shows the initial state of 2*2 squares.


<img src="http://acm.zju.edu.cn/onlinejudge/showImage.do?name=0000%2F1008%2F1008-1.jpg" width="238" height="196" alt="" />
Fig. 1 The initial state with 2*2 squares


The player is required to move the squares to the termination state. In the termination state, any two adjoining squares should make the adjacent triangle marked with the same number. Fig. 2 shows one of the termination states of the above example.



<img src="http://acm.zju.edu.cn/onlinejudge/showImage.do?name=0000%2F1008%2F1008-2.jpg" width="232" height="198" alt="" />
Fig. 2 One termination state of the above example



It seems the game is not so hard. But indeed, Hart is not accomplished in the game. He can finish the easiest game successfully. When facing with a more complex game, he can find no way out.



One day, when Hart was playing a very complex game, he cried out, "The computer is making a goose of me. It's impossible to solve it." To such a poor player, the best way to help him is to tell him whether
 the game could be solved. If he is told the game is unsolvable, he needn't waste so much time on it.




<strong></strong>
Input



The input file consists of several game cases. The first line of each game case contains one integer n, 0 <= n <= 5, indicating the size of the game.



The following n*n lines describe the marking number of these triangles. Each line consists of four integers, which in order represent the top triangle, the right triangle, the bottom triangle and the
 left triangle of one square.



After the last game case, the integer 0 indicates the termination of the input data set.




<strong></strong>
Output



You should make the decision whether the game case could be solved. For each game case, print the game number, a colon, and a white space, then display your judgment. If the game is solvable, print the
 string "Possible". Otherwise, please print "Impossible" to indicate that there's no way to solve the problem.



Print a blank line between each game case.



Note: Any unwanted blank lines or white spaces are unacceptable.




<strong></strong>
Sample Input



2

5 9 1 4

4 4 5 6

6 8 5 4

0 4 4 3

2

1 1 1 1

2 2 2 2

3 3 3 3

4 4 4 4

0




<strong></strong>
Output for the Sample Input



Game 1: Possible


Game 2: Impossible





        简单的DFS问题，代码里唯一的剪枝优化是将相同的正方形记录在同一个数组元素里，这样在搜索过程中可避免对相同正方形的反复检测。

     ```cpp
#include <cstdio>
#include <cstring>

struct square{
    int u, r, l, d;
    int num;
}s[25];
bool flag;
int n, nn, cnt;
int step[26];

bool ok(int index, int pos){
    if(pos / n == 0) {if( s[ step[pos-1] ].r == s[index].l ) return true;}
    else if(pos % n == 0) {if( s[ step[pos-n] ].d == s[index].u ) return true;}
    else if(s[step[pos-1]].r == s[index].l && s[step[pos - n]].d == s[index].u) return true;
    return false;
}

void DFS(int index, int pos){
    if(pos == nn - 1) {flag = true; return;} 
    step[pos] = index;
    for(int i = 0; i < cnt; i++)
	if(s[i].num > 0)
	    if(ok(i, pos + 1)){
	        s[i].num--;
		DFS(i, pos + 1);
		if(flag) return;
		s[i].num++;
	    }
}

int main(){
    int u, r, l, d;
    int i, j, g = 0;
    while(~scanf("%d", &n) && n){
	nn = n * n; cnt = 0;
	std::memset(s, 0, sizeof(s));
	for(i = 0; i < nn; i++){
	    scanf("%d %d %d %d", &u, &r, &d, &l);
	    for(j = 0; j < cnt; j++)
		if(s[j].u == u && s[j].r == r && s[j].d == d && s[j].l == l){
		    s[j].num++; break;
		}
            if(j == cnt){
		s[cnt].u = u; s[cnt].r = r; s[cnt].d = d; s[cnt].l = l;
		s[cnt].num = 1; cnt += 1;
	    }
	}
        for(i = 0; i < cnt; i++){
	    flag = false;
            s[i].num--;
	    DFS(i, 0); 
	    if(flag){
		if(++g != 1)  printf("\n");
		printf("Game %d: Possible\n", g); break;
	    }
	    s[i].num++;
	}
        if(i == cnt){
            if(++g != 1) printf("\n");
		printf("Game %d: Impossible\n", g);
	}
    }
    return 0;
}
```



<hr style="text-align:left;font-family:Arial, Helvetica, Verdana, sans-serif;font-size:15px;" />



