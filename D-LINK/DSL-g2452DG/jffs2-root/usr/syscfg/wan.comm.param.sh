#######################################################
# this script defines some common parameters
# those parameters will be used by wan related script.
#######################################################
BR_INTF=br0
phy_wanifname="eth0"
#wifi_if_prefix="ra"
#lan_if_prefix="eth0."

l2md_file="/tmp/l2md_type"
L2UP_FILE="l2up"
L2IFNAME_FILE="l2ifname"

CONN_FOLFER_PREFIX="/tmp"
CONN_IFNAME_DIR="/tmp/conn_ifname"

USER_DEFINED_DNS="user_defined_dns"
SERVER_ASSIGNED_DNS="server_assigned_dns"
SERVER_ASSIGNED_TFTP_ADDR="server_assigned_tftp_addr"
CONN_TFTP_ADDR_PATH="/tmp/${SERVER_ASSIGNED_TFTP_ADDR}"
GATEWAY_FILE="gateway"
IPADDR_FILE="ip_address"
UPTIME_FILE="uptime"
IFNAME_FILE="ifname"
DCHP_LEASETIME="dhcp_leasetime"
PPPoE_OPTIONS="options.pppoe"
CHAT_OPTIONS="options.chat"
PPPoA_OPTIONS="options.pppoa"
IP_ADDRESS="ip_address"
PPP_IFNAME="ppp_ifname"
PPP_LINKNAME="ppp_linkname"
PPP_IPREMOTE="ppp_ipremote"
PPP6_LLLOCAL="ppp6_llocal"
PPP6_LLREMOTE="ppp6_llremote"
PPP_SESSIONID="ppp_sessionid"
PPP_LOCK_FLAG="ppp_lock_flag"
PPPOE_PROXY_DNS="pppoe_proxy_dns"

PIDFILE_DHCP="pid_dhcp"
PIDFILE_PPPoE="pid_pppoe"
PIDFILE_PPPoA="pid_pppoa"
PIDFILE_PPPD="pid_pppd"

DHCPC_SCRIPT="udhcpc.sh"
DHCPC_PRE_SCRIPT="/usr/syscfg/pre_udhcpc.sh"
DHCPC_RELEASE_SCRIPT="udhcpc_release.sh"
DHCPC_RENEW_SCRIPT="udhcpc_renew.sh"
RELEASE_DONE_FLAG="release_done_flag"

PPP_CONNECT_SCRIPT="ppp_connect.sh"
PPP_DISCONNECT_SCRIPT="ppp_disconnect.sh"
PPP_DEMAND_SCRIPT="ppp_demand.sh"
PPP_IP_UP_SCRIPT="ip_up.sh"
PPP_IP_UP_PRE_SCRIPT="/usr/syscfg/pre_ip_up.sh"
PPP_IP_DOWN_SCRIPT="ip_down.sh"
PPP_IP_DOWN_PRE_SCRIPT="/usr/syscfg/pre_ip_down.sh"
CONN_PPPoE="/usr/syscfg/conn_pppoe.sh"
CONN_PPPoA="/usr/syscfg/conn_pppoa.sh"
#pppoe and pppoe use the same plugin
pppoe_plugin_path="/usr/lib/pppd/2.4.5/rp-pppoe.so"
pppoa_plugin_path="/usr/lib/pppd/2.4.5/rp-pppoe.so"

#this file include the path of user defined or server assigned dns file under wan connection dir.
dns_files_path="/tmp/dns_files"
dns_operate_lock_path="/tmp/dns_operate_lock"
dns_global_path="/etc/resolv.conf"

available_group_interface="/tmp/available_group_interface"
ALL_LAN="eth0.2 eth0.3 eth0.4 eth0.5 ra0 ra1 ra2 ra3"

#scripts under this dir will be called when interface up/down to below parameters.
IF_HOTPLUG_DIR="/usr/syscfg/if_hotplug"
IF_HOTPLUG_DIR6="/usr/syscfg/if_hotplug6"

PTM_IFNAME="nas_p1"
WAN_ETH_IFNAME="nas1"
dsllinkconfig_lock_flag="/var/dsllinkconfig_lock_flag"
raaction_lock_flag="/var/raaction_lock_flag"

IP6_UPTIME="ip6_uptime"
IP6_ADDR="ip6_address"
IP6_GATEWAY_FILE="ip6_gateway"
IP6_PD_ADDR_FILE="ip6_pd_address"
IP6_USER_DEFINED_DNS="ip6_user_defined_dns"
IP6_SERVER_ASSIGNED_DNS="ip6_server_assigned_dns"
IP6_PIDFILE_DHCP="ip6_pid_dhcp"
IP6_AUTO_START_SCRIPT="ip6_auto_start.sh"
IP6_DHCP_START_SCRIPT="ip6_dhcp_start.sh"
IP6_DHCP6C_SCRIPT="ip6_dhcp6c.sh"
PPP_IP6_UP_SCRIPT="ip6_up.sh"
PPP_IP6_DOWN_SCRIPT="ip6_down.sh"
wan_status_update_path="/usr/syscfg/status/wanConn.sh"
laninterface_bind_policy_script="100_laninterface_bind_policy.sh"
laninterface_policy_routing_ipv4_script="120_laninterface_policy_routing_ipv4.sh"
laninterface_policy_routing_ipv6_script="120_laninterface_policy_routing_ipv6.sh"

ipv4_nat_script="201_ipv4_nat.sh"
ipv4_default_route_script="202_ipv4_default_route.sh"
ipv4_if_hotplug_script="203_ipv4_if_hotplug.sh"
ipv4_forwarding_script="204_ipv4_forwarding.sh"
ipv4_dns_script="205_ipv4_dns.sh"
ipv4_route_flow_accel_script="206_ipv4_route_flow_accel.sh"

ipv4_tr069_script="211_ipv4_tr069.sh"
ipv6_tr069_script="211_ipv6_tr069.sh"
iptv_script="212_iptv.sh"

ipv6_default_route_script="222_ipv6_default_route.sh"
ipv6_if_hotplug_script="223_ipv6_if_hotplug.sh"
ipv6_forwarding_script="224_ipv6_forwarding.sh"
ipv6_dns_script="225_ipv6_dns.sh"
ipv6_pd_script="226_ipv6_pd.sh"

WP_IPMODE_IPV4=1
WP_IPMODE_IPV6=2
WP_IPMODE_IPV4_IPV6=3
VOIP_RESOLV="/tmp/.resolv_voip.conf"
voip_table_id=105
tr069_table_id=106
