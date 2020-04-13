---
title: "fedora安装之后"
date: "2014-07-18T23:47:16+08:00"
categories:
tags:
---

                                            
 1.加入第三方源
<font face="微软雅黑, Tohoma">
</font>
     rpmfusion足够强大
<font face="微软雅黑, Tohoma">
</font>
     #rpm -ivh <a style="text-decoration:none;color:rgb(145,88,51);line-height:22px;" href="http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm" rel="nofollow">http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-stable.noarch.rpm</a>
<font face="微软雅黑, Tohoma">
</font>
         另外可去rpmfusion主页【rpmfusion.org】下载以下两个个rpm软件包：
<font face="微软雅黑, Tohoma">
</font>
         rpmfusion-free-release-19.noarch.rpm
<font face="微软雅黑, Tohoma">
</font>
         rpmfusion-nonfree-release-19.noarch.rpm
<font face="微软雅黑, Tohoma">
</font>
         和以下两个密钥文件
<font face="微软雅黑, Tohoma">
</font>
         RPM-GPG-KEY-rpmfusion-free-fedora-19
<font face="微软雅黑, Tohoma">
</font>
         RPM-GPG-KEY-rpmfusion-nonfree-fedora-19
<font face="微软雅黑, Tohoma">
</font>
2.安装镜像选择工具，这个工具会从所有已配置的镜像中选择速度最快的下载，还有终端下载工具（wget）
<font face="微软雅黑, Tohoma">
</font>
     #yum install yum-plugin-fastestmirror wget
<font face="微软雅黑, Tohoma">
</font>
3.安装MP#，avi等其他媒体格式编码
<font face="微软雅黑, Tohoma">
</font>
     #yum localinstall --nogpgcheck <a style="text-decoration:none;color:rgb(145,88,51);line-height:22px;" href="http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-rawhide.noarch.rpm" rel="nofollow">http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-rawhide.noarch.rpm</a>http:// 
       download1.rpmfusion.org/nonfree/fedora/rpmusion-nonfree-release-rawhide.noarch.rpm
     #rpm -ivh <a style="text-decoration:none;color:rgb(145,88,51);line-height:22px;" href="http://rpm.livna.org/livna-release.rpm" rel="nofollow">http://rpm.livna.org/livna-release.rpm</a>
     #yum update
<font face="微软雅黑, Tohoma">
</font>
4.安装播放器前需先安装好多媒体解码器
<font face="微软雅黑, Tohoma">
</font>
     #yum -y install gstreamer-plugins*
     #yum install -y ffmpeg mjpegtools
<font face="微软雅黑, Tohoma">
</font>
5.音视频播放器（个人不同之喜欢fedora自带播放器，把他们全部卸载了）
<font face="微软雅黑, Tohoma">
</font>
     #yum install smplayer vlc audacious clementine
<font face="微软雅黑, Tohoma">
</font>
6.安装gnome3的优化工具
<font face="微软雅黑, Tohoma">
</font>
     #yum install gnome-tweak-tool
<font face="微软雅黑, Tohoma">
</font>
7.安装鼠标右键“在终端中打开”
<font face="微软雅黑, Tohoma">
</font>
     #yum install nautilus-open-terminal
<font face="微软雅黑, Tohoma">
</font>
8.安装解压缩软件7z、unrar 星际译王（starditc）、光盘烧烤（k3b）启动盘制作工具（Unetbootin）、deb包和rmp包转化工具（alien）
<font face="微软雅黑, Tohoma">
</font>
     #yum install p7zip p7zip-plugins unrar starditc k3b unetbootin alien 
<font face="微软雅黑, Tohoma">
</font>
9.安装flashplayer
<font face="微软雅黑, Tohoma">
</font>
     方案一：
