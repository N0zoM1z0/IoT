# 固件解密

> 小米的固件最外面用的是UBIFS文件系统，固件本身没有加密，先用binwalk解出一个.ubi文件，然后用ubireader_extract_images xxx.ubi，可以在ubifs-root内解出三个.ubifs文件，对其中的xxx-ubi_rootfs.ubifs用binwalk再解开，即可得到里面的SquashFS文件系统，也就是核心部分。
> 



# lua反编译

> 小米的前端也是用的Lua编写的，但是其中的Lua文件不是源码，而是编译后的二进制文件，所以我们需要对其进行反编译。目前，对Lua反编译的常用工具有unluac和luadec。但是小米对Lua的解释器做了魔改，就不能直接用这两个工具进行反编译了，所幸已有师傅对此做了研究，并给出了专门针对小米固件的反编译工具unluac_miwifi和luadec_miwifi。至于如何对被魔改的解释器或编译器所编译出来的Lua字节码进行逆向，网上也有不少文章，这里不再展开。
> 
>

参考这个文章的解就行：

```
https://blog.csdn.net/jennycisp/article/details/140493218
```

关键的api相关的都还是能解的。

/usr/lib/lua/luci/controller



# 漏洞挖掘

难。。。 lua字节码。。。emmm，慢慢研究吧，

```
https://cn-sec.com/archives/2611064.html
```

