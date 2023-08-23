# Install packages
#opkg update
#opkg remove dnsmasq
#opkg install dnsmasq-full ipset resolveip


for IPV in 4 6
do
uci -q delete firewall.filter_fwd_Kids_Day
uci -q delete firewall.filter_fwd_Kids_Night
uci -q delete firewall.filter_fwd_Kids_Extra
uci -q delete firewall.filter_fwd_Kids_Block_All_Day
done
 
####
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

uci -q delete firewall.filter_fwd_Kids_Day
uci set firewall.filter_fwd_Kids_Day="rule"
uci set firewall.filter_fwd_Kids_Day.name="Kids-Day"
uci set firewall.filter_fwd_Kids_Day.src="lan"
uci set firewall.filter_fwd_Kids_Day.dest="wan"
uci set firewall.filter_fwd_Kids_Day.proto="all"
uci set firewall.filter_fwd_Kids_Day.ipset="filter dest"
uci set firewall.filter_fwd_Kids_Day.target="REJECT"




# Filter LAN client traffic with IP sets

uci -q delete firewall.filter_fwd_Kids_Night
uci set firewall.filter_fwd_Kids_Night="rule"
uci set firewall.filter_fwd_Kids_Night.name="Kids-Night"
uci set firewall.filter_fwd_Kids_Night.src="lan"
uci set firewall.filter_fwd_Kids_Night.dest="wan"
uci set firewall.filter_fwd_Kids_Night.proto="all"
uci set firewall.filter_fwd_Kids_Night.ipset="filter dest"
uci set firewall.filter_fwd_Kids_Night.target="REJECT"

# Filter LAN client traffic with IP sets

uci -q delete firewall.filter_fwd_Kids_Mid_Day
uci set firewall.filter_fwd_Kids_Mid_Day="rule"
uci set firewall.filter_fwd_Kids_Mid_Day.name="Kids_Mid_Day"
uci set firewall.filter_fwd_Kids_Mid_Day.src="lan"
uci set firewall.filter_fwd_Kids_Mid_Day.dest="wan"
uci set firewall.filter_fwd_Kids_Mid_Day.proto="all"
uci set firewall.filter_fwd_Kids_Mid_Day.ipset="filter dest"
uci set firewall.filter_fwd_Kids_Mid_Day.target="REJECT"



# Filter LAN client traffic with IP sets

uci -q delete firewall.filter_fwd_Kids_Extra
uci set firewall.filter_fwd_Kids_Extra="rule"
uci set firewall.filter_fwd_Kids_Extra.name="Kids-Extra"
uci set firewall.filter_fwd_Kids_Extra.src="lan"
uci set firewall.filter_fwd_Kids_Extra.dest="wan"
uci set firewall.filter_fwd_Kids_Extra.proto="all"
uci set firewall.filter_fwd_Kids_Extra.ipset="filter dest"
uci set firewall.filter_fwd_Kids_Extra.target="REJECT"



# Filter LAN client traffic with IP sets

uci -q delete firewall.filter_fwd_Kids_Block_All_Day
uci set firewall.filter_fwd_Kids_Block_All_Day="rule"
uci set firewall.filter_fwd_Kids_Block_All_Day.name="Kids_Block_All_Day"
uci set firewall.filter_fwd_Kids_Block_All_Day.src="lan"
uci set firewall.filter_fwd_Kids_Block_All_Day.dest="wan"
uci set firewall.filter_fwd_Kids_Block_All_Day.proto="all"
uci set firewall.filter_fwd_Kids_Block_All_Day.ipset="filter dest"
uci set firewall.filter_fwd_Kids_Block_All_Day.target="REJECT"


 
# Resolve race conditions
cat << "EOF" > /etc/firewall.dnsmasq
/etc/init.d/dnsmasq restart
EOF
#cat << "EOF" >> /etc/sysupgrade.conf
#/etc/firewall.dnsmasq
#EOF
uci -q delete firewall.dnsmasq
uci set firewall.dnsmasq="include"
uci set firewall.dnsmasq.path="/etc/firewall.dnsmasq"
uci set firewall.dnsmasq.reload="1"
uci commit firewall
/etc/init.d/firewall restart
 
# Populate IP sets
############ipset setup


uci set firewall.filter_fwd_Kids_Day.start_time="00:00:01"
uci set firewall.filter_fwd_Kids_Day.stop_time="09:00:00"
uci set firewall.filter_fwd_Kids_Day.weekdays="Mon Tue Wed Thu Fri"

uci set firewall.filter_fwd_Kids_Mid_Day.start_time="11:00:00"
uci set firewall.filter_fwd_Kids_Mid_Day.stop_time="15:30:00"
uci set firewall.filter_fwd_Kids_Mid_Day.weekdays="Mon Tue Wed Thu Fri Sat Sun"

uci set firewall.filter_fwd_Kids_Night.start_time="15:30:00"
uci set firewall.filter_fwd_Kids_Night.stop_time="23:59:59"
uci set firewall.filter_fwd_Kids_Night.weekdays="Mon Tue Wed Thu Sun"

uci set firewall.filter_fwd_Kids_Extra.start_time="07:00:00"
uci set firewall.filter_fwd_Kids_Extra.stop_time="07:00:01"
uci set firewall.filter_fwd_Kids_Extra.weekdays="Sat Sun"


uci commit firewall
/etc/init.d/firewall restart

