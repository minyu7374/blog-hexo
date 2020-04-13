---
title: "Archlinux 安装经验简要总结"
date: "2016-02-01T18:03:27+08:00"
categories:
tags:
---

                                            
#############grub###############


pacman -S grub efibootmgr


############软件源和软件包管理工具########


pacman(wget)

powerpill

yaourt

reflector

reflector -l 30 -f 12 | cat > mirrorlist



#配置/etc/pacman.conf

# to install owerpill

[xyne-any]

SigLevel = Required

Server = http://xyne.archlinux.ca/repos/xyne/



#archlinux中文社区

[archlinuxcn]

SigLevel = Optional TrustAll

Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch



############桌面环境及工具##############


pacman -S kf5 kf5-aids

pacman -S plasma kdebase kdegraphics-ksnapshot gwenview

pacman -R plasma-mediacenter


#后两个是 Unicode font（为中文支持）
pacman -S ttf-freefont ttf-arphic-ukai ttf-arphic-uming   


pacman -S sddm sddm-kcm

pacman -S gtk-engines gtk2 gtk3 gnome-themes-standard gnome-icon-theme



pacman -S ntp

systemctl enable ntpd

pacman -S networkmanager net-toolss

pacman -S networkmanager net-tools

systemctl enable NetworkManager dhcpcd



pacman -S alsa-utils pulseaudio pulseaudio-alsa libcanberra-pulse libcanberra-gstreamer jack2-dbus

pacman -S ntfs-3g

pacman -S ark p7zip zip unzip unrar wxgtk


##################主题安装#################


# grub theme

yourt grub2-theme-breeze-git



# 编辑/etc/default/grub文件 

GRUB_THEME="/boot/grub/themes/breeze/theme.txt"

GRUB_GFXMODE=1024x768



grub-mkconfig -o /boot/grub/grub.cfg



# sddm theme

yaourt -S sddm-numix-theme-git sddm-theme-archpaint2-breeze sddm-urbanlifestyle-theme  solarized-sddm-theme 



# 编辑/etc/sddm.conf

[Theme]

Current=solarized-sddm-theme


# To change the font used in this theme, add the following lines to /usr/share/sddm/themes/solarized-sddm-theme/theme.conf

[General]

displayFont=''
