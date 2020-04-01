---
title: "Linux下使用gdb调试nasm程序"
date: 2014-09-28T23:33:12+08:00
categories: 
- [OS, Linux]
- [Programming, ASM]
tags: 
- Linux
- nasm
- asm
- gdb
- debug
---

# 方案尝试

1. 
```bash
nasm -f elf name.asm
ld -m elf_i386 -o name name.o  -Ttext 0x1000
gdb name
```

2. 
```bash
nasm -f elf64 name.asm
ld -o name name.o  -Ttext 0x1000
gdb name
```

3. 
```bash
nasm -f elf64 name.asm -g -F stabs
gcc -o name name.o -g
gdb name
```
<!--more-->

# 尝试历程

昨天刚接触nasm，按网上的资料，编译、连接和调试代码用的是第一种方式（因为系统是x86_64架构的）。后来又看了nasm和ld指令的参数描述，改用第二种方式，编译时直接生成elf64格式的object文件。

可用前这种方案gdb断点调试时发现没有符号表（No symbol table is loaded），仔细看时，才发现刚运行gdb时已经有提示了（Reading symbols from t...(no debugging symbols found)...done.）。查阅资料发现：nasm好像确实不能像gas 那样，在生成的目标代码中包含符号表（gas加上参数--gstabs，同时ld不使用参数 -s 就行了）。

又在网上查阅各种关于调试nasm的资料，终于发现了上面的第三种方式，不过之前用ld连接时，需指定入口函数的格式如下：

```x86asm
global _start        

    _start:
        ……
        ……
```

否则，提示错误 “cannot find entry symbol _start”（真有一种java中找不到或无法加载主类的感觉），而这样的代码用gcc编译，又会出现“对‘main’未定义的引用” 的错误提示。所以，此时又要将  _start 修改成 main。这样用gdb调试时就有符号表了（Reading symbols from t...done）。
