---
title: "我的opensuse系统备份镜像方案"
date: "2015-03-17T23:49:49+08:00"
categories:
tags:
---

                                            
fdisk -l 查看的分区情况：


Disk /dev/sda：465.8 GiB，500107862016 字节，976773168 个扇区

单元：扇区 / 1 * 512 = 512 字节

扇区大小(逻辑/物理)：512 字节 / 512 字节

I/O 大小(最小/最佳)：512 字节 / 512 字节

磁盘标签类型：gpt

磁盘标识符：CCC3A254-1C29-4936-8535-53196D51488E


Device         Start       End   Sectors   Size Type

/dev/sda1       2048    307199    305152   149M EFI System

/dev/sda2     307234   6598690   6291457     3G Linux swap

/dev/sda3    6598691 111456299 104857609    50G Linux filesystem

/dev/sda4  111456300 136622132  25165833    12G Linux filesystem

/dev/sda5  136622133 976773134 840151002 400.6G Linux filesystem


df -h看到的磁盘使用情况：


文件系统        容量  已用  可用 已用% 挂载点

/dev/sda3        51G   18G   30G   38% /

devtmpfs        3.7G  8.0K  3.7G    1% /dev

tmpfs           3.7G   84K  3.7G    1% /dev/shm

tmpfs           3.7G  2.4M  3.7G    1% /run

tmpfs           3.7G     0  3.7G    0% /sys/fs/cgroup

/dev/sda3        51G   18G   30G   38% /.snapshots

/dev/sda3        51G   18G   30G   38% /var/tmp

/dev/sda3        51G   18G   30G   38% /var/spool

/dev/sda3        51G   18G   30G   38% /var/opt

/dev/sda3        51G   18G   30G   38% /var/log

/dev/sda3        51G   18G   30G   38% /var/lib/named

/dev/sda3        51G   18G   30G   38% /var/lib/mailman

/dev/sda3        51G   18G   30G   38% /var/lib/pgsql

/dev/sda3        51G   18G   30G   38% /var/crash

/dev/sda3        51G   18G   30G   38% /usr/local

/dev/sda3        51G   18G   30G   38% /tmp

/dev/sda3        51G   18G   30G   38% /srv

/dev/sda3        51G   18G   30G   38% /opt

/dev/sda3        51G   18G   30G   38% /boot/grub2/x86_64-efi

/dev/sda3        51G   18G   30G   38% /boot/grub2/i386-pc

/dev/sda1       149M  4.9M  145M    4% /boot/efi

/dev/sda4        12G  792M   11G    7% /home

/dev/sda5       395G  100G  295G   26% /data


我的备份方案：

1、将/dev/sda5的自动挂载项从 /etc/fstab 中注释掉(该分区不存储任何系统相关数据);

2、启动另外的Linux/Unix系统;

3、备份 dd  bs=512 count=136622133[即/dev/sda4 end数+1] if=/dev/sda of=/mybakdir/myopensuse.iso;

4、恢复 dd if=/mybakdir/myopensuse.iso of=/dev/sda;


注意：

    不能直接在计算机上用本地磁盘启动系统后执行dd命令生成本地磁盘的镜像，而应该使用livecd启动计算机。因此计算机运行时会对系统盘产生大量写操作，直接对运行中的系统盘生成的镜像，在恢复到其他硬盘上时，很可能会无法启动！


    要使用 dd 和 gzip 生成压缩的镜像文件，可以执行命令：

        #dd bs=512 count=[end+1] if=/dev/sda | gzip > /mybakdir/myopensuse.iso （gzip默认压缩级别是6）

    还原时，可以执行命令：

        #gzip -dc /mybakdir/myopensuse.iso | dd of=/dev/sda


