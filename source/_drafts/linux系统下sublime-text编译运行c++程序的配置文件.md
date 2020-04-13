---
title: "linux系统下sublime text编译运行c++程序的配置文件"
date: "2015-08-18T17:23:22+08:00"
categories:
tags:
---

                                            
做了两个版本，一个运行程序时，将终端调出，方便交互。
如下，因为我用的是kde桌面环境，所以常用终端的是konsole，对于gnome或其他桌面环境，改成gnome-terminal或x-terminal等终端即可。

```python
{
    "shell_cmd": "g++ '${file}' -o '${file_path}/${file_base_name}'",
    "file_regex": "^(..[^:]*):([0-9]+):?([0-9]+)?:? (.*)$",
    "working_dir": "${file_path}",
    "selector": "source.c, source.c++",

    "variants":
    [
        {
            "name": "Build & Run",
            "shell_cmd": "konsole -e bash -c \"g++ '${file}' -o '${file_path}/${file_base_name}' ; '${file_path}/${file_base_name}' ; read -p '\nPress ENTER or type command to continue...'\""
        },

        {
            "name": "Build Only",
            "shell_cmd": "g++ '${file}' -o '${file_path}/${file_base_name}'"
        },

        {
            "name": "Run Only",
            "shell_cmd": "konsole -e bash -c \"'${file_path}/${file_base_name}' ; read -p '\nPress ENTER or type command to continue...'\""
        }
    ]
}
```
另一个通过管道直接读取in输入文件和写入out输出文件，方便做用列测试（做ACM题时比较方便）。

```cpp
{
    "shell_cmd": "g++ \"${file}\" -o \"${file_path}/${file_base_name}\" && \"${file_path}/${file_base_name}\" < \"${file_path}/in\" > \"${file_path}/out\"",
    "file_regex": "^(..[^:]*):([0-9]+):?([0-9]+)?:? (.*)$",
    "working_dir": "${file_path}",
    "selector": "source.c, source.c++",

    "variants":
    [
        {
            "name": "Build & Run",
            "shell_cmd": "g++ '${file}' -o '${file_path}/${file_base_name}' && '${file_path}/${file_base_name}' < '${file_path}/in' > '${file_path}/out'"
        },
        {
            "name": "Build Only",
            "shell_cmd": "g++ '${file}' -o '${file_path}/${file_base_name}'"
        },

        {
            "name": "Run Only",
            "shell_cmd": "'${file_path}/${file_base_name}' < '${file_path}/in' > '${file_path}/out'"
        }
    ]
}
```

Ctrl + B快捷键的默认行为是variants中的第一项（本来以为应该是variants外面的那一项，可我测试了，发现不是）;
Shift + Ctrl + B 可自由选择这四项中的某一项。