<font face="微软雅黑, Tohoma">
</font>
           64位
               转到临时储存文件目录
            #cd /tmp         
              下载    
           #wget <a style="text-decoration:none;color:rgb(145,88,51);line-height:22px;" href="http://download.macromedia.com/pub/labs/flashplayer10/flashplayer10_2_p3_64bit_linux_111710.tar.gz%C2%A0%C2%A0" rel="nofollow">http://download.macromedia.com/pub/labs/flashplayer10/flashplayer10_2_p3_64bit_linux_111710.tar.gz  </a>; 
             解压
           #tar xzvf flashplayer10_2_p3_64bit_linux_111710.tar.gz
            移动文件
          #mv /tmp/libflashplayer.so /usr/lib64/mozilla/plugins/  /usr/lib/mozilla/plugins
           当然，也可以在图形界面进官网下载后再解压移动
<font face="微软雅黑, Tohoma">
</font>
        32位：
       #rpm -ivh <a style="text-decoration:none;color:rgb(145,88,51);line-height:22px;" href="http://linuxdownload.adobe.com/adobe-release/adobe-release-i386-1.0-1.noarch.rpm" rel="nofollow">http://linuxdownload.adobe.com/adobe-release/adobe-release-i386-1.0-1.noarch.rpm</a>
       #rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
       #yum update
       #yum install flash-plugin
<font face="微软雅黑, Tohoma">
</font>
     方案二：
<font face="微软雅黑, Tohoma">
</font>
         1- 添加源
<font face="微软雅黑, Tohoma">
</font>
              32位
          rpm -ivh linuxdownload.adobe.com/adobe-release/adobe-release-i386-1.0-1.noarch.rpm"><a style="text-decoration:none;color:rgb(145,88,51);line-height:22px;" href="http://linuxdownload.adobe.com/adobe-release/adobe-release-i386-1.0-1.noarch.rpm" rel="nofollow">http://linuxdownload.adobe.com/adobe-release/adobe-release-i386-1.0-1.noarch.rpm</a>
          rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
             64位
<font face="微软雅黑, Tohoma">
</font>
         rpm -ivh <a style="text-decoration:none;color:rgb(145,88,51);line-height:22px;" href="http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm%C2%A0%C2%A0" rel="nofollow">http://linuxdownload.adobe.com/adobe-release/adobe-release-x86_64-1.0-1.noarch.rpm  </a>; 
         rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
<font face="微软雅黑, Tohoma">
</font>
         2- 刷新
<font face="微软雅黑, Tohoma">
</font>
         yum update
<font face="微软雅黑, Tohoma">
</font>
        3- 安装
<font face="微软雅黑, Tohoma">
</font>
       yum install flash-plugin nspluginwrapper alsa-plugins-pulseaudio libcurl
<font face="微软雅黑, Tohoma">
</font>
      个人选择更倾向于使用第二种方案。
<font face="微软雅黑, Tohoma">
</font>
10.配置c/c++、java环境
<font face="微软雅黑, Tohoma">
</font>
       c/c++环境
          #yum install make gcc
          #yum install make gcc-c++
<font face="微软雅黑, Tohoma">
</font>
             关于java环境，fedora自带了openjdk，但sun的才是正统（官网最新版jdk-7u45-linux-x64.rpm）
             将openjdk卸载后，安装sun公司（已被甲骨文公司收购）jdk和jre的rpm包
             网上都说需要再配置环境变量，可我在未配置前就能正常使用 ，为防万一配置一下/etc/profile文件，
            添加环境变量
            export JAVA_HOME=/usr/java/jdk1.7.0_45(jdk安装目录)
            export PATH=$JAVA_HOME/bin:$PATH
            export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar 
            export JAVA_BIN=/usr/java/jdk1.7.0_45/bin
           再执行source  /etc/profile
<font face="微软雅黑, Tohoma">
</font>
11.到相应官网下载一些软件 如：
<font face="微软雅黑, Tohoma">
</font>
       wps for linux、PPStream、codeblocks、eclipse(它也可在终端下载，而且是汉化过的)/netbeans
            下载rpm包后执行rpm -ivh *.rpm(i参数表示安装，不想看安装细节可以不加vh等参数)
            或yum localinstall *.rpm均可安装（eclipse下载后不需安装，能直接使用）
