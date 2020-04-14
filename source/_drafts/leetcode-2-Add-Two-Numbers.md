---
title: "leetcode #2 Add Two Numbers"
date: "2015-03-22T17:28:00+08:00"
categories:
tags:
---

                                            
You are given two linked lists representing two non-negative numbers. The digits are stored in reverse order and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.


Input: (2 -> 4 -> 3) + (5 -> 6 -> 4) Output: 7 -> 0 -> 8


简单的模拟就行了

Language: cpp Runtime: 71 ms



```cpp
/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode(int x) : val(x), next(NULL) {}
 * };
 */
class Solution {
	public:
	    ListNode *addTwoNumbers(ListNode *l1, ListNode *l2) {
            
			int val = l1 -> val + l2 -> val, ac = 0;
            if(val > 9){
			    ac = 1; val -= 10;
			}
            ListNode *head = new ListNode(val);
			ListNode *tail = head;
			l1 = l1 -> next; l2 = l2 -> next;

			while(l1 != NULL && l2 != NULL){
			    val = l1 -> val + l2 -> val + ac;
				if(val > 9){
				    ac = 1; val -= 10;
				}
				else{
				   ac = 0;
				}

				tail -> next = new ListNode(val);
				tail = tail-> next;
				l1 = l1 -> next; l2 = l2 -> next;				
			}
            l1 = l1 == NULL ? l2 : l1;
            if(l1 == NULL){
				if(ac == 1){
			        tail -> next = new ListNode(1);
				}
                return head;
			}
			while(l1 != NULL){
		        val = l1 -> val + ac;
				if(val > 9){
					ac = 1; val -= 10;
				}
				else{
	                ac = 0;											        
				}
				tail -> next = new ListNode(val);
				tail = tail-> next;
				l1 = l1 -> next;
			}
            if(ac == 1){
			    tail -> next = new ListNode(1);
			}
			return head;
	    }

};
```



