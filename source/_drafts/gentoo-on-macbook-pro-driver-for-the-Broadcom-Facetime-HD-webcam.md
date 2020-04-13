---
title: "gentoo on macbook pro driver for the Broadcom Facetime HD webcam"
date: "2017-01-17T11:13:06+08:00"
categories:
tags:
---

                                            
## 
## gentoo on macbook pro 按 gentoo wiki 配置kernel 选项后, 仍然不能使用摄像头Device Drivers  --->
 <M> Multimedia support  --->
  [*]   Cameras/video grabbers support
  [*]   Media USB Adapters  --->
   <M>   USB Video Class (UVC)  
   [*]     UVC input events device support (NEW) 

## 

## 
lscpi得到设备信息如下

## 
Multimedia controller: Broadcom Limited 720p FaceTime HD Camera



据此在github找到相关驱动的项目 https://github.com/patjak/bcwc_pcie
gentoo 上的安装摘录如下：


## 
Get Started on Gentoo

On Gentoo it is no longer necessary to extract the firmware from a running OS X. Simply use the <code style="font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace;font-size:13.6px;">bcwc_pcie</code> ebuild from [https://github.com/toaster/gentoo-overlay.git](https://github.com/toaster/gentoo-overlay.git).

The following steps have to be performed as <code style="font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace;font-size:13.6px;">root</code>.
### 
<a id="user-content-adding-the-overlay-using-layman" class="anchor" href="https://github.com/patjak/bcwc_pcie/wiki/Get-Started#adding-the-overlay-using-layman" style="color:rgb(64,120,192);text-decoration:none;margin-left:-20px;line-height:1;"></a>Adding
 the overlay using <code style="font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace;">layman</code>

First create a local overlay list:
<code style="font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace;font-size:13.6px;background:transparent;border:0px;display:inline;overflow:visible;line-height:inherit;">echo '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE repositories SYSTEM "/dtd/repositories.dtd">
<repositories xmlns="" version="1.0">
  <repo quality="experimental" status="unofficial">
    <name>toaster</name>
    <description>toasters own ebuilds</description>
    <homepage>https://github.com/toaster/gentoo-overlay</homepage>
    <owner type="project">
       <email>[tilo@pruetz.net](mailto:tilo@pruetz.net)</email>
       <name>Tilo Prütz</name>
    </owner>
    <source type="git">https://github.com/toaster/gentoo-overlay.git</source>
    <feed>https://github.com/feeds/toaster/commits/gentoo-overlay/master</feed>
  </repo>
</repositories>' > /etc/layman/overlays/toaster.xml

```

Then make it known to layman and add it to your local overlays:
<code style="font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace;font-size:13.6px;background:transparent;border:0px;display:inline;overflow:visible;line-height:inherit;">layman -L
layman -a toaster

```
### 
<a id="user-content-install-the-driver" class="anchor" href="https://github.com/patjak/bcwc_pcie/wiki/Get-Started#install-the-driver" style="color:rgb(64,120,192);text-decoration:none;margin-left:-20px;line-height:1;"></a>Install
 the driver

Note that you have to set the <code style="font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace;font-size:13.6px;">~amd64</code> keyword for the driver package and for <code style="font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace;font-size:13.6px;">media-video/apple_facetimehd_firmware</code>.
 How this is done in detail depends on how you manage your keywords.
<code style="font-family:Consolas, 'Liberation Mono', Menlo, Courier, monospace;font-size:13.6px;background:transparent;border:0px;display:inline;overflow:visible;line-height:inherit;">emerge -av media-video/bcwc_pcie

```

The firmware ebuild will download a partial OS X 10.11 upgrade and extract the firmware from it. It is not necessary to boot OS X and extract it manually.

IF YOU ENCOUNTER ANY ISSUES LOOK AT THE "ADDITIONAL NOTES" SECTION ON THE BOTTOM OF THIS PAGE OR REPORT AN ISSUE
