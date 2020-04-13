---
title: "openSUSE 13.1安装配置日记"
date: "2014-07-18T23:47:18+08:00"
categories:
tags:
---

                                               这学期刚开学的时候，在刚买的移动硬盘上安装了openSUSE。配置好系统后，本来想在第一周周末整理一下安装配置日记，但苦于

没有时间，就把事情拖到的这个周末，现在总算有时间整理了。

1、禁用官方源和DVD光盘源，启用中国大陆源

使用DVD光盘安装好openSUSE 13.1之后，软件安装源中默认存在一个名称为”openSUSE-13.1-1.10″的软件源，这个源的URL实际上是指

向DVD光驱的，我们安装好系统之后，基本不会再使用DVD, 但我们通过YaST或者zypper安装软件时，总是会浪费时间去检测该源是否可

用，所以还是将该软件源禁用掉好。另外，在本国的软件源肯定要比官方源下载速度快，所以要禁用官方源，启用中国大陆源。
禁用官方源和DVD光盘源： 
    zypper mr -d openSUSE-13.1-1.10
    zypper mr -d openSUSE-13.1-Oss openSUSE-13.1-Non-Oss openSUSE-13.1-Update openSUSE-13.1-Update-Non-Oss
添加搜狐源：
    zypper ar <a style="color:rgb(145,88,51);text-decoration:none;" href="http://mirrors.sohu.com/opensuse/distribution/13.1/repo/oss/" rel="nofollow">http://mirrors.sohu.com/opensuse/distribution/13.1/repo/oss/</a>（软件源网址） openSUSE-13.1-Oss-sohu-mirror（为软件源起的别名）
    zypper ar <a style="color:rgb(145,88,51);text-decoration:none;" href="http://mirrors.sohu.com/opensuse/distribution/13.1/repo/non-oss/" rel="nofollow">http://mirrors.sohu.com/opensuse/distribution/13.1/repo/non-oss/</a> openSUSE-13.1-Non-Oss-sohu-mirror
    zypper ar <a style="color:rgb(145,88,51);text-decoration:none;" href="http://mirrors.sohu.com/opensuse/update/13.1/" rel="nofollow">http://mirrors.sohu.com/opensuse/update/13.1/</a> openSUSE-13.1-Update-sohu-mirror
    zypper ar <a style="color:rgb(145,88,51);text-decoration:none;" href="http://mirrors.sohu.com/opensuse/update/13.1-non-oss/" rel="nofollow">http://mirrors.sohu.com/opensuse/update/13.1-non-oss/</a> openSUSE-13.1-Update-Non-Oss-sohu-mirror

2、解决多媒体和受限格式文件的播放问题
openSUSE 13.1默认没有安装那些受专利保护的多媒体编解码器（其实在我用过的linux系统中除了ubuntu外其它的都不安装），所以自带

的Amarok不能播放MP3、WMA等格式,而自带的Kaffeine也不能播放RMVB等视频格式，但我们可以自行安装。
解决Amarok不能播放mp3, wma的问题，默认情况下Amarok是使用gstreamer作为后端的，直接执行下述命令即可：            zypper in gstreamer-0_10-plugins-bad gstreamer-0_10-plugins-ugly gstreamer-0_10-plugins-fluendo_mp3 gstreamer-0_10-plugins-ugly-orig-addon gstreamer-0_10-plugins-ffmpeg gstreamer-0_10-plugins-base
安装smplayer, mplayer, w32codec-all（kaffeine是基于xine的多媒体播放器，就算安装了w32codec-all也不能正常播放rmvb等格式，还是

直接将其卸载省事）：
    zypper ar <a style="color:rgb(145,88,51);text-decoration:none;" href="http://ftp.skynet.be/pub/packman/suse/openSUSE_13.1/" rel="nofollow">http://ftp.skynet.be/pub/packman/suse/openSUSE_13.1/</a> packman-skynet-mirror        zypper in  mplayer smplayer w32codec-all smplayer-lang
3、解决Firefox不能播放flash在线视频。
在终端中运行下述命令后，重启firefox即可：        zypper in flash-player flash-player-kde4 pullin-flash-player
4、安装谷歌浏览器        zypper ar -f <a style="color:rgb(145,88,51);text-decoration:none;" href="http://dl.google.com/linux/chrome/rpm/stable/" rel="nofollow">http://dl.google.com/linux/chrome/rpm/stable/</a>$(uname -m) Google-Chrome        zypper ref        zypper in google-chrome-stable       也可以不添加软件源直接到 <a style="color:rgb(145,88,51);text-decoration:none;" href="http://www.google.cn/intl/zh-CN/chrome/browser/" rel="nofollow">http://www.google.cn/intl/zh-CN/chrome/browser/</a> 下载rpm包安装     5、解决linux下mp3乱码问题
首先，需要有软件包mid3iconv：
    zypper in python-mutagen
然后转到MP3目录，执行转换命令：
    mid3iconv -e GBK *.mp3
