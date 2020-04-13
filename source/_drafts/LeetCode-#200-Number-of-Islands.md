---
title: "LeetCode #200 Number of Islands"
date: "2015-08-10T10:10:26+08:00"
categories:
tags:
---

                                            

Given a 2d grid map of <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">'1'</code>s (land) and <code style="font-family:Menlo, Monaco, Consolas, 'Courier New', monospace;font-size:12.6000003814697px;color:rgb(199,37,78);">'0'</code>s
 (water), count the number of islands. An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.

Example 1:
11110
11010
11000
00000

Answer: 1

Example 2:
11000
11000
00100
00011

Answer: 3

      仅仅是求连通分量的个数，并查集实现会比搜索算法简单高效一些。可能是因为leetcode上的数据量不大，find_set函数在查找时更新每个点的father值，比起不更新，并没有显示出其优势，两者耗时都是8ms。


```cpp
class Solution {
public: 
    int numIslands(vector< vector<char> >& grid) {
        if(grid.empty()) return 0;
        int m = grid.size(), n = grid[0].size();
        
        vector<int> father(m * n, -1 );
        for(int i = 0; i < m; i++){
            for(int j = 0; j < n; j++){
                if(grid[i][j] == '1'){
                    if(father[i * n + j] == -1) father[i * n + j] = i * n + j; 
                    if(j + 1 < n && grid[i][j + 1] == '1') union_set(father, i * n + j, i * n + j + 1);
                    if(i + 1 < m && grid[i + 1][j] == '1') union_set(father, i * n + j, (i + 1) * n + j);
                }
            
            }
        }
        
        int res = 0;
        for(int i = 0; i < m * n; i ++){
            if(father[i] == i) res++;
        }
        return res;
    
    }
    
    void union_set(vector<int>& father, int a, int b){
        //if(father[a] == -1) father[a] = a;
        if(father[b] == -1) father[b] = b;
        int fa = find_set(father, a);
        int fb = find_set(father, b);
        if(fa != fb) 
            father[fa] = fb;
    }
    
    int find_set(vector<int>& father, int a){
        if(father[a] != a)
            father[a] = find_set(father, father[a]);
        return father[a];
        /*
        while(father[a] != a) a = father[a];
        return a;
        */
    }

};
```








