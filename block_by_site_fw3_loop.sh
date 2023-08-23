# Install packages
#opkg update
#opkg remove dnsmasq
#opkg install dnsmasq-full ipset resolveip

####################################################
##############   USER SETTINGS   ###################

filter_user="Kids"
filter_time="Day Mid_Day Night All_Day"

Day_start_time="00:00:01"
Day_stop_time="09:00:00"
Day_weekdays="Mon Tue Wed Thu Fri"
Mid_Day_start_time="15:30:00"
Mid_Day_stop_time="23:59:59"
Mid_Day_weekdays="Mon Tue Wed Thu Fri Sat Sun"
Night_start_time="15:30:00"
Night_stop_time="23:59:59"
Night_weekdays="Mon Tue Wed Thu Sun"

####################################################
################ Block List #########################
####

BlockList="roblox.com \
www.roblox.com \
api.roblox.com \
clientsettings.api.roblox.com \
versioncompatibility.api.roblox.com \
chat.roblox.com \
chatsite.roblox.com \
assetgame.roblox.com \
setup.roblox.com \
setup.rbxcdn.com \
cdn.arkoselabs.com \
roblox-api.arkoselabs.com \
js.rbxcdn.com \
static.rbxcdn.com \
captcha.roblox.com"

########################################################
########################################################
# Configure IP sets

uci -q delete dhcp.filter
uci set dhcp.filter="ipset"
uci add_list dhcp.filter.name="filter"
uci add_list dhcp.filter.name="filter6"

for i in $BlockList;do
uci add_list dhcp.filter.domain="$i"
done

uci commit dhcp
/etc/init.d/dnsmasq restart
 
separator="_"
filter="filter_fwd_block"

for i in $filter_time; do
fwd_name="$filter$separator$filter_user$separator$i"

#During creation of script i crate a loot dups kkkkkkk
uci -q delete firewall.$fwd_name
uci -q delete firewall.$fwd_name
uci -q delete firewall.$fwd_name
uci -q delete firewall.$fwd_name
uci -q delete firewall.$fwd_name
uci -q delete firewall.$fwd_name

uci set firewall.$fwd_name="rule"
uci set firewall.$fwd_name.name="$filter_user$separator$i"
uci set firewall.$fwd_name.src="lan"
uci set firewall.$fwd_name.dest="wan"
uci set firewall.$fwd_name.proto="all"
uci set firewall.$fwd_name.ipset="filter dest"
uci set firewall.$fwd_name.target="REJECT"

done
 
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
ipset setup

fwd_time_filters="start_time stop_time weekdays"

for i in $filter_time; do

	fwd_name="$filter$separator$filter_user$separator$i"
	for f in $fwd_time_filters;do

		var_now=$(echo $i"_"$f)
		eval value_now=\$$var_now


		if [ "$value_now" != "" ];then
		eval	uci set firewall.$fwd_name.$f=$(echo '"'$value_now'"')
			
		fi
	done
done

uci commit firewall
/etc/init.d/firewall restart