<font face="微软雅黑, Tohoma">
</font>
12.谷歌浏览器安装
<font face="微软雅黑, Tohoma">
</font>
          在 /etc/yum.repos.d/目录下添加google-chrome.repo文件（leafpad /etc/yum.repos.d/google-chrome.repo），输入以下代码：
               32位：
            [google-chrome]  
            name=google-chrome - 32-bit  
            baseurl=<a style="text-decoration:none;color:rgb(145,88,51);line-height:22px;" href="http://dl.google.com/linux/chrome/rpm/stable/i386%C2%A0" rel="nofollow">http://dl.google.com/linux/chrome/rpm/stable/i386 </a>; 
            enabled=1  
            gpgcheck=1  
            gpgkey=<a style="text-decoration:none;color:rgb(145,88,51);line-height:22px;" href="https://dl-ssl.google.com/linux/linux_signing_key.pub" rel="nofollow">https://dl-ssl.google.com/linux/linux_signing_key.pub</a>
                64位：
             [google-chrome]  
             name=google-chrome - 64-bit  
             baseurl=<a style="text-decoration:none;color:rgb(145,88,51);line-height:22px;" href="http://dl.google.com/linux/chrome/rpm/stable/x86_64%C2%A0" rel="nofollow">http://dl.google.com/linux/chrome/rpm/stable/x86_64 </a>; 
             enabled=1  
             gpgcheck=1  
             gpgkey=<a style="text-decoration:none;color:rgb(145,88,51);line-height:22px;" href="https://dl-ssl.google.com/linux/linux_signing_key.pub" rel="nofollow">https://dl-ssl.google.com/linux/linux_signing_key.pub</a>
           之后保存、关闭。
<font face="微软雅黑, Tohoma">
</font>
     #yum install google-chrome
<font face="微软雅黑, Tohoma">
</font>
          若不能安装就在安装指令里加上参数      --nogpgcheck（禁用 GPG 签名检查）
<font face="微软雅黑, Tohoma">
</font>
13.virtualbox
<font face="微软雅黑, Tohoma">
</font>
          到virtualbox官网下载安装包后安装很简单，但安装后不能直接使用
<font face="微软雅黑, Tohoma">
</font>
         运行       /etc/init.d/vboxdrv setup
<font face="微软雅黑, Tohoma">
</font>
        出现错误大致如下：
        Stopping VirtualBox kernel modules                         [确定]
        Uninstalling old VirtualBox DKMS kernel modules            [确定]
        Trying to register the VirtualBox kernel modules using DKMSError! echo
        Your kernel headers for kernel 2.6.39-200.29.2.el5uek cannot be found at
        /lib/modules/2.6.39-200.29.2.el5uek/build or /lib/modules/2.6.39-200.29.2.el5uek/source.
               [失败]
       (Failed, trying without DKMS)
       Recompiling VirtualBox kernel modules                      [失败]
       (Look at /var/log/vbox-install.log to find out what went wrong)
<font face="微软雅黑, Tohoma">
</font>
        安装  dkms  VirtualBox-kmodsrc kmod-VirtualBox kernel*等软件包
       再运行     /etc/init.d/vboxdrv setup
<font face="微软雅黑, Tohoma">
</font>
       结果大致如下：
       Stopping VirtualBox kernel modules                         [确定]
       Uninstalling old VirtualBox DKMS kernel modules            [确定]
       Trying to register the VirtualBox kernel modules using DKMS[确定]
       Starting VirtualBox kernel modules                         [确定]
    virtualbox即可正常使用
<font face="微软雅黑, Tohoma">
</font>
14.QQ-wine安装
<font face="微软雅黑, Tohoma">
</font>
       qq2012下载地址：<a style="text-decoration:none;color:rgb(145,88,51);line-height:22px;" href="http://115.com/file/dpaarnre#qq2012.tar.gz" rel="nofollow">http://115.com/file/dpaarnre#qq2012.tar.gz</a> 
             解压后，进入qq2012/wineapp/qq/ 目录下运行 install.sh
<font face="微软雅黑, Tohoma">
</font>
      # ./install.sh 
