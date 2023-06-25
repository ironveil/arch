#!/bin/bash

# Import env
source "./ENV.sh"

# Disable DHCPCD override
echo "--> Disabling DHCPCD & NetworkManager DNS overrides..."

echo "nohook resolv.conf" >> /etc/dhcpcd.conf

# Disable NetworkManager override
CWD=/etc/NetworkManager/conf.d/dns.conf

touch $CWD
echo "[main]" >> $CWD
echo "dns=none" >> $CWD

# Enable dnscrypt-proxy
echo "--> Enabling dnscrypt..."

CWD=/etc/dnscrypt-proxy/dnscrypt-proxy.toml

sed -i "33s/.*/server_names = ['NextDNS-$NEXTDNS_ID']/" $CWD
sed -i '43s/127.0.0.1/0.0.0.0/' $CWD
echo "[static.'NextDNS-$NEXTDNS_ID']" >> $CWD
echo "stamp = 'sdns://$NEXTDNS_SDNS'" >> $CWD

CWD=/etc/resolv.conf

echo "nameserver ::1" > $CWD
echo "nameserver 127.0.0.1" >> $CWD
echo "options edns0" >> $CWD

CWD=/etc/resolvconf.conf

echo "nameserver ::1" >> $CWD
echo "nameserver 127.0.0.1" >> $CWD
echo "options edns0" >> $CWD
