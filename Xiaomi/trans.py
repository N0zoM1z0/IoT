import os

res = os.popen("find ./ -name *.lua").readlines()

for i in range(0, len(res)) :
    path = res[i].strip("\n")
    cmd = "java -jar /home/iot/Desktop/IoT/lua/unluac.jar " + path + " > " + path + ".dis"
    print(cmd)
    os.system(cmd)