<font face="微软雅黑, Tohoma">
</font>
           然后安装以下安装包：
            yum install alsa-lib-devel.i686 alsa-lib-devel audiofile-devel.i686 audiofile-devel cups-devel.i686 cups-devel dbus-devel.i686 dbus-devel fontconfig-devel.i686 fontconfig-devel freetype.i686 freetype-devel.i686 freetype-devel giflib-devel.i686 giflib-devel lcms-devel.i686 lcms-devel libICE-devel.i686 libICE-devel libjpeg-turbo-devel.i686 libjpeg-turbo-devel libpng-devel.i686 libpng-devel libSM-devel.i686 libSM-devel libusb-devel.i686 libusb-devel libX11-devel.i686 libX11-devel libXau-devel.i686 libXau-devel libXcomposite-devel.i686 libXcomposite-devel libXcursor-devel.i686 libXcursor-devel libXext-devel.i686 libXext-devel libXi-devel.i686 libXi-devel libXinerama-devel.i686 libXinerama-devel libxml2-devel.i686 libxml2-devel libXrandr-devel.i686 libXrandr-devel libXrender-devel.i686 libXrender-devel libxslt-devel.i686 libxslt-devel libXt-devel.i686 libXt-devel libXv-devel.i686 libXv-devel libXxf86vm-devel.i686 libXxf86vm-devel mesa-libGL-devel.i686 mesa-libGL-devel mesa-libGLU-devel.i686 mesa-libGLU-devel ncurses-devel.i686 ncurses-devel openldap-devel.i686 openldap-devel openssl-devel.i686 openssl-devel zlib-devel.i686 pkgconfig sane-backends-devel.i686 sane-backends-devel xorg-x11-proto-devel glibc-devel.i686 prelink fontforge flex bison libstdc++-devel.i686 pulseaudio-libs-devel.i686 gnutls-devel.i686 libgphoto2-devel.i686 openal-soft-devel openal-soft-devel.i686 isdn4k-utils-devel.i686 gsm-devel.i686 samba-winbind libv4l-devel.i686 cups-devel.i686 libtiff-devel.i686 gstreamer-devel.i686 gstreamer-plugins-base-devel.i686 gettext-devel.i686 libmpg123-devel.i686  
<font face="微软雅黑, Tohoma">
</font>
          之后，再运行 qq.sh 
<font face="微软雅黑, Tohoma">
</font>
     #./qq.sh
<font face="微软雅黑, Tohoma">
</font>
    qq-wine除视频聊天功能外，其它功能均可使用，但运行效果没有windows上好。
<font face="微软雅黑, Tohoma">
</font>
15.安装tomcat、mysql等 
<font face="微软雅黑, Tohoma">
</font>
       tomcat可在官网直接下载，解压后就可以使用；mysql mysql-server可在终端安装
              之后是各种配置，略去。
<font face="微软雅黑, Tohoma">
</font>
16.喜欢kde集成桌面环境的话，可以安装kde（很大的），个人感觉还是gnome好。
<font face="微软雅黑, Tohoma">
</font>
       yum install @KDE-desktop
<font face="微软雅黑, Tohoma">
</font>
17.经常更新系统的话，会出现很多内核（kernel），处理virtualbox使用问题时安装kernel的扩展软件包也会下载debug版本的内核
<font face="微软雅黑, Tohoma">
</font>
          进入/boot目录，可以把不需要加载的内核版本删除，如要删除内核3.9.5-6.fc19.x86_64 则把 
<font face="微软雅黑, Tohoma">
</font>
           config-3.9.5-6.fc19.x86_64
<font face="微软雅黑, Tohoma">
</font>
          System.map-3.9.5-6.fc19.x86_64
<font face="微软雅黑, Tohoma">
</font>
          vmlinuz-3.1.9-6.fc19.x86_64
<font face="微软雅黑, Tohoma">
</font>
          initramfs-3.9.5-6.fc19.x86_64.img
<font face="微软雅黑, Tohoma">
</font>
        都删除，然后执行以下命令：
<font face="微软雅黑, Tohoma">
</font>
          #grub2-mkconfig -o /boot/grub2/grub.cfg
<font face="微软雅黑, Tohoma">
</font>
