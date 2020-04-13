---
title: "Leetcode  Basic Calculator 系列"
date: "2015-08-02T13:25:46+08:00"
categories:
tags:
---

                                            
很经典的stack应用，为了省事儿，不再自己写stack了。


#### <a class="inline-wrap" href="https://leetcode.com/problems/basic-calculator/" rel="nofollow">Leetcode #224 Basic Calculator</a>

Implement a basic calculator to evaluate a simple expression string.
The expression string may contain open <code>(</code> and closing parentheses <code>
)</code>, the plus <code>+</code> or minus sign <code>-</code>, <strong>non-negative</strong> integers and empty spaces
<code></code>.
You may assume that the given expression is always valid.
Some examples:

"1 + 1" = 2
" 2-1 + 2 " = 3
"(1+(4+5+2)-3)+(6+8)" = 23

<strong>Note: Do not</strong> use the <code>eval</code> built-in library function.


```cpp
class Solution {
public:
    int calculate(string s){
        s += ')';
        stack<int> nums;
        stack<char> opts;
        int index = 0;
        opts.push('(');
        //nums.push(0);   //对于空字符串的处理
        while (index < s.size()) {
            char c = s[index++];
            if (isSpace(c)) continue;
            else if (isOpt(c)) {
                char pre_c = opts.top();
                while (priority(pre_c, c) == 1){
                    int second = nums.top(); nums.pop();
                    int first = nums.top(); nums.pop();
                    opts.pop();
                    switch(pre_c){
                        case '+' :
                          nums.push(first + second);  break;
                        case '-':
                          nums.push(first - second);  break;
                    }
                    pre_c = opts.top();
                }
                if (priority(pre_c, c) == 0) opts.pop();
                else opts.push(c);
            }
            else{
                int n = ctoi(c);
                while(isNum(s[index]))
                    n = n * 10 + ctoi(s[index++]);
                nums.push(n);
            }
        }
        return nums.top();
    }
private:
    bool isSpace(char c){
        return c == ' ';
    }
    bool isOpt(char c){
        return c == '+' || c == '-' || c == '(' || c == ')';
    }
    bool isNum(char c){
        return c >= '0' && c <= '9';
    }
    int ctoi(char c){
        return c - '0' + 0;
    }
    int priority(char c1, char c2){
        if (c1 == '(')
            if(c2 == ')')  return 0;
            else return -1;
        if(c2 == '(') return -1;
        return 1;
    }
};
```

#### <a class="inline-wrap" href="https://leetcode.com/problems/basic-calculator-ii/" rel="nofollow">Leetcode227 Basic Calculator II</a>

Implement a basic calculator to evaluate a simple expression string.
The expression string contains only <strong>non-negative</strong> integers, <code>
+</code>, <code>-</code>, <code>*</code>, <code>/</code> operators and empty spaces<code></code>. The integer division should truncate toward zero.
You may assume that the given expression is always valid.
Some examples:

"3+2*2" = 7
" 3/2 " = 1
" 3+5 / 2 " = 5

<strong>Note: Do not</strong> use the <code>eval</code> built-in library function.

```cpp
class Solution {
public:
    int calculate(string s){
        s += '#';
        stack<int> nums;
        stack<char> opts;
        int index = 0;
        opts.push('#');
       // nums.push(0);   //对于空字符串的处理
        while (index < s.size()) {
            char c = s[index++];
            if (isSpace(c)) continue;
            else if (isOpt(c)) {
                char pre_c = opts.top();
                while (priority(pre_c, c)){
                    int second = nums.top(); nums.pop();
                    int first = nums.top(); nums.pop();
                    opts.pop();
                    switch(pre_c){
                        case '*' :
                          nums.push(first * second);  break;
                        case '/' :
                          nums.push(first / second);  break;
                        case '+' :
                          nums.push(first + second);  break;
                        case '-':
                          nums.push(first - second);  break;
                    }
                    pre_c = opts.top();
                }
                opts.push(c);
            }
            else{
                int n = ctoi(c);
                while(isNum(s[index]))
                    n = n * 10 + ctoi(s[index++]);
                nums.push(n);
            }
        }
        return nums.top();
    }
private:
    bool isSpace(char c){
        return c == ' ';
    }
    bool isOpt(char c){
        return c == '+' || c == '-' || c == '*' || c == '/' || c== '#';
    }
    bool isNum(char c){
        return c >= '0' && c <= '9';
    }
    int ctoi(char c){
        return c - '0' + 0;
    }
    bool priority(char c1, char c2){
        if (c1 == '#') return false;
        if (c2 == '#') return true;
        if (c1 == '*' || c1 == '/') return true;
        if (c1 == '+' || c1 == '-')
            if (c2 == '*' || c2 =='/') return false;
            else return true;
    }
};
```

