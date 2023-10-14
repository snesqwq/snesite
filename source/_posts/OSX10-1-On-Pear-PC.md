---
abbrlink: '16979'
categories:
- 软件
date: '2023-10-14T10:49:00+08:00'
tags:
- PearPC
title: PearPC 安装小记
updated: 2023-10-14T21:13:34.338+8:0
---
[PearPC](https://pearpc.sourceforge.net/)是一个PowerPC Mac模拟器。本文将会介绍如何使用PearPC安装MacOS X 10.1。

## 下载

前往[PearPC Download](https://pearpc.sourceforge.net/downloads.html)处下载PearPC 0.4和虚拟硬盘并取得一个Mac OS X 10.1的镜像。

## 配置

复制 `ppccfg.example`并重命名为 `ppc.cfg`，将文件替换为下面的内容:

<details> <summary>查看要替换的内容</summary>
如下

```config
## PearPC 配置文件

##
## 启动分辨率
##
## （使用 video.x 的客户端可以在运行时更改分辨率，
## 因此这只用于启动时）
##
## 格式："(宽度)x(高度)x(色深)"
## 或 "(宽度)x(高度)x(色深)@(频率)"
##
## 色深只能为15或32
##
## 默认值："800x600x15"
##

ppc_start_resolution = "800x600x15"

##
## 设置此项为非零以在启动时启用全屏模式。
##

ppc_start_full_screen = 0

##
## 重绘间隔（以毫秒为单位）
## 必须介于10和500之间
##
## 如果您将此值设置得更高，PearPC 将花更少的时间进行重绘
## （从而运行得更快），但响应性更差。您应根据计算机速度和个人喜好来调整此值。
##

redraw_interval_msec = 40

##
## 按键代码
##

key_compose_dialog = "F11"
key_change_cd_0 = "none"
key_toggle_mouse_grab = "F12"
key_toggle_full_screen = "Alt+Return"

##
## 启动加载器
##

##
## 引导方法
## 这可以是：
## 1. "auto"，PROM 将引导找到的第一个可引导分区（默认值）
## 2. "select"，PROM 将显示可引导分区的列表
## 3. "force"，PROM 将加载并引导本地文件 prom_loadfile
##

prom_bootmethod = "auto"

## 使用 "force" 的示例：

#prom_bootmethod = "force"
#prom_loadfile = "test/yaboot"
#prom_env_bootpath = "disk"

##
## bootargs：除非您知道自己在做什么，否则不要更改
## machargs：设置为"-v"以获取详细的启动信息
##

#prom_env_bootargs = ""
prom_env_machargs = "-v"

##
## 如果要引导 Mac OS X，则需要这个
##

prom_driver_graphic = "video.x"

## 这将调整初始页表的位置（不要更改）

#page_table_pa = 104857600

##
## CPU 配置
##
## 处理器版本寄存器
## 默认为0x00088302（G3）
## 将其设置为0x000c0201以启用G4仿真
## 除非您知道自己在做什么，否则不要更改
##

#cpu_pvr = 0x00088302
#cpu_pvr = 0x000c0201

##
## 主内存（默认为128 MiB）
## 必须至少为64 MiB
##

#memory_size=0x8000000

##
## IO 设备
##

##
## PCI IDE 配置
##
## 驱动器类型将根据文件扩展名设置为：
## .img：硬盘（文件大小必须是516096的倍数）
## .iso：CD-ROM
## 或者您可以通过指定类型来覆盖此设置
## pci_ide0_master_type / pci_ide0_slave_type
##
## 有效的驱动器类型包括：
## hd：应指定硬盘映像
## 例如 "test/imgs/linux.img"
## cdrom：应指定 CD-ROM 映像
## 对于 Linux 或 BeOS，还可以指定 CD-ROM 设备
## 例如 "/dev/cdrom"
## nativecdrom：与平台相关
## Win（SPTI）：驱动器号，例如 "d:\"
## Win（ASPI）：SCSI 主机适配器、目标、LUN，例如 "2,0,1"
## BeOS（ATAPI）：设备路径，例如 "/dev/disk/ide/atapi/0/master/0/raw"

pci_ide0_master_installed = 1
pci_ide0_master_image = "test/imgs/linux.img"
#pci_ide0_master_type = "hd"

pci_ide0_slave_installed = 1
#pci_ide0_slave_image = "e:\"
#pci_ide0_slave_image = "2,0,0"
pci_ide0_slave_image = "/dev/cdrom"
pci_ide0_slave_type = "cdrom"

##
## 网络
##
## 选择以下其中一个网卡

pci_3c90x_installed = 0
pci_3c90x_mac = "de:ad:ca:fe:12:34"

pci_rtl8139_installed = 0
pci_rtl8139_mac = "de:ad:ca:fe:12:35"

##
## USB
##
pci_usb_installed = 1

##
## NVRAM
##
nvram_file = "nvram"

```

如上

</details>

替换完后，开始编辑 `ppc.cfg`。

1. `ppc_start_resolution = "1024x768x32"` 控制屏幕分辨率和色深，其中 **1024x768** 是屏幕分辨率，而 **x32** 是色深。请确保分辨率合理，不要高于实际显示器分辨率。色深可选择 **x15** 或 **x32**，其中 **x32** 提供更丰富的颜色表现。
2. `ppc_start_full_screen = 0` 表示是否全屏。**0** 表示不全屏，**1** 表示全屏。
3. `redraw_interval_msec = 40` 是重绘间隔，应设置在 **10 到 500 之间**。更低的重绘间隔可以提供更快的速度，但也需要更高的主机性能。设置在 **10** 可以获得最好的性能。
4. `key_*` 项用于指定键值， `key_compose_dialog` 打开组合键对话框， `key_change_cd_0` 用于更改CD， `key_toggle_mouse_grab` 用于切换鼠标捕获， `key_toggle_full_screen` 用于切换全屏。
5. `prom_bootmethod = "auto"` 用于更改引导方法。确保将 `auto` 更改为 `select`，否则可能导致启动问题。
6. `prom_env_*` 项是启动环境设置。要在 "啰嗦模式" 下获得更详细的日志，可以将 `prom_env_machargs = ""` 选项更改为 `prom_env_machargs = "-v"`。最好不要更改 `prom_env_bootargs = ""` 的值。如果要安装 Mac OS X 10.3 及更低版本的系统，需取消注释 `prom_env_bootargs = ""` 值前的 `#` 符号。
7. `prom_driver_graphic = "video.x"` 是GPU驱动。如果要在PearPC上运行BeOS、Linux等系统，可以在前面添加 "#" 注释符。
8. `cpu_pvr = *` 项用于指定CPU型号。通常不建议更改此选项。 `cpu_pvr = 0x00088302` 表示G3，`cpu_pvr = 0x000c0201` 表示G4。`memory_size=0x20000000`项是内存大小(十六进制 使用MiB)，通常128MiB即可
9. `pci_ide0_*` 项是PCI IDE选项。请将 `pci_ide0_master_image = "image.img"` 更改为虚拟硬盘的完整地址，将 `pci_ide0_slave_image = "macosx.iso"` 更改为虚拟光盘的完整地址。

编辑完成后，在终端中输入 `ppc.exe ppc.cfg` 来启动PearPC。在弹出窗口中输入 `1` 并按回车键即可进入系统。

## 其它

另外，我制作了一个**PearPC+MacOSX10.1**懒人包。无需任何多余配置，可以直接使用 `启动PearPC.bat`来快速安装并体验Mac OS X 10.1。
[PearPC0.4+MacOSX10.1懒人包](https://snesite-my.sharepoint.com/:u:/g/personal/snes_snesite_onmicrosoft_com/ERmQhbHA-2BKh-c04X1oCxEByBbMH6WIn1c3npZvlUI3iw?e=PlT8Ns)
