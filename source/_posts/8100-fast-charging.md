title: 'Magisk模块解析:8100 Fast charging'
abbrlink: 25376
tags:
  - Note11TPro
  - Magisk
categories:
  - 玩机
  - ''
  - ''
author: LAGSNES
date: 2023-09-12 20:36:00
---
如果你是一位 `Android` 手机`ROOT`爱好者，特别是在寻找更快充电体验的用户且处理器是`天玑8100`，那么`8100 Fast Charging`模块可能正是你需要的。这个模块旨在提升你的 Android 设备的充电速度，下面将深入介绍这个模块的技术细节以及它的一些关键功能。

## 模块概览

`8100 Fast Charging` 是一个 `Magisk` 模块，专为 `Magisk` 根权限管理工具设计。它的主要目标是通过调整电池充电电流的常量值来提高 Android 设备的充电速度。以下是这个模块的关键技术信息：

## 模块主要功能

该模块的主要功能是：

- **快速充电优化：** `8100 Fast Charging` 模块通过调整电池充电电流的常量值，实现更快的充电速度。这意味着你可以在更短的时间内充满你的设备电池。

## 模块解析

接下来将会深度解析该模块:

#### 1. 安装脚本

模块的安装脚本定义了一些配置标志和回调函数，用于自定义Magisk模块的安装和操作。具体来说，它执行以下操作：

1. **定义了配置标志 (`Config Flags`)：**  
这些标志控制了模块的一些行为。例如，`SKIPMOUNT` 设置为 `false` 表示模块需要由Magisk自动挂载文件，`PROPFILE` 设置为 `true` 表示需要加载 `system.prop` 等。

2. **定义了文件替换列表 (`REPLACE`)：**  
这个部分允许你指定要直接替换的系统目录或文件。在当前的代码中，这个列表是空的，意味着目前**在安装脚本内没有指定要替换的文件或目录**。

3. **定义了回调函数：这个模块包括两个回调函数：**  
- `print_modname()`：该函数用于定义在安装模块时显示的模块名称，但在当前的代码中只是一个空函数。
- `on_install()`：该函数在模块安装时执行。它解压缩模块文件并创建一个 `/data/current_power.conf` 文件并写入 `21000000`。这些操作通常用于模块的初始化。

4. **定义了权限设置函数 (`set_permissions()`)：**  
在模块安装完成后，可以使用此函数设置特定文件的权限。然而，在当前的代码中，此函数只是一个空函数，表示默认的权限应该适用于大多数情况。

总之，这段代码定义了模块的安装和初始化过程，但并没有实际执行特定的系统操作或替换文件。具体的操作需要在 `on_install()` 和可能的权限设置函数中进行定义。

<details> <summary>查看完整代码</summary>
下面是安装脚本完整代码:

