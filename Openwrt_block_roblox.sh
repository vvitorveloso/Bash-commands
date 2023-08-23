#https://openwrt.org/docs/guide-user/firewall/fw3_configurations/dns_ipset
# Install packages
#opkg update
#opkg remove dnsmasq
#opkg install dnsmasq-full ipset resolveip
 
########https://openwrt.org/docs/guide-user/advanced/ipset_extras
alias uclient-fetch="uclient-fetch --no-check-certificate"
uclient-fetch -O ipset-extras.sh "https://openwrt.org/_export/code/docs/guide-user/advanced/ipset_extras?codeblock=0"
. ./ipset-extras.sh


#############https://openwrt.org/docs/guide-user/advanced/hotplug_extras

alias uclient-fetch="uclient-fetch --no-check-certificate"
uclient-fetch -O hotplug-extras.sh "https://openwrt.org/_export/code/docs/guide-user/advanced/hotplug_extras?codeblock=0"
. ./hotplug-extras.sh

#############

# Configure IP sets
uci -q delete dhcp.filter
uci set dhcp.filter="ipset"
uci add_list dhcp.filter.name="filter"
uci add_list dhcp.filter.name="filter6"
uci add_list dhcp.filter.domain="roblox.com"
uci add_list dhcp.filter.domain="www.roblox.com"
uci add_list dhcp.filter.domain="api.roblox.com"
uci add_list dhcp.filter.domain="clientsettings.api.roblox.com"
uci add_list dhcp.filter.domain="versioncompatibility.api.roblox.com"
uci add_list dhcp.filter.domain="chat.roblox.com"
uci add_list dhcp.filter.domain="chatsite.roblox.com"
uci add_list dhcp.filter.domain="assetgame.roblox.com"
uci add_list dhcp.filter.domain="setup.roblox.com"
uci add_list dhcp.filter.domain="setup.rbxcdn.com"
uci add_list dhcp.filter.domain="cdn.arkoselabs.com"
uci add_list dhcp.filter.domain="roblox-api.arkoselabs.com"
uci add_list dhcp.filter.domain="js.rbxcdn.com"
uci add_list dhcp.filter.domain="static.rbxcdn.com"
uci add_list dhcp.filter.domain="captcha.roblox.com"
uci commit dhcp
/etc/init.d/dnsmasq restart
 
# Filter LAN client traffic with IP sets
uci -q delete firewall.filter_fwd
uci set firewall.filter_fwd="rule"
uci set firewall.filter_fwd.name="Filter-IPset-DNS-Forward"
uci set firewall.filter_fwd.src="lan"
uci set firewall.filter_fwd.dest="wan"
uci set firewall.filter_fwd.proto="all"
uci set firewall.filter_fwd.family="ipv4"
uci set firewall.filter_fwd.ipset="filter dest"
uci set firewall.filter_fwd.target="REJECT"
uci -q delete firewall.filter6_fwd
uci set firewall.filter6_fwd="rule"
uci set firewall.filter6_fwd.name="Filter-IPset-DNS-Forward"
uci set firewall.filter6_fwd.src="lan"
uci set firewall.filter6_fwd.dest="wan"
uci set firewall.filter6_fwd.proto="all"
uci set firewall.filter6_fwd.family="ipv6"
uci set firewall.filter6_fwd.ipset="filter6 dest"
uci set firewall.filter6_fwd.target="REJECT"
uci commit firewall
/etc/init.d/firewall restart
 
# Resolve race conditions
cat << "EOF" > /etc/firewall.dnsmasq
/etc/init.d/dnsmasq restart
EOF
cat << "EOF" >> /etc/sysupgrade.conf
/etc/firewall.dnsmasq
EOF
uci -q delete firewall.dnsmasq
uci set firewall.dnsmasq="include"
uci set firewall.dnsmasq.path="/etc/firewall.dnsmasq"
uci set firewall.dnsmasq.reload="1"
uci commit firewall
/etc/init.d/firewall restart
 
# Populate IP sets
ipset setup




# Apply time restriction
for FW_RULE in filter_fwd filter6_fwd
do
uci set firewall.${FW_RULE}.start_time="21:00:00"
uci set firewall.${FW_RULE}.stop_time="15:00:00"
uci set firewall.${FW_RULE}.weekdays="Mon Tue Wed Thu Fri"

done
uci commit firewall
/etc/init.d/firewall restart



##### Apply source restriction
####for FW_RULE in filter_fwd filter6_fwd
####do
####uci add_list firewall.${FW_RULE}.src_mac="11:22:33:44:55:66"
####uci add_list firewall.${FW_RULE}.src_mac="aa:bb:cc:dd:ee:ff"
####done
####uci commit firewall
####/etc/init.d/firewall restart





# Reorder firewall rules
cat << "EOF" > /etc/firewall.estab
for IPT in iptables ip6tables
do ${IPT}-save -c -t filter \
| sed -e "/FORWARD.*ESTABLISHED.*ACCEPT/d;
/FORWARD.*reject/i $(${IPT}-save -c -t filter \
| sed -n -e "/FORWARD.*ESTABLISHED.*ACCEPT/p")" \
| ${IPT}-restore -c -T filter
done
EOF
cat << "EOF" >> /etc/sysupgrade.conf
/etc/firewall.estab
EOF
uci -q delete firewall.estab
uci set firewall.estab="include"
uci set firewall.estab.path="/etc/firewall.estab"
uci set firewall.estab.reload="1"
uci commit firewall
/etc/init.d/firewall restart

