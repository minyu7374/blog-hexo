---
title: "Leetcode #234  Palindrome Linked List"
date: "2015-08-01T16:57:07+08:00"
categories:
tags:
---

                                            
Given a singly linked list, determine if it is a palindrome.
<strong>Follow up:</strong>

Could you do it in O(n) time and O(1) space?
用o(n)的space来创建一个反向的链表，也能AC，时间是36ms，代码如下：

```cpp
class Solution {
public:
    bool isPalindrome(ListNode* head) {

        ListNode* reverse_head = reverseList(head);
        ListNode* original_point = head, * reverse_point = reverse_head;

        while(original_point != NULL){
            if (original_point -> val != reverse_point -> val) return false;
            original_point = original_point -> next;
            reverse_point = reverse_point -> next;
        }
        return true;
    }

    ListNode* reverseList(ListNode* head){

        if(head == NULL) return NULL;

        ListNode* reverse_cur, * reverse_pre;
        ListNode* original_point = head;

        reverse_cur = reverse_pre = new ListNode(original_point -> val);
        original_point = original_point -> next;
        while(original_point != NULL){
            reverse_pre = reverse_cur;
            reverse_cur = new ListNode(original_point -> val);
            reverse_cur -> next = reverse_pre;
            original_point = original_point -> next;
        }

        return reverse_cur;
    }

};
```

        但这不能满足题目要求，下面是满足空间复杂度要求，且效率更高(24ms)的代码：


```cpp
class Solution {
public:
    bool isPalindrome(ListNode* head) {

        //if(!head) return true;

        ListNode* fast, * slow, * pre, * cur;

        pre = NULL;
        fast = slow = head;
        bool isOdd = false;

        while (fast != NULL) {
            if(fast->next) {
                fast = fast->next->next;
            }
            else {
                fast = fast->next;
                isOdd = true;
            }

            cur = slow->next;
            slow-> next = pre;
            pre = slow;
            slow = cur;
        }

        if(isOdd) {
            if(pre -> next == NULL) return true;       //链表长度为1
            pre = pre -> next;
        }
        while(slow){
            if(slow -> val != pre -> val)
                return false;
            slow = slow -> next;
            pre = pre -> next;
        }
        return true;
    }
};
```

        代码中fast指针每次跳两步，而slow指针每次只走一步，这样就保证fast到达链表尾部时，slow刚好走了一半，同时在走的过程中使前半部分链表方向反转。之后就可以从中间向两边发散比较val值了。当然根据链表长度的奇偶性不同，比较时的出发点需要作出相应调整。
        还有一点要注意的是，链表长度为1 的情况，此时，判断 isOdd 为真后，若直接使 pre = pre -> next, 则在下面的val比较时会出现指针异常。所以代码中要加上对pre->next的判断，若为NULL,显然是链表长度为1 的情况，直接返回true。没加这句的代码提交了是会RE的。

