#!/bin/bash
# PORTAL of Pi FTMFW BIATTCH!
printf " ___  ___  ___ _____ _   _           \n"
printf "| _ \/ _ \| _ \_   _/_\ | | of ._ o  \n"
printf "|  _/ (_) |   / | |/ _ \| |__  |_)|  \n"
printf "|_|  \___/|_|_\ |_/_/ \_\____| |     \n"
#
# Licensed GPLv3
#
# (c) 2013 the grugq <the.grugq@gmail.com>

# See the README.md for indepth details.
#
# Based on the RaspberryPi Arch distribution.
# View official installation instructions:
#      https://archlinuxarm.org/platforms/armv6/raspberry-pi#installation
# Or run the automated setup script:
#      bash flash-sdcard.sh /dev/yoursdcard
#
# PORTAL configuration overview
#  
# ~({(Internet)})~---[USB]<[Pi]>[${INTERFACE}]----((LAN))
#   ${INTERFACE}: 172.16.0.1
#        * anything from here can only reach 9050 (Tor proxy) or,
#        * the transparent Tor proxy 
#    USB: ???.
#        * Internet access. You're on your own
#        * No services exposed here
# STEP 1 !!! 
#   configure Internet access, we'll neet to install some basic tools.
# logrunner & tlsdate both need to be  built :(
# These are your global variables; happy hacking!
INTERFACE="eth0"
ETHADDRESS="192.168.5.133"
ETHBROADCAST="192.168.5.255"
ETHGATEWAY="192.168.5.1"

NETMASK="255.255.255.0"

WLANADDRESS="192.168.11.1"
WLANBROADCAST="192.168.11.255"
WLANGATEWAY="192.168.11.1"

DNS1="208.67.222.222"
DNS2="209.244.0.3"
DNS3="4.2.2.2"

DOMAIN="local"

APT="sudo apt install"
# DHCP-RANGE=is manually input in the dnsmasq section. Around line 220
# Update, Upgrade, dist upgrade, and clean up
sudo apt update 
sudo apt-get autoremove
sudo apt-get autoclean
sudo apt upgrade -y
sudo apt-get autoremove
sudo apt-get autoclean
sudo apt-get dist-upgrade -y
sudo apt-get autoremove
sudo apt-get autoclean

# comfortable work environment and basics
$APT htop inxi util-linux procps -y

# build tools
$APT build-essential autoconf automake make -y

# Network utilities
#${APT} iptables netscript-ipfilter dnsmasq -y
$APT hostapd iptables iproute2 iw iwconfig -y

# Tor and Tor stuff
$APT tor-arm tor obfsproxy obfs4proxy -y

# set the time to UTC, because that's how we roll
rm /etc/localtime
ln -s /usr/share/zoneinfo/UTC /etc/localtime

# set hostname to PORTAL \m/
echo "torpal" > /etc/hostname


#################################################
# iptables prep
printf "Viewing current iptables rules... \n"
#################################################
# Take a look at current iptables configuration
sudo iptables -t nat -S
sudo iptables -S

# And then flush em
sudo iptables -F
sudo iptables -t nat -F
#################################################
printf "Flushed current iptables ruleset... \n"
#################################################



#################################################
# iptables rule set
printf "Setting iptables rules... \n"
#################################################
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
sudo iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT
sudo iptables -t nat -A PREROUTING -i wlan0 -p tcp --dport 22 -j REDIRECT --to-ports 22
sudo iptables -t nat -A PREROUTING -i wlan0 -p udp --dport 53 -j REDIRECT --to-ports 53
sudo iptables -t nat -A PREROUTING -i wlan0 -p tcp --syn -j REDIRECT --to-ports 9040
sleep 1
printf "\n\nView rules we have just set \n"
sudo iptables -t nat -S
sudo iptables -S
printf "\n\nSaving... \n"
sudo sh -c "iptables-save > /etc/iptables.ipv4.nat"
#################################################
printf "iptables rules have been set and saved\n"
#################################################





#################################################
# hostap configuration
printf "Configuring /etc/default/hostapd \n"
#################################################
cat > /etc/default/hostapd << __HOSTAPD__
# Defaults for hostapd initscript
#
# See /usr/share/doc/hostapd/README.Debian for information about alternative
# methods of managing hostapd.
DAEMON_CONF="/etc/hostapd/hostapd.conf"
# Additional daemon options to be appended to hostapd command:-
#       -d   show more debug messages (-dd for even more)
#       -K   include key data in debug messages
#       -t   include timestamps in some debug messages
# Note that -B (daemon mode) and -P (pidfile) options are automatically
# configured by the init.d script and must not be added to DAEMON_OPTS.
#DAEMON_OPTS=""

__HOSTAPD__
#################################################
printf "/etc/default/hostapd configured\n"
#################################################



#################################################
# HOSTAPD configuration
printf "Configuring hostapd.conf... \n"
#################################################
cat > /etc/hostapd/hostapd.conf << __HOSTAPDCONF__
interface=wlan0
driver=nl80211
ssid=bbbap
hw_mode=g
channel=6
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa_key_mgmt=WPA-PSK
wpa_passphrase=temppwd
wpa=2
wpa_pairwise=TKIP
rsn_pairwise=CCMP

