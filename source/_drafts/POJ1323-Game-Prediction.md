---
title: "POJ1323 Game Prediction"
date: "2014-07-16T20:58:38+08:00"
categories:
tags:
---

                                            
Description

Suppose there are M people, including you, playing a special card game. At the beginning, each player receives N cards. The pip of a card is a positive integer which is at most N*M. And there are no two cards with the same pip. During a round, each player chooses
 one card to compare with others. The player whose card with the biggest pip wins the round, and then the next round begins. After N rounds, when all the cards of each player have been chosen, the player who has won the most rounds is the winner of the game. 




Given your cards received at the beginning, write a program to tell the maximal number of rounds that you may at least win during the whole game. 

Input

The input consists of several test cases. The first line of each case contains two integers m (2?20) and n (1?50), representing the number of players and the number of cards each player receives at the beginning of the game, respectively. This followed by
 a line with n positive integers, representing the pips of cards you received at the beginning. Then a blank line follows to separate the cases. 


The input is terminated by a line with two zeros. 

Output

For each test case, output a line consisting of the test case number followed by the number of rounds you will at least win during the game. 


Sample Input
2 5
1 7 2 10 9

6 11
62 63 54 66 65 61 57 56 50 53 48

0 0

Sample Output
Case 1: 2
Case 2: 4


   这虽然是个水题，但还有点意思，一般的贪心题都是在贪着尽可能收获多，代价少，而这个贪的是赢得最少……分析第二个例子，66、65肯定都能赢，由于没有64, 61、62、63中至少有2个能赢。由此设计解题方案：从m*n开始向下遍历，看自己是否有此数字，能帮自己赢得一场，对没有的数字，用自己剩下最大的数字抵消，这样能使自己最小程度的赢得游戏。代码如下:
```cpp
#include <cstdio>
#include <algorithm>
int card[55];
int main(){
    int n, m, cot, ans, cases = 0;
    while(~scanf("%d %d", &m, &n) && m && n){
        for(int i = 1; i <= n; i++)
            scanf("%d", card + i);
        std::sort(card + 1, card + n + 1);
        cot = 0; ans = 0;
        for(int i = m * n; i > 0 && n > 0; i--){
            if(card[n] != i)
                cot++;
            else{
                if(cot)  cot--;
                else  ans++;
                n--;
           }
        }
        printf("Case %d: %d\n", ++cases, ans);
    }
    return 0;
}
```
