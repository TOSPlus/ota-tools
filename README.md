Tencent OS Auto genrate OTA Package tools<br>
腾讯TOS 自动生成OTA差分包工具
===============

使用方法：

+ git clone:

```
git clone https://github.com/TOSPlus/ota-tools
```

+ 赋权

```
chmod 777 build -R
chmod 777 make_ota
```

+ 找到target-files.zip包

在使用TPS工具生成zip的时候，会自动生成一个target-files.zip（名字类似）这个zip包的文件目录结构为:

```
.
├── BOOT
├── BOOTABLE_IMAGES
├── META
├── OTA
├── RADIO
├── RECOVERY
└── SYSTEM
```

第一次生成的 我们假设为20151108_target-files.zip,第二次生成的我们假设为20151115_target-files.zip

那么使用命令：

    ./make_ota 20151108_target-files.zip 20151115_target-files.zip

即可以生成差分包，So，enjoy

部分机友反馈了‘PORT_ROOT'报错的问题，有可能是使用了之后又移动了这个文件夹导致，这个时候只需要在执行上一步之前先执行一次:

    . build/config.sh

就可以了

如果需要生成特定OTA包，可以指定自定义的releasetools.py在这个里面增加回调函数。指定releasetools.py和命名为 -s例如：

        ./make_ota -s releasetools.py 20151108_target-files.zip 20151115_target-files.zip
