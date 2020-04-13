---
title: "gh60(OK60RGB)刷固件折腾日志（MacOs版）"
date: "2017-11-18T14:24:11+08:00"
categories:
tags:
---

<article class="baidu_pl">
        <!--python安装手册开始-->
                <!--python安装手册结束-->
                <!--####专栏广告位图文切换开始-->
                                    <!--####专栏广告位图文切换结束-->
         
            <link rel="stylesheet" href="https://csdnimg.cn/release/phoenix/template/css/ck_htmledit_views-688b67d66a.css" />
                            
                    <!-- flowchart 箭头图标 勿删 -->
                    <svg xmlns="http://www.w3.org/2000/svg" style="display: none;">
                        <path stroke-linecap="round" d="M5,0 0,2.5 5,5z" id="raphael-marker-block" style="-webkit-tap-highlight-color: rgba(0, 0, 0, 0);"></path>
                    </svg>
                                            # gh60(OK60RGB)刷固件折腾日志（MacOs版）



## 前因

大概半个月前，从淘宝上入手了个[gh60客制化HHKB布局的键盘](https://item.taobao.com/item.htm?spm=a1z09.2.0.0.31f3b175TiJCeJ&id=551659842683&_u=i10s8lrp1e05)，就下面这货，看起来颜值不错，还是有些骚气的。

![my gh60](https://img-blog.csdn.net/20171118112233758?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDEyOTQ0OA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

键位基本上是按照HHKB的默配列来的，开始一直是在Linux系统（在13寸 Macbook Pro 上安装的Gentoo）上使用，一切正常。嫌现在的13寸本有些小了，这个星期收了个15寸的新本，因为还要上班，就没来得及装成Linux，然后就神奇地发现MacOs竟然不能识别左右Command（相当于Linux上的Mate键、Windows上的Win键）和右Opt（相当于Linux上的Alt键）！看来只能重新刷机了。



## 环境准备

在MacOs上给gh60刷机需要准备的环境很简单，就下面两个，直接用HomeBrew就可以安装，前者用于 build firmware，后者用于刷入键盘。

<ul>
<li>[crosspack-avr](https://obdev.at/products/crosspack/index.html)</li>
<li>[dfu-programmer](https://dfu-programmer.github.io/)  </li>
</ul>



<code class="language-bash hljs ">brew install dfu-programmer
brew install Caskroom/cask/crosspack-avr
```

当然，还要克隆下来[tmk_keyboard](https://github.com/tmk/tmk_keyboard) 的开源项目



<code class="language-bash hljs ">git clone https://github.com/tmk/tmk_keyboard
```

对于 gh60 CHN的PCB版，原项目并不支持，这时候就需要Kai Ryu 大神fork出的custom版[tmk_keyboard](https://github.com/kairyu/tmk_keyboard_custom)了



<code class="language-bash hljs ">git clone https://github.com/kairyu/tmk_keyboard_custom
```

不过，如果使用 [tkg.io](https://tkg.io/) 线刷的话也就不用克隆项目源码了。



## 折腾过程



### 怎么进入刷机模式

在折腾前自认为在网上查足了资料，做好了充分准备（其实也没什么要准备的），可是开刷的时候还是一下子懵了—  说好的按钮呢！

从我查的资料看，无论是 CHN版还是Rev A/B/C 版，后面都有一个按钮，按一下那个按钮就可以dfu（刷机）模式了。

![gh60 rev. B](https://img-blog.csdn.net/20171118120634607?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDEyOTQ0OA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

可是我的主板那个位置只有两个跳线开关（键盘外壳已经上起来了，就不在拍照放图了），根本没法通过他们进入dfu模式。

<code>system_profiler SPUSBDataType</code>  查出的设备名一直还是GH60：

![gh60 dev](https://img-blog.csdn.net/20171118121629637?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDEyOTQ0OA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

没办法，大晚上（11点开始准备刷，这时候已经快11半）的打扰淘宝店家。然后他告诉我这个板子叫OK60RGB，和Statan是一样的，可是作为新手的我并不知道Statan是哪个鬼。好吧，先不管了，店家说要长按<code>空格+B</code>进入dfu模式。

搞了几下才知道，先拔掉键盘，然后一直长按<code>空格+B</code>的同时 ，再插上键盘，就可以进入了

![atm32u4dfu](https://img-blog.csdn.net/20171118123231026?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDEyOTQ0OA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)



### 正式刷机

想到google到的资料说CHN要用专门custom的项目才能支持刷机，不然键位是乱的。就问店家这个版本的板子是不是也要专门的方法，问的同时先按照Rev. A版的方式刷了，没想到竟然完全没问题！这时候，店家回了需要重装驱动，名字叫什么S60RGB，又一个不知道是什么鬼。不过，无所谓了，我只能告诉他说我直接刷机就搞好了，MacOs上按键识别的问题也解决了。

还是来说说怎么刷的吧：

开始我是使用简单的方式— 直接用前面提到的 [tkg.io](https://tkg.io/)在线刷，简直不能更方便：

使用tkg线刷，需要从chrome web store 安装TKG Chrome  App

![tkg chrome app](https://img-blog.csdn.net/20171118125642962?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDEyOTQ0OA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

然后，页面做的太人性化了，该怎么做一目了然

![tkg.io](https://img-blog.csdn.net/20171118125349190?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDEyOTQ0OA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

先看我的layout（已经保存到[gits](http://www.keyboard-layout-editor.com/#/gists/8ded2317b1cd16386b99c7a49b48027e)里）

![hhkb_layout](https://img-blog.csdn.net/20171118130342707?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDEyOTQ0OA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

这个layout是在店家发给我的版本基本上修改的，我改成了基本和hhkb的配列完全一致，只是在Fn0层多加了个Menu菜单键，多出的那一排Fn键是为了以后添加其他层用。

至于Mac上键位识别的问题，<code>Command</code>的位置设置成<code>LGui</code>和<code>RGui</code>，Opt的位置设置成了<code>LAlt</code>和<code>RAlt</code>，我的想法是这样应该有最好的兼容性，事实上也成功了。

Raw Data 如下：



<code class="language-json hljs ">["Esc","!\n1","@\n2","#\n3","$\n4","%\n5","^\n6","&\n7","*\n8","(\n9",")\n0","_\n-","+\n=","|\n\\","~\n`"],
[{w:1.5},"Tab","Q","W","E","R","T","Y","U","I","O","P","{\n[","}\n]",{w:1.5},"DEL"],
[{w:1.75},"Ctrl","A","S","D","F","G","H","J","K","L",":\n;","\"\n'",{w:2.25},"Return"],
[{w:2.25},"LShift","Z","X","C","V","B","N","M","<\n,",">\n.","?\n/",{w:1.75},"RShift","fn0"],
[{x:1.5},"LAlt",{w:1.5},"LGui",{w:7},"Spc",{w:1.5},"RGui","RAlt"],
["POWER","F1","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12","INS","DEL"],
[{w:1.5},"CAPS",{a:7},"","","","","","","",{a:4},"PrtSc","ScrLk","Pause\nBreak","↑",{a:7},"",{w:1.5},"BS"],
[{w:1.75},"",{a:4},"Vol_Dn","Vol_Up","Mute","Eject",{a:7},"",{a:4},"*","/","Home","PgUp","←","→",{w:2.25},"Enter"],
[{a:7,w:2.25},"",{a:4},"fn1","fn2","fn3","fn4","fn5","+","-","End","PgDn","↓",{a:7,w:1.75},"",""],
[{x:1.5},"",{w:1.5},"",{w:7},"",{a:4,w:1.5},"Stop","Menu"],
["Esc","F1","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12","INS","DEL"],
[{w:1.5},"Tab",{a:7},"",{a:4},"MwU",{a:7},"","","",{a:4},"MwL","MwD","MwU","MwR",{a:7},"","","",{w:1.5},"BS"],
[{a:4,w:1.75},"Ctrl","MwL","MwD","MwR",{a:7},"","",{a:4},"McL","McD","McU","McR",{a:7},"","",{a:4,w:2.25},"Return"],
[{w:2.25},"Shift","McL","McD","McU","McR","Mb3","Mb2","Mb1","Mb4","Mb5",{a:7},"",{a:4,w:1.75},"RShift",{a:7},""],
[{x:1.5,a:4},"LGui",{w:1.5},"Alt",{w:7},"Mb1",{w:1.5},"RGui","Menu"]
```

由于我不止有Default层，所以应该选择标准模式或多合一模式，两个模式操作的差异不大，多合一模式更方便些，但生成的代码是一样的。

标准模式每层单独贴进去

![标准](https://img-blog.csdn.net/20171118131953537?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDEyOTQ0OA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

多合一模式直接把所有层放到一块就行 <br>
![这里写图片描述](https://img-blog.csdn.net/20171118132431600?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMDEyOTQ0OA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

我们都知道Fn键平时的操作，按下的同时，再按其他键可以修改他的功能，松开Fn键就还是原来的功能了。所以上面Fn0的选择是瞬时开启第1层（程序员都是从0开始计数的                                    
