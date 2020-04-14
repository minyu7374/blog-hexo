---
title: "Leetcode #241 Different Ways to Add Parentheses"
date: "2015-07-29T16:26:25+08:00"
categories:
tags:
---

                                            
Given a string of numbers and operators, return all possible results from computing all the different possible ways to group numbers and operators. The valid operators are
<code>+</code>, <code>-</code> and <code>*</code>.

<strong>Example 1</strong>
Input: <code>"2-1-1"</code>.
((2-1)-1) = 0
(2-(1-1)) = 2
Output: <code>[0, 2]</code>

<strong>Example 2</strong>
Input: <code>"2*3-4*5"</code>
(2*(3-(4*5))) = -34
((2*3)-(4*5)) = -14
((2*(3-4))*5) = -10
(2*((3-4)*5)) = -10
(((2*3)-4)*5) = 10
Output: <code>[-34, -14, -10, -10, 10]</code>

<code></code>
<code>分治（</code>Divide and Conquer）
C++98版
```cpp
class Solution {
public:
    vector<int> diffWaysToCompute(string input) {
        vector<int> result;
        for (int i = 0; i < input.size(); i++) {
            char cur = input[i];
            if (cur == '+' || cur == '-' || cur == '*') {
                vector<int> result1 = diffWaysToCompute(input.substr(0, i));
                vector<int> result2 = diffWaysToCompute(input.substr(i+1));

                for ( vector<int>::iterator it1 = result1.begin(); it1 != result1.end(); it1 ++ ) {
                    for ( vector<int>::iterator it2 = result2.begin(); it2 != result2.end(); it2 ++ ){
                        if (cur == '+')
                            result.push_back(*it1 + *it2);
                        else if (cur == '-')
                            result.push_back(*it1 - *it2);
                        else
                            result.push_back(*it1 * (*it2));
                    }
                }
            }
        }

        if (result.empty())
            result.push_back(atoi(input));
        return result;
    }

    int atoi(string s){
        int result = 0;
        for(int i = 0; i < s.size(); i++){
            result = result * 10 + ( s[i] - '0');
        }
        return result;
    }

};
```
C++11 版
```cpp
class Solution {
public:
    vector<int> diffWaysToCompute(string input) {
        vector<int> result;
        int size = input.size();
        for (int i = 0; i < size; i++) {
            char cur = input[i];
            if (cur == '+' || cur == '-' || cur == '*') {
                vector<int> result1 = diffWaysToCompute(input.substr(0, i));
                vector<int> result2 = diffWaysToCompute(input.substr(i+1));
                for (auto n1 : result1) {
                    for (auto n2 : result2) {
                        if (cur == '+')
                            result.push_back(n1 + n2);
                        else if (cur == '-')
                            result.push_back(n1 - n2);
                        else
                            result.push_back(n1 * n2);
                    }
                }
            }
        }

        if (result.empty())
            result.push_back(atoi(input.c_str()));
        return result;
    }
};
```
<code></code>