如果需要包含子目录，可以使用如下格式：       mid3iconv -e GBK */*.mp3
最后，重新导入一次音乐播放器就OK了。 
6、 安装歌词字幕插件
osdlyrics可显示桌面歌词，支持绝大多数的音频播放器：
　　    zypper in osdlyrics
7、安装 WPS 办公套件
到 <a style="color:rgb(145,88,51);text-decoration:none;" href="http://community.wps.cn/download/" rel="nofollow">http://community.wps.cn/download/</a> 下载最新的 Alpha 版本rpm包安装。
打开wps后会提示缺少一些字体，到论坛下载字体后，解压放入～/.fonts目录下即可。
8、安装 AMD/ATI 显卡私有驱动
    zypper ar -f <a style="color:rgb(145,88,51);text-decoration:none;" href="http://geeko.ioda.net/mirror/amd-fglrx-beta/openSUSE_" rel="nofollow">http://geeko.ioda.net/mirror/amd-fglrx-beta/openSUSE_</a>`lsb-release -r | awk '{print $2}'` amd-fglrx-beta      zypper refresh      zypper dup -r amd-fglrx-beta     9、安装Sun JDK
用root权限在/usr目录下建立java文件夹，然后将jdk1.7.0_45文件夹及下面的东西全部移动到/usr/java/下。
配置java环境
     vi  /etc/profile
添加以下内容到文件尾部
    JAVA_HOME=/usr/java/jdk1.7.0_45
    JRE_HOME=/usr/java/jre1.7.0_45
    PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin
    CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib
    export JAVA_HOME JRE_HOME PATH CLASSPATH
接着使生效
    source profile
修改java命令
    update-alternatives --install "/usr/bin/java" "java" "/usr/java/jdk1.7.0_45/bin/java" 90
修改javac命令
   update-alternatives --install "/usr/bin/javac" "javac" "/usr/java/jdk1.7.0_45/bin/javac" 90
更改java各版本运行优先级
   update-alternatives --config java
   出现已经安装的多个Java版本，选择相应序号就可设置哪个java作为最高优先级运行了。   更改javac各版本运行优先级（同上）  
   update-alternatives --config javac
10、安装eclipse
官网下载eclipse压缩包后，添加终端打开：
     ln -s eclipse执行文件路径  /usr/bin/             添加桌面应用：
     cd /usr/share/applications 
     vi eclipse.desktop     写入如下内容：     [Desktop Entry]          X-SuSE-translate=true          Categories=Development;          Encoding=UTF-8          Name=eclipse          Comment=IDE c/c++          TryExec=eclipse          Exec=eclipse执行文件路径          Icone=clipse.png路径          Terminal=false          StartupNotify=true          Type=Application
11、安装CodeBlocks
首先要有C/C++编译环境，gcc、gcc-c++、make 必不可少。
CodeBlocks是基于wxWidgets开发的，安装CodeBlocks之前要先安装wxGTK，两个软件都是要编译安装的
不过，还有一种更简便的安装方式：openSUSE官网为很多第三方软件包提供了一键安装（1 Click Install）的快捷方式
到 <a style="color:rgb(145,88,51);text-decoration:none;" href="http://software.opensuse.org/search" rel="nofollow">http://software.opensuse.org/search</a> 查询想要的软件，下载相应ymp文件后，用Yast一键安装打开，它会自动为你添加软件源、解决

依赖包关系和安装软件，安装过程中只需你授权信任这些软件源即可。
其实，eclipse也能在那找到，不过安装之后点击它的图标没有反应，我当初以为是没安装好，又重新安装一次还是那样，后来才发现原来

它在/usr/bin/目录下创建的eclipse链接有问题，本来应该链接eclipse执行文件，结果却链接了它的上层目录，删除原链接，创建新链后，

就没问题了
12、关于mysql
Fedora 和 openSUSE 都已经抛弃MySQL的Linux发行版，而使用MariaDB。
查阅有关它的资料发现下面的介绍：
MariaDB是由原来 MySQL 的作者Michael Widenius创办的公司所开发的免费开源的数据库服务器。
MariaDB是MySQL的一个分支，主要由开源社区在维护，采用GPL授权（这是一份GNU通用公共授权协议）许可。开发这个分支的原因之

一是：甲骨文公司收购了MySQL后，有将MySQL闭源的潜在风险，因此社区采用分支的方式来避开这个风险（开源社区再次向我们展现

了他们乐于分享、无私奉献的精神，我很感动！）。 
根据资料介绍，MariaDB对MySQL的兼容性是很好的，所以我们可以放心使用。
另外，我在 51CTO.com 中查到如下搭建LAMP（Linux+Apache+Mysql/MariaDB+Perl/PHP/Python）环境的方法：
装数据库
    zypper install mysql-community-server mysql-community-server-client     启动服务     systemctl enable mysql.service     systemctl start mysql.service     初始化数据库命令：     mysql_secure_installation 
安装apache2
    zypper install apache2     启动服务     systemctl enable apache2.service     systemctl start apache2.service 
安装php相关软件包
    zypper install apache2-mod_php5 php5-mysql php5-bcmath php5-bz2 php5-calendar php5-ctype php5-curl php5-dom php5-ftp php5-gd php5-gettext php5-gmp php5-iconv php5-imap php5-ldap php5-mbstring php5-mcrypt php5-odbc php5-openssl php5-pcntl php5-pgsql php5-posix php5-shmop php5-snmp php5-soap php5-sockets php5-sqlite php5-sysvsem php5-tokenizer php5-wddx php5-xmlrpc php5-xsl php5-zlib php5-exif php5-fastcgi php5-pear php5-sysvmsg php5-sysvshm     systemctl restart apache2.service 
安装数据库管理工具phpMyAdmin：
    zypper install phpMyAdmin 
修改配置文件，添加两行：
    vi /etc/apache2/conf.d/phpMyAdmin.conf 
     Alias /phpMyAdmin /srv/www/htdocs/phpMyAdmin 

重新启动 Apache2：
    systemctl restart apache2.service 
打开浏览器，访问     http://localhost/phpMyAdmin/   即可验证是否配置成功 其中，下达初始化数据库命令后，终端中会提示你做一些mysql初始配置的操作，如设置root用户密码，是否删除不需密码就能登录mysql

用户和test数据库等。
讲到Apache，就会想到tomcat，它的安装永远是最省事的，下载完压缩包，解压后就能使用，配置什么的也很简单，真的很方便！
 
                                    
