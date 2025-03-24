可以直接binwalk -Me解uImage~

# 1. 凭据硬编码

/etc/shadow

![image-20241225110550720](./WR450D_28AE5_D-Open(V1.01)_TFTP/images/image-20241225110550720.png)



用hashcat进行破解，发现是弱密钥 admin：

![image-20241225110633250](./WR450D_28AE5_D-Open(V1.01)_TFTP/images/image-20241225110633250.png)