import os

res = os.popen("find /home/iot/Desktop/IoT/_miwifi_ra71_firmware_f91f7_1.0.93.bin.extracted/squashfs-root/usr/lib/lua -name '*.lua'").readlines()

for i in range(0, len(res)) :
    path = res[i].strip("\n")
    cmd = "java -jar /home/iot/Desktop/IoT/lua/unluac.jar " + path + " > " + path + ".dis"
    print(cmd)
    os.system(cmd)
