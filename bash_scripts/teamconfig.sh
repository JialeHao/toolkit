#!/usr/bin/env bash
# Author: JialeHao
# E-mail: haojiale6@163.com
# Version: 1.2

if [ $1 = '--help' ]; then
    cat <<EOF
Usage:
    $0 ip conn-name nic1 nic2 nic3 ... nicn

Tips:
    1.The maximum value of n is 8;
    2.The teaming mode is roundrobin.
EOF
    exit 0
fi

team_ip=$1
shift

conn_name=$1
shift

team_gateway="${team_ip%.*}.254"

dns1="119.29.29.29"
dns2="114.114.114.114"

nmcli connection add type team con-name ${conn_name} ifname ${conn_name} config '{"runner": {"name": "roundrobin"}}'

for nic in $@; do
    nmcli connection add type team-slave con-name ${conn_name}-${nic} ifname ${nic} master ${conn_name}
    nmcli connection delete ${nic} &> /dev/null
done

nmcli connection modify ${conn_name} ipv4.method manual ipv4.addresses ${team_ip}/24 ipv4.gateway ${team_gateway} ipv4.dns ${dns1},${dns2} autoconnect yes
nmcli connection up ${conn_name}