__HOSTAPDCONF__
#################################################
printf "hostapd.conf configured\n"
#################################################



#################################################
# sysctl.conf configuration
printf "Configuring sysctl.conf... \n"
#################################################
cat > /etc/sysctl.conf << __SYSCTL__
# /etc/sysctl.conf - Configuration file for setting system variables
# See /etc/sysctl.d/ for additional system variables.
# See sysctl.conf (5) for information.
#kernel.domainname = example.com
# Uncomment the following to stop low-level messages on console
#kernel.printk = 3 4 1 3
#net.ipv4.conf.default.rp_filter=1
#net.ipv4.conf.all.rp_filter=1
#net.ipv4.tcp_syncookies=1
net.ipv4.ip_forward=1
#net.ipv6.conf.all.forwarding=1
#net.ipv4.conf.all.accept_redirects = 0
#net.ipv6.conf.all.accept_redirects = 0
# Accept ICMP redirects only for gateways listed in our default
# gateway list (enabled by default)
# net.ipv4.conf.all.secure_redirects = 1
#net.ipv4.conf.all.send_redirects = 0
#net.ipv4.conf.all.accept_source_route = 0
#net.ipv6.conf.all.accept_source_route = 0
#net.ipv4.conf.all.log_martians = 1

__SYSCTL__
#################################################
printf "sysctl.conf configured\n"
#################################################



#################################################
# UDHCP configuration
printf "Configuring UDHCP... \n"
#################################################
cat > /etc/udhcpd.conf << __UDHCPD__
# Managed by /opt/scripts/boot/autoconfigure_usb0.sh - Do not modify unless you know what you are doing!
# Modified by letanque
# USB0 for BBB
interface  usb0
start      192.168.7.1
end        192.168.7.1
max_leases 1
option subnet 255.255.255.252
option domain local
option lease 30


interface       wlan0
start           192.168.11.20
end             192.168.11.254
lease_file      /var/lib/misc/udhcpd.leases
pidfile         /var/run/udhcpd.pid
option    dns      $DNS1 $DNS2
option    router   $WLANGATEWAY
option    subnet   $NETMASK
option    domain   $DOMAIN
option lease 864000

__UDHCPD__
#################################################
printf "UDHCP configured\n"
#################################################



#################################################
# TORRC
printf "Configuring TORRC...\n"
#################################################
cat > /etc/tor/torrc << __TORRC__
## TORRC
## BLUEPRINT
## Configuration file for a typical Tor user
#SOCKSPort 192.168.8.1:9050
SOCKSPort 9050
Log notice stderr
DisableDebuggerAttachment 1
RunAsDaemon 1
DataDirectory /var/lib/tor
## The port on which Tor will listen for local connections from Tor
## controller applications, as documented in control-spec.txt.
ControlPort 9051
#HashedControlPassword nn:
CookieAuthentication 1
## Required: what port to advertise for incoming Tor connections.
ORPort 9001
HiddenServiceStatistics 0
PublishServerDescriptor 1
BridgeRecordUsageByCountry 0
ExtraInfoStatistics 0

OutboundBindAddress 192.168.11.64

Nickname blueprint
#ContactInfo Random Person <nobody AT example dot com>
#ContactInfo 0xFFFFFFFF Random Person <nobody AT example dot com>
#MyFamily $keyid,$keyid,...
## What port to advertise for directory connections
DirPort 9030 
## No exits allowed
ExitPolicy reject *:* 
#BridgeRelay 1
#ClientTransportPlugin obfs4 exec /usr/bin/obfs4proxy
#ServerTransportPlugin obfs4 exec /usr/bin/obfs4proxy
#UseBridges 1
#UpdateBridgesFromAuthority 0
#Bridge
__TORRC__
#################################################
printf "Torrc configured\n"
#################################################



#################################################
# Ethernet
printf "Configuring dhclient.conf...\n"
#################################################
cat > /etc/dhcp/dhclient.conf << __ETHCONF__
# Configuration file for /sbin/dhclient, which is included in Debian's
#       dhcp3-client package.
# Normally, if the DHCP server provides reasonable information and does
#       not leave anything out (like the domain name, for example), then
#       few changes must be made to this file, if any.
option rfc3442-classless-static-routes code 121 = array of unsigned integer 8;
send host-name = gethostname();
supersede domain-name-servers ${DNS1}, ${DNS2}, ${DNS3};
request subnet-mask, broadcast-address, time-offset, routers,
        domain-name, domain-name-servers, domain-search, host-name,
        dhcp6.name-servers, dhcp6.domain-search,
        netbios-name-servers, netbios-scope, interface-mtu,
        rfc3442-classless-static-routes, ntp-servers;
alias {
  interface "$ETHINTERFACE";
  fixed-address "$ETHADDRESS";
  option subnet-mask "$NETMASK";
  option broadcast-address "$ETHBROADCAST";
}
__ETHCONF__
#################################################
printf "dhclient.conf configured\n"
#################################################




#in /etc/network/interfaces add:
#
#iface wlan0 inet static
#address $WLANADDRESS
#netmask $NETMASK



sudo update-rc.d hostapd enable
sudo systemctl enable networking
systemctl enable tor.service
