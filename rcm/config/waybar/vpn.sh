#!/bin/bash
#
# Get status of VPN connection for Waybar.
#

NAME=$(nmcli -g name,type c s --active | grep ':vpn' | cut -f1 -d":")

if [ -z "$NAME" ]; then
    exit 1
fi

echo '{ "tooltip":' "\"$NAME\"" '}'
