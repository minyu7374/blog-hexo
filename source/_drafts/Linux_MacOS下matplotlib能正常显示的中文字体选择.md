---
title: "Linux/MacOS下matplotlib能正常显示的中文字体选择"
date: "2017-03-23T17:17:54+08:00"
categories:
tags:
---

                                            
下面的Python脚本可以检测到 *nix 系统内 matplotlib 支持正常显示的中文字体（用到了命令行工具 fc-list ）：


```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-
# File Name: font_check.py
# Created Time: Thu Mar 23 16:53:59 2017

__author__ = 'minyu'
__mail__ = 'minyu7374@gmail.com'

from matplotlib.font_managerimport FontManager
import subprocess

mpl_fonts = set(f.namefor f in FontManager().ttflist)

print ('all font list get from matplotlib.font_manager:')
for f in sorted(mpl_fonts):
    print('\t' + f)

# for python2
# output = subprocess.check_output('fc-list :lang=zh -f "%{family}\n"', shell=True)
# for python3
output = subprocess.check_output('fc-list :lang=zh -f "%{family}\n"', shell=True, encoding="utf8")

zh_fonts = set(f.split(',',1)[0] for f in output.split('\n'))

print('\n' +'Chinese font list get from fc-list:')
for f in sorted(zh_fonts):
    print('\t' + f)

print('\n' +'the fonts we can use:')
available = set(mpl_fonts) & set(zh_fonts)
for f in available:
    print('\t' + f)
```


在个人的 MacOS Sierra 系统下运行结果如下：


```python
Fontconfig warning: ignoring UTF-8: not a valid region tag
all font list get from matplotlib.font_manager:
	.Keyboard
	.LastResort
	.SF Compact Display
	.SF Compact Rounded
	.SF Compact Text
	.SF NS Display Condensed
	.SF NS Text Condensed
	Andale Mono
	Apple Braille
	Apple Chancery
	Apple Symbols
	AppleGothic
	AppleMyungjo
	Arial
	Arial Black
	Arial Narrow
	Arial Rounded MT Bold
	Arial Unicode MS
	Ayuthaya
	Big Caslon
	Bitstream Vera Sans
	Bitstream Vera Sans Mono
	Bitstream Vera Serif
	Bodoni 72 Smallcaps
	Bodoni Ornaments
	Bradley Hand
	Brush Script MT
	Chalkduster
	Comic Sans MS
	Consolas
	Courier New
	DIN Alternate
	DIN Condensed
	DejaVu Sans
	DejaVu Sans Display
	DejaVu Sans Mono
	DejaVu Serif
	DejaVu Serif Display
	Diwan Thuluth
	East Syriac Adiabene
	East Syriac Ctesiphon
	Estrangelo Antioch
	Estrangelo Edessa
	Estrangelo Midyat
	Estrangelo Nisibin
	Estrangelo Nisibin Outline
	Estrangelo Quenneshrin
	Estrangelo Talada
	Estrangelo TurAbdin
	Farisi
	Georgia
	Goha-Tibeb Zemen
	Gurmukhi MT
	Herculanum
	Hoefler Text
	Impact
	InaiMathi
	Khmer Sangam MN
	Kokonor
	Krungthep
	Lao Sangam MN
	Luminari
	Luxi Mono
	Luxi Sans
	Luxi Serif
	Microsoft Sans Serif
	Microsoft YaHei Mono
	Mishafi
	Mishafi Gold
	Plantagenet Cherokee
	STIXGeneral
	STIXIntegralsD
	STIXIntegralsSm
	STIXIntegralsUp
	STIXIntegralsUpD
	STIXIntegralsUpSm
	STIXNonUnicode
	STIXSizeFiveSym
	STIXSizeFourSym
	STIXSizeOneSym
	STIXSizeThreeSym
	STIXSizeTwoSym
	STIXVariants
	Sathu
	Serto Batnan
	Serto Jerusalem
	Serto Jerusalem Outline
	Serto Kharput
	Serto Malankara
	Serto Mardin
	Serto Urhoy
	Silom
	Skia
	Symbol
	System Font
	Tahoma
	Times New Roman
	Trattatello
	Trebuchet MS
	Verdana
	Webdings
	Wingdings
	Wingdings 2
	Wingdings 3
	YaHei Consolas Hybrid
	Zapf Dingbats
	Zapfino
	cmb10
	cmex10
	cmmi10
	cmr10
	cmss10
	cmsy10
	cmtt10
Fontconfig warning: ignoring UTF-8: not a valid region tag

Chinese font list get from fc-list:
	
	.Hiragino Sans GB Interface
	.LastResort
	.PingFang HK
	.PingFang SC
	.PingFang TC
	Arial Unicode MS
	Fixed
	GB18030 Bitmap
	Heiti SC
	Heiti TC
	Hiragino Sans GB
	Microsoft YaHei Mono
	PingFang HK
	PingFang SC
	PingFang TC
	STSong
	Songti SC
	Songti TC
	YaHei Consolas Hybrid

the fonts we can use:
	.LastResort
	Microsoft YaHei Mono
	YaHei Consolas Hybrid
	Arial Unicode MS
```



YaHei Consolas Hybrid 是我自己安装的字体，其他三个都是系统默认的，
这里选择了 YaHei Consolas Hybrid。




```python
mpl.rcParams['font.sans-serif'] = ['YaHei Consolas Hybrid'] #指定默认字体
mpl.rcParams['axes.unicode_minus'] = False # 解决保存图像是负号'-'显示为方块的问题
```


