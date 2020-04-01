---
title: "Gentoo on Macbook Pro Driver for the Broadcom Facetime HD Webcam"
date: 2017-01-17T11:13:06+08:00
categories: 
- [OS, Linux, Gentoo]
tags: 
- Linux
- Gentoo
- mbp
- drivers
---

gentoo on macbook pro 按 gentoo wiki 配置 kernel 选项后, 仍然不能使用摄像头

```
Device Drivers --->
 <M> Multimedia support  --->
  [*]   Cameras/video grabbers support
  [*]   Media USB Adapters  --->
   <M>   USB Video Class (UVC)  
   [*]     UVC input events device support (NEW) 
```
<!--more-->

`lscpi` 得到设备信息如下

```
Multimedia controller: Broadcom Limited 720p FaceTime HD Camera
```

据此在github找到相关驱动的项目 [https://github.com/patjak/bcwc_pcie](https://github.com/patjak/bcwc_pcie)

gentoo 上的安装摘录如下：

Get Started on Gentoo
On Gentoo it is no longer necessary to extract the firmware from a running OS X. Simply use the bcwc_pcie ebuild from https://github.com/toaster/gentoo-overlay.git.

The following steps have to be performed as root.

Adding the overlay using layman
First create a local overlay list:

```bash
echo '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE repositories SYSTEM "/dtd/repositories.dtd">
<repositories xmlns="" version="1.0">
  <repo quality="experimental" status="unofficial">
    <name>toaster</name>
    <description>toasters own ebuilds</description>
    <homepage>https://github.com/toaster/gentoo-overlay</homepage>
    <owner type="project">
       <email>tilo@pruetz.net</email>
       <name>Tilo Prütz</name>
    </owner>
    <source type="git">https://github.com/toaster/gentoo-overlay.git</source>
    <feed>https://github.com/feeds/toaster/commits/gentoo-overlay/master</feed>
  </repo>
</repositories>' > /etc/layman/overlays/toaster.xml
```

Then make it known to layman and add it to your local overlays:

```bash
layman -L
layman -a toaster
```

Install the driver
Note that you have to set the ~amd64 keyword for the driver package and for media-video/apple_facetimehd_firmware. How this is done in detail depends on how you manage your keywords.

```bash
emerge -av media-video/bcwc_pcie
```

The firmware ebuild will download a partial OS X 10.11 upgrade and extract the firmware from it. It is not necessary to boot OS X and extract it manually.

IF YOU ENCOUNTER ANY ISSUES LOOK AT THE "ADDITIONAL NOTES" SECTION ON THE BOTTOM OF THIS PAGE OR REPORT AN ISSUE
