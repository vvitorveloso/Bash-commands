
ssh -T root@192.168.1.1 <<'EOL'


# Install packages
#opkg update
#opkg remove dnsmasq
#opkg install dnsmasq-full ipset resolveip

####################################################
##############   USER SETTINGS   ###################

filter_user="Kids"
filter_time="Day Mid_Day Night All_Day"

Day_start_time="00:00:01"
Day_stop_time="12:00:00"
Day_weekdays="Mon Tue Wed Thu Fri"
Mid_Day_start_time="12:00:01"
Mid_Day_stop_time="15:30:00"
Mid_Day_weekdays="Mon Tue Wed Thu Fri"
Night_start_time="20:00:00"
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


for i in $(uci show firewall | grep 'Filter-Parental-Controls' | cut -d \. -f 1-2) ; do uci -q delete $i ;done
for i in $(uci show firewall | grep 'Block NOW' | cut -d \. -f 1-2) ; do uci -q delete $i ;done



# Configure firewall
uci add firewall rule
uci set firewall.@rule[-1].name="Block NOW"
uci set firewall.@rule[-1].src="lan"
uci add_list firewall.@rule[-1].src_mac="9C:AD:97:FE:49:7F"
uci add_list firewall.@rule[-1].src_mac="78:2B:CD:ED:7A:98"
uci set firewall.@rule[-1].dest="wan"
uci set firewall.@rule[-1].target="REJECT"



# Configure firewall
uci add firewall rule
uci set firewall.@rule[-1].name="Filter-Parental-Controls"
uci set firewall.@rule[-1].src="lan"
uci add_list firewall.@rule[-1].src_mac="9C:AD:97:FE:49:7F"
uci add_list firewall.@rule[-1].src_mac="78:2B:CD:ED:7A:98"
uci set firewall.@rule[-1].dest="wan"
uci set firewall.@rule[-1].start_time="20:30:00"
uci set firewall.@rule[-1].stop_time="07:00:00"
uci set firewall.@rule[-1].weekdays="Mon Tue Wed Thu Fri"
uci set firewall.@rule[-1].target="REJECT"
uci commit firewall
/etc/init.d/firewall restart

EOL