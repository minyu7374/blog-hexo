---
title: "linux系统下初试编写汇编程序"
date: "2014-09-27T22:53:46+08:00"
categories:
tags:
---

                                            
       大一学汇编时，用了一个多月才上道，可以还算顺利地写出一些简单程序。课程结束后自然就没再用了。现在上微机原理课，又需要写汇编代码了。由于平时用的是linux系统，我就查了下linux系统下汇编语言开发的资料，发现它有两种语法格式：AT&T 格式和 Intel格式。两种格式差距很大，而我以前只接触过采用Intel风格的DOS/Windows 下的汇编语言，而且感觉AT&T要比Intel晦涩多了，于是决定继续使用Intel格式。
         linux系统的标准汇编器是gas，它使用的是标准的 AT&T 汇编语法，而另一个经常用到的汇编器nasm则可以用来编译用 Intel 语法格式编写的汇编程序，而且据说执行速度要比gas快很多。
        尽管同是Intel风格，但nasm和windows下的masm语法格式还是有不少区别的，今天成功完成微机原理实验的第一个简单的小程序，竟然用了几个小时，简直是血泪史啊。
        这个小程序在masm下是这样写的：

```plain
DATA  SEGMENT
    A  DW  123
    B  DW  456
    SUM  DW  ?
DATA  ENDS
    
CODE  SEGMENT         
     ASSUME    CS:CODE , DS:DATA
  START:   
     MOV   AX , DATA
     MOV   DS , AX
     MOV   AX , A
     SUB   AX , B
     MOV  SUM , AX
     MOV   AH , 4CH
     INT  21H       

CODE  ENDS
END  START
```

         刚开始我参照nasm的格式写成下面的代码（文件名为t1.asm）：




```plain
SECTION .DATA            ;数据段声明
    A DW 123
    B DW 456
    SUM DW ?

SECTION .TEXT            ;代码段声明
        ASSUME  CS:CODE , DS:DATA
GLOBAL _start            ; 指定入口函数
   _start:      
      MOV   AX , DATA
      MOV   DS , AX
      MOV   AX , A 
      SUB   AX , B 
      MOV  SUM , AX
      MOV   AH , 4CH
      INT 21H


```  

        没想到用nasm编译，提示第七行格式错误（t1.asm:7: error: parser: instruction expected），随后在网上查到nasm中没有assume伪指令，就把相关的几句去掉，代码修改如下：


```plain
SECTION .DATA            ;数据段声明
    A DW 123
    B DW 456
    SUM DW ?

SECTION .TEXT            ;代码段声明
       
GLOBAL _start            ; 指定入口函数
   _start:
      MOV    AX, A
      SUB    AX, B
      MOV   SUM, AX
      MOV    AH, 4CH
      INT   21H  
```       重新编译发现还是有两个错误（t1.asm:4: error: symbol `?' undefined t1.asm:12: error: invalid combination of opcode and operands），第一个错误很容易理解，看来nasm不支持 ？ 标识符，改成0就好了，可第二个错误让我百思不得其解，之后尝试了各种写法都是提示相同的错误，后来查nasm手册才知道需要用方括号来引用内存地址，手册说明引用如下：

      <em> NASM的设计思想是语法尽可能简洁。它的一个设计目标是，它将在被使用的过程中，尽可能得让用户看到一个单行的NASM代码时，就可以说出它会产生什么操作

码.你可以在NASM中这样做，比如，如果你声明了：  

      foo     equ     1  

      bar     dw      2  

然后有两行的代码：  

      mov     ax,foo  

      mov     ax,bar  

尽管它们有看上去完全相同的语法，但却产生了完全不同的操作码  


NASM为了避免这种令人讨厌的情况，拥有一个相当简单的内存引用语工能。规则 是任何对内存中内容的存取操作必须要在地址上加上方括号。但任何对地址值的操作不需要。所以，形如'mov ax,foo'的指令总是代表一个编译时常数，不管它 是一个 'EQU'或一个变量的地址；如果要取变量'bar'的内容，你必须写 'mov ax,[bar]'。</em>
       找到问题所在，下面就好说了，代码修改如下：

```plain
SECTION .DATA
    A DW 123
    B DW 456
    SUM DW 0

SECTION .TEXT            ;代码段声明

GLOBAL _start            ; 指定入口函数
   _start:
      MOV    AX, [A]
      SUB    AX, [B]
      MOV   [SUM], AX
      MOV    AH, 4CH
      INT   21H

```

      编译总算是通过了！可是，本以为现在可以松一口气了，结果用 ld -s -o t1 t1.o 命令连接又出了问题（ld: i386 architecture of input file `t1.o' is incompatible with i386:x86-64 output）。我电脑是64位的操作系统,又来了个不匹配，好在有人告诉我解决方案：修改为   ld -m elf_i386 -s -o t1 t1.o ，即可模拟i386架构了。这次总该没什么问题了吧，可实际上问题比想象中的还要复杂，运行生成的可执行文件时出现了段错误，在网上查很多资料都找不出问题所在，后来终于看到下面的帖子：



<em>在使用gun/as、ld编译链接生成16位汇编代码时往往在链接阶段发生如下错误：

k03.o: In function `_start':

(.text+0xa): relocation truncated to fit: R_386_16 against `.data'

解决方法有几种，其中最便捷的方法就是：

ld -o k03 k03.o -Ttext 1000

通过T参数指定text段的装载地址。然后就可以顺利链接成功。但是只知其然不知其所以然。为什么指定他的绝对地址后链接就可通过，为何在汇编源代码中我们通过定位、跳转同样能指定其加载地址而链接仍通不过？这个问题我在google上搜索了好久，往往都是直接给出解决方法（如上）而没有给出解释。看来要真正了解还得自己动手，通过反复测试，发现当把源代码中

.globl _start去掉时，也就是不指定入口点时，多了一行错误提示：

ld: warning: cannot find entry symbol _start; defaulting to 0000000008048054

哈哈，这回终于发现问题了，虽然是16位代码，但是链接时仍把入口点定为了32位。接下来验证这个猜测就很简单了：ld -o k03 k03.o -Ttext 100000，把text段定位设为超过16位地址，链接时终于出现了relocation truncated to fit: R_386_16 against `.data'错误了。
</em>


<em>重新修改ld指令 </em> ld -m elf_i386 -s -o t1 t1.o -Ttext 0x1000，


运行t1果然正常了。问题终于圆满解决！
