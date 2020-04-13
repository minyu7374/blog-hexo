---
title: "LeetCode Best Time to Buy and Sell Stock 系列"
date: "2015-05-02T22:55:28+08:00"
categories:
tags:
---

                                            
121 Best Time to Buy and Sell Stock

Say you have an array for which the <em>i</em><sup>th</sup> element is the price of a given stock on day
<em>i</em>.
If you were only permitted to complete at most one transaction (ie, buy one and sell one share of the stock), design an algorithm to find the maximum profit.

```cpp
int maxProfit(int* prices, int pricesSize) {
    int low = *prices, ret = 0;
    for(int i = 1; i < pricesSize; i++){
        if(prices[i] < low ) low = prices[i];
        else ret =  ret > prices[i] - low ? ret : prices[i] - low;
    }
    return ret;
}
```
#122 Best Time to Buy and Sell Stock II

Say you have an array for which the <em>i</em><sup>th</sup> element is the price of a given stock on day
<em>i</em>.
Design an algorithm to find the maximum profit. You may complete as many transactions as you like (ie, buy one and sell one share of the stock multiple times). However, you may not engage in multiple transactions at the same time (ie, you must sell the stock
 before you buy again).
```cpp
int maxProfit(int* prices, int pricesSize) {
    int ret = 0;
    for(int i = 1; i < pricesSize; i++){
        ret += prices[i] - prices[i-1] > 0 ? prices[i] - prices[i-1] : 0;
    }
    return ret;
}
```

#123 Best Time to Buy and Sell Stock III

Say you have an array for which the <em>i</em><sup>th</sup> element is the price of a given stock on day
<em>i</em>.
Design an algorithm to find the maximum profit. You may complete at most <em>two</em> transactions.
<strong>Note:</strong>

You may not engage in multiple transactions at the same time (ie, you must sell the stock before you buy again).
```cpp
int maxProfit(int* prices, int pricesSize) {
	
	int i, j, tran1[pricesSize], tran2[pricesSize];
	int low = prices[0], high = prices[pricesSize - 1];
	tran1[0] = 0; tran2[pricesSize - 1] = 0;
    
	for(i = 1; i < pricesSize; i ++ ){
		if(prices[i] < low) low = prices[i];
		tran1[i] = prices[i] - low > tran1[i-1] ? prices[i] - low : tran1[i-1];
	}
	
	for(j = pricesSize - 2; j >= 0; j --){
		if(prices[j] > high) high = prices[j];
	    tran2[j] = high - prices[j] > tran2[j+1] ? high - prices[j] : tran2[j+1];
	}
	
	int ret = 0;
	for(i = 0; i < pricesSize; i ++){
            ret =  tran1[i] + tran2[i] > ret ? tran1[i] + tran2[i] : ret;
	}
	
	return ret;
}
```

#188 Best Time to Buy and Sell Stock IV

Say you have an array for which the <em>i</em><sup>th</sup> element is the price of a given stock on day
<em>i</em>.
Design an algorithm to find the maximum profit. You may complete at most <strong>
k</strong> transactions.
<strong>Note:</strong>

You may not engage in multiple transactions at the same time (ie, you must sell the stock before you buy again).


```cpp
int max(int x, int y) { return x > y ? x : y; }

int maxProfit(int k, int* prices, int pricesSize) {

    int i, j, ret = 0;

    if(k >= pricesSize){
        for(i = 1; i < pricesSize; i++)
            ret += prices[i] - prices[i - 1] > 0 ? prices[i] - prices[i - 1] : 0;
        return ret;
    }

    int local[k+1], global[k+1];
    for(i = 0; i <= k; i++){
        local[i] = global[i] = 0;
    }

    for(i = 1; i < pricesSize; i ++){
        for(j = k; j >= 1; j--) {
            local[j] = max( local[j] + prices[i] - prices[i-1], global[j-1] + max( prices[i] - prices[i-1], 0 ) );
            global[j] = max(local[j], global[j]);
        }
    }
    return global[k];
