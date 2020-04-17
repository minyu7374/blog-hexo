---
title: pip update user package script on Gentoo
date: 2020-04-17 17:28:14
categories:
- [OS, Linux, Gentoo]
tags:
- Linux
- Gentoo
- Python
---

`pip` 一直未提供软件包整体更新的功能，一般可以通过 `list` 参数列出所有的三方包再进行 `install --upgrade` 操作解决问题。

但在 `Gentoo` 还有一个问题：有部分程序是依赖于系统级的三方包的，如果用户级自己也安装了同一个包，但版本有问题，可能导致程序运行出错。比如我使用 `calibre` 时就曾因为用户级安装 `html5-parser` 和 `PyQt5` 包的问题导致启动直接抛出异常

使用 `equery g calibre | grep dev-python` 可以查看到目前 `calibre` 依赖的 `python` 三方包还是很多的：

<!-- more -->

```
 [  1]  dev-python/apsw-3.25.2_p1
 [  1]  dev-python/beautifulsoup-4.8.1
 [  1]  dev-python/chardet-3.0.4
 [  1]  dev-python/cssselect-1.1.0
 [  1]  dev-python/css-parser-1.0.4-r1
 [  1]  dev-python/dbus-python-1.2.14
 [  1]  dev-python/dnspython-1.16.0-r1
 [  1]  dev-python/feedparser-5.2.1
 [  1]  dev-python/html2text-2019.9.26
 [  1]  dev-python/html5-parser-0.4.9
 [  1]  dev-python/lxml-4.5.0
 [  1]  dev-python/markdown-3.2.1
 [  1]  dev-python/mechanize-0.4.5
 [  1]  dev-python/msgpack-0.6.2
 [  1]  dev-python/netifaces-0.10.9
 [  1]  dev-python/pillow-7.0.0
 [  1]  dev-python/psutil-5.7.0
 [  1]  dev-python/pygments-2.6.1
 [  1]  dev-python/python-dateutil-2.8.1-r1
 [  1]  dev-python/PyQt5-5.14.1-r1
 [  1]  dev-python/PyQtWebEngine-5.14.0
 [  1]  dev-python/regex-2019.11.1
 [  1]  dev-python/setuptools-44.0.0
 [  1]  dev-python/sip-4.19.21
 [  1]  dev-python/apsw-3.25.2_p1
 [  1]  dev-python/beautifulsoup-4.8.1
 [  1]  dev-python/chardet-3.0.4
 [  1]  dev-python/cssselect-1.1.0
 [  1]  dev-python/css-parser-1.0.4-r1
 [  1]  dev-python/dbus-python-1.2.14
 [  1]  dev-python/dnspython-1.16.0-r1
 [  1]  dev-python/feedparser-5.2.1
 [  1]  dev-python/html2text-2019.9.26
 [  1]  dev-python/html5-parser-0.4.9
 [  1]  dev-python/lxml-4.5.0
 [  1]  dev-python/markdown-3.2.1
 [  1]  dev-python/mechanize-0.4.5
 [  1]  dev-python/msgpack-0.6.2
 [  1]  dev-python/netifaces-0.10.9
 [  1]  dev-python/pillow-7.0.0
 [  1]  dev-python/psutil-5.7.0
 [  1]  dev-python/pygments-2.6.1
 [  1]  dev-python/python-dateutil-2.8.1-r1
 [  1]  dev-python/PyQt5-5.14.1-r1
 [  1]  dev-python/PyQtWebEngine-5.14.0
 [  1]  dev-python/regex-2019.11.1
 [  1]  dev-python/zeroconf-0.19.1
 [  1]  dev-python/setuptools-44.0.0
 [  1]  dev-python/sip-4.19.21
 [  1]  dev-python/apsw-3.25.2_p1
 [  1]  dev-python/beautifulsoup-4.8.1
 [  1]  dev-python/chardet-3.0.4
 [  1]  dev-python/cssselect-1.1.0
 [  1]  dev-python/css-parser-1.0.4-r1
 [  1]  dev-python/dbus-python-1.2.14
 [  1]  dev-python/dnspython-1.16.0-r1
 [  1]  dev-python/feedparser-5.2.1
 [  1]  dev-python/html2text-2019.9.26
 [  1]  dev-python/html5-parser-0.4.9
 [  1]  dev-python/lxml-4.5.0
 [  1]  dev-python/markdown-3.2.1
 [  1]  dev-python/mechanize-0.4.5
 [  1]  dev-python/msgpack-0.6.2
 [  1]  dev-python/netifaces-0.10.9
 [  1]  dev-python/pillow-7.0.0
 [  1]  dev-python/psutil-5.7.0
 [  1]  dev-python/pygments-2.6.1
 [  1]  dev-python/python-dateutil-2.8.1-r1
 [  1]  dev-python/PyQt5-5.14.1-r1
 [  1]  dev-python/PyQtWebEngine-5.14.0
 [  1]  dev-python/regex-2019.11.1
 [  1]  dev-python/zeroconf-0.19.1
 [  1]  dev-python/setuptools-44.0.0
 [  1]  dev-python/sip-4.19.21
```

为避免此类情况的再次发生，编写脚本如下：

```bash
#!/usr/bin/env bash
#########################################################################
# File Name: /home/wmy/.bin/pip-update-user-package.sh
# Author: minyu
# mail: minyu7374@gmail.com
# Created Time: Thu 16 Apr 2020 08:22:53 PM CST
#########################################################################
# set -x

trap 'rm -f "${user_file}" "${sys_file}"' EXIT

user_file=$(mktemp) || exit 1
sys_file=$(mktemp) || exit 1

equery list 'dev-python/*' | awk -F/ '{print $2}' | sed 's/-[0-9].*//' | sort > "${sys_file}"

update() {
    "pip$1" list --user 2>&- | sed '1,2d' | awk '{print $1}' | sort > "${user_file}"

    mapfile -t packages <"${user_file}"
    [ ${#packages[@]} -gt 0 ] &&
        "pip$1" install --upgrade --user "${packages[@]}"

    mapfile -t packages < <(join "${user_file}" "${sys_file}")
    [ ${#packages[@]} -gt 0 ] &&
        "pip$1" uninstall "${packages[@]}"
}

update 2
update 3
```
