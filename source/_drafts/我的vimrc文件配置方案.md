---
title: "我的vimrc文件配置方案"
date: "2015-07-30T14:46:51+08:00"
categories:
tags:
---

                                            
      结合网上的资料，根据自己平时使用习惯，将vimrc文件配置如下：

```plain
" 语法高亮
syntax on

" 输入的命令显示出来
set showcmd

" 允许折叠
set foldenable
" 手动折叠
set foldmethod=manual
" 代码折叠
set foldmethod=marker

" 共享外部剪贴板
set clipboard+=unnamed

" 配色方案
"colorscheme zellner
" 背景
"set background=dark

" 去掉vi兼容性（set nocp）
set nocompatible

" 自动缩进
set autoindent
set cindent
set smartindent

" Tab键的宽度
set tabstop=4

" 统一缩进为4
set softtabstop=4
set shiftwidth=4

" 用空格代替制表符
set expandtab

" 在行和段开始处使用制表符
set smarttab

" 制表符
set iskeyword+=_,$,@,%,#,-

" 显示行号
"set number
" 标尺
"set ruler

" 命令行于状态行
" set ch=2
" 始终显示状态行
" set ls=2

" 历史记录数
set history=500

" 自动重新读入
set autoread

" 备份和缓存
set nobackup
set noswapfile

" 设定在任何模式下鼠标都可用
"set mouse=a
"set mousehide

" 自动改变当前目录
"set autochdir

"搜索忽略大小写
"set ignorecase

"搜索逐字符高亮
set hlsearch
set incsearch

"行内替换
set gdefault

"编码设置
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936
set fileencoding=utf-8

"语言设置
"set langmenu=en_US.UTF-8
"set langmenu=zh_CN.UTF-8
"set helplang=cn

"去掉启动时提示
set shortmess=atI

"""""""""""""""""""""""""""""""""""""""""
"按键
""""""""""""""""""""""""""""""""""""""""""
"C，C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
map! <F5> <ESC>:call CompileRunGcc()<CR>

func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %< ; if [ -f in ]; then ./%< < in; else ./%<; fi"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %< ; if [ -f in ]; then ./%< < in; else ./%<; fi"
    elseif &filetype == 'java'
        exec "!javac %; java %<"
    elseif &filetype == 'sh'
        :!./%
    elseif &filetype == 'python'
        :!python %
    endif
    exec "q"
endfunc

"C,C++的调试
map <F8> :call Rungdb()<CR>
map! <F8> <ESC>:call Rungdb()<CR>

func! Rungdb()
        exec "w"
        exec "!g++ % -g -o %<"
        exec "!gdb ./%<"
endfunc

"针对C++11
map <F6> :call CompileRunGcc11()<CR>
map! <F6> <ESC>:call CompileRunGcc11()<CR>

func! CompileRunGcc11()
    exec "w"
    if &filetype == 'cpp'
        exec "!g++ --std=c++11 -O2 % -o %<_c11 ; if [ -f in ]; then ./%<_c11 < in; else ./%<_c11; fi"
    endif
    exec "q"
endfunc


" 选中状态下 Ctrl+c 复制
"vmap <C-c> "+y

" 映射全选+复制 ctrl+a
"map <C-A> ggVGY
"map! <C-A> <Esc>ggVGY

"跳转到文件头和尾
map <F10> gg
map <F12> G

"缩进相关
map <F7> :call Noindent()<CR>
map! <F7> <ESC>:call Noindent()<CR>i
map <F9> :call Indent()<CR>
map! <F9> <ESC>:call Indent()<CR>i

func! Noindent()
    exec "set noautoindent"
    exec "set nocindent"
    exec "set nosmartindent"
    exec "filetype indent off"
endfunc

func! Indent()
    exec "set autoindent"
    exec "set cindent"
    exec "set smartindent"
    exec "filetype indent on"
endfunc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"自动补全
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {}<esc>i
":inoremap { {<CR>}<esc>O
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
:inoremap " ""<ESC>i
:inoremap ' ''<ESC>i

function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction

" 打开文件类型检测, 加了才可以用智能补全
filetype plugin indent on

" 只在下拉菜单中显示匹配项目，并且会自动插入所有匹配项目的相同文本
set completeopt=longest,menu

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"自动插入文件头
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java,*.py, exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头 
func SetTitle()
    "如果文件类型为.sh文件 
    if &filetype == 'sh' || &filetype == 'python'
        call setline(1,"\#########################################################################") 
        call append(line("."), "\# File Name: ".expand("%")) 
        call append(line(".")+1, "\# Author: minyu") 
        call append(line(".")+2, "\# mail: wmy0831988@163.com") 
        call append(line(".")+3, "\# Created Time: ".strftime("%c")) 
        call append(line(".")+4, "\#########################################################################") 
        if &filetype == 'sh'
            call append(line(".")+5, "\#!/bin/bash")
        else
            call append(line(".")+5, "\#!/usr/bin/python")
        endif
        call append(line(".")+6, "") 
    else 
        call setline(1, "/*************************************************************************") 
        call append(line("."), "    > File Name: ".expand("%")) 
        call append(line(".")+1, "    > Author: minyu") 
        call append(line(".")+2, "    > Mail: wmy0831988@163.com ") 
        call append(line(".")+3, "    > Created Time: ".strftime("%c")) 
        call append(line(".")+4, " ************************************************************************/") 
        call append(line(".")+5, "")
    endif

    if &filetype == 'c'
        call append(line(".")+6,   "#include <stdio.h>")
        call append(line(".")+7,   "#include <string.h>")
        call append(line(".")+8,   "")
        call append(line(".")+9,   "int main(){")                                                                    
        call append(line(".")+10,  "")
        call append(line(".")+11,  "}")
    endif
                                                                                        
    if &filetype == 'cpp'
        call append(line(".")+6,   "#include <cstdio>")
        call append(line(".")+7,   "#include <cstring>")
        call append(line(".")+8,   "#include <algorithm>")
        call append(line(".")+9,   "#include <string>")
        call append(line(".")+10,  "#include <vector>")
        call append(line(".")+11,  "#include <set>")
        call append(line(".")+12,  "#include <map>")
        call append(line(".")+13,  "")
        call append(line(".")+14,  "int main(){")
        call append(line(".")+15,  "")
        call append(line(".")+16,  "}")
    endif

    if &filetype == 'java'
        call append(line(".")+6,   "public class  {")
        call append(line(".")+7,   "")
        call append(line(".")+8,   "      public static void main(String[] args) {")
        call append(line(".")+9,   "            " )
        call append(line(".")+10,  "      }" )
        call append(line(".")+11,  "" )
        call append(line(".")+12,  "}" )
    endif
    
    "新建文件后，自动定位到文件末尾
    autocmd BufNewFile * normal G

endfunc 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



```