```Magisk
# Config Flags

# Set to true if you do *NOT* want Magisk to mount
# any files for you. Most modules would NOT want
# to set this flag to true
SKIPMOUNT=false

# Set to true if you need to load system.prop
PROPFILE=true

# Set to true if you need post-fs-data script
POSTFSDATA=false

# Set to true if you need late_start service script
LATESTARTSERVICE=true

# Replace list

# List all directories you want to directly replace in the system
# Check the documentations for more info why you would need this

# Construct your list in the following format
# This is an example
# REPLACE_EXAMPLE="
# /system/app/Youtube
# /system/priv-app/SystemUI
# /system/priv-app/Settings
# /system/framework
# "

# Construct your own list here
REPLACE=""

# Function Callbacks

# The following functions will be called by the installation framework.
# You do not have the ability to modify update-binary, the only way you can customize
# installation is through implementing these functions.
#
# When running your callbacks, the installation framework will make sure the Magisk
# internal busybox path is *PREPENDED* to PATH, so all common commands shall exist.
# Also, it will make sure /data, /system, and /vendor is properly mounted.

# The installation framework will export some variables and functions.
# You should use these variables and functions for installation.
#
# ! DO NOT use any Magisk internal paths as those are NOT public API.
# ! DO NOT use other functions in util_functions.sh as they are NOT public API.
# ! Non public APIs are not guranteed to maintain compatibility between releases.
#
# Available variables:
#
# MAGISK_VER (string): the version string of current installed Magisk
# MAGISK_VER_CODE (int): the version code of current installed Magisk
# BOOTMODE (bool): true if the module is currently installing in Magisk Manager
# MODPATH (path): the path where your module files should be installed
# TMPDIR (path): a place where you can temporarily store files
# ZIPFILE (path): your module's installation zip
# ARCH (string): the architecture of the device. Value is either arm, arm64, x86, or x64
# IS64BIT (bool): true if $ARCH is either arm64 or x64
# API (int): the API level (Android version) of the device
#
# Availible functions:
#
# ui_print <msg>
#     print <msg> to console
#     Avoid using 'echo' as it will not display in custom recovery's console
#
# abort <msg>
#     print error message <msg> to console and terminate installation
#     Avoid using 'exit' as it will skip the termination cleanup steps
#
# set_perm <target> <owner> <group> <permission> [context]
#     if [context] is empty, it will default to "u:object_r:system_file:s0"
#     this function is a shorthand for the following commands
#       chown owner.group target
#       chmod permission target
#       chcon context target
#
# set_perm_recursive <directory> <owner> <group> <dirpermission> <filepermission> [context]
#     if [context] is empty, it will default to "u:object_r:system_file:s0"
#     for all files in <directory>, it will call:
#       set_perm file owner group filepermission context
#     for all directories in <directory> (including itself), it will call:
#       set_perm dir owner group dirpermission context
#

# Set what you want to display when installing your module
print_modname() {
       return
       }

       # Copy/extract your module files into $MODPATH in on_install.
       on_install() {
             ui_print "- Extracting module files"
                 unzip -o "$ZIPFILE" -x 'META-INF/*' -d $MODPATH >/dev/null
                     touch /data/current_power.conf
                         echo 21000000 > /data/current_power.conf
                         }

                         # Only some special files require specific permissions
                         # This function will be called after on_install is done
                         # The default permissions should be good enough for most cases
                         set_permissions() {
                               return
                               }

                               # You can add more functions to assist your custom script code
                         }
       }
}
```
如上
</details>

#### 2. `service.sh`

`service.sh`执行以下操作：

1. 设置变量`MODDIR`为脚本所在目录，通过`${0%/*}`获取脚本路径并去掉最后一个斜杠，以便后续使用。

2. 不直接硬编码路径`/magisk/modname/...`，而是使用变量`$MODDIR/...`。这样做可以增加脚本的兼容性，即使未来Magisk更改了挂载点。

3. 脚本将以"late_start service"模式执行，这意味着它将在系统启动完成后延迟执行。

4. `sleep 15`命令将脚本暂停执行15秒。

5. `cat /data/current_power.conf > /sys/class/power_supply/battery/constant_charge_current`命令将读取`/data/current_power.conf`文件的内容，并将其重定向（覆盖）到`/sys/class/power_supply/battery/constant_charge_current`文件中。这可能是用来设置电池的恒定充电电流。

<details> <summary>查看完整代码</summary>
下面是service.sh的完整代码：
  
```Magisk
#!/system/bin/sh
# 请不要硬编码 /magisk/modname/... ; 请使用 $MODDIR/...
# 这将使你的脚本更加兼容，即使Magisk在未来改变了它的挂载点
MODDIR=${0%/*}

# 这个脚本将以 late_start service 模式执行
# 更多信息请访问 Magisk 主题

sleep 15
cat /data/current_power.conf > /sys/class/power_supply/battery/constant_charge_current
```
如上
</details>



## 安全性考虑

使用这个模块需要谨慎，因为过高的充电电流可能会对设备电池产生潜在的损害。

## 结语

`8100 Fast Charging` 模块是一个用于优化 Android 设备充电速度的 `Magisk` 模块。它通过调整充电电流的常量值，使你可以更快地充满你的设备电池。在使用此类模块时，请谨慎操作，以免对设备造成潜在的风险或损害。