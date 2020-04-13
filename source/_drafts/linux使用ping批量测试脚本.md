---
title: "linux使用ping批量测试脚本"
date: "2016-10-19T16:35:50+08:00"
categories:
tags:
---

                                            
最近使用的国外 vps 是来自 vultr.com的.
官方给的ping测试服务器列表如下:

```plain
Location        Looking Glass
Frankfurt, DE   fra-de-ping.vultr.com
Amsterdam, NL   ams-nl-ping.vultr.com
Paris, France   par-fr-ping.vultr.com
London, UK  lon-gb-ping.vultr.com
Singapore   sgp-ping.vultr.com
Tokyo, Japan    hnd-jp-ping.vultr.com
New York (NJ)   nj-us-ping.vultr.com
Chicago, Illinois   il-us-ping.vultr.com
Atlanta, Georgia    ga-us-ping.vultr.com
Miami, Florida  fl-us-ping.vultr.com
Seattle, Washington wa-us-ping.vultr.com
Dallas, Texas   tx-us-ping.vultr.com
Silicon Valley, California  sjo-ca-us-ping.vultr.com
Los Angeles, California lax-ca-us-ping.vultr.com
Sydney, Australia   syd-au-ping.vultr.com
```

将这些数据直接保存到 ip_address 文件里,
运行 bash 命令(都是最基本的语法和工具,不解释):

```ruby
awk 'NR > 1 {print $NF}' ip_address | while read x ; do echo `ping -c 30 $x |awk -F '[ /]' 'NR==1 {ip=$2$3":"} $1=="rtt" {print ip,$7,$8,$9}'` & done | sort -n -k3 | awk '{printf "%-45s %-15s %-15s %-15s\n", $1,$2,$3,$4}'
```



下面是运行结果:

```ruby
hnd-jp-ping.vultr.com(108.61.201.151):        61.624          65.094          78.236         
lax-ca-us-ping.vultr.com(108.61.219.200):     161.791         167.941         221.799        
sjo-ca-us-ping.vultr.com(104.156.230.107):    170.595         175.255         184.900        
wa-us-ping.vultr.com(108.61.194.105):         175.303         182.304         243.336        
sgp-ping.vultr.com(45.32.100.168):            182.084         183.536         189.696        
ams-nl-ping.vultr.com(108.61.198.102):        183.934         187.247         195.426        
lon-gb-ping.vultr.COM(108.61.196.101):        184.833         189.822         206.546        
tx-us-ping.vultr.com(108.61.224.175):         190.109         194.550         204.969        
par-fr-ping.vultr.COM(108.61.209.127):        192.152         195.276         201.048        
fra-de-ping.vultr.com(108.61.210.117):        194.960         208.688         227.831        
il-us-ping.vultr.com(107.191.51.12):          212.023         230.618         297.634        
nj-us-ping.vultr.com(108.61.149.182):         238.698         242.453         252.519        
fl-us-ping.vultr.com(104.156.244.232):        241.630         245.112         258.177        
ga-us-ping.vultr.com(108.61.193.166):         238.791         272.359         303.778        
syd-au-ping.vultr.com(108.61.212.117):        229.787         273.059         307.747    
```



