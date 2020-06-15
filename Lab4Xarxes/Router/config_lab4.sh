#!/bin/sh

. ./def_interficies.sh

iptables -F
iptables -X

#Com que treballem amb snat reestablim la taula de nat
iptables -t nat -F
iptables -t nat -X

iptables --flush
iptables -t nat --flush

#Default
iptables -P OUTPUT DROP 
iptables -P INPUT DROP
iptables -P FORWARD DROP

#Loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

#SNAT:
ipe=$(ifconfig $IFISP | grep "inet " | awk '{print $2}')
iptables -t nat -A POSTROUTING -o enp0s3 -j SNAT --to-source $ipe

#Regles default:
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

#Queries DNS
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT

#Conexions sortitns http https
iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT

#Conexions entrants i sortitns ssh
iptables -A OUTPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT


# ------>
# Make ICMP traffic of that type not trackable by state tracking.
iptables -t raw -I PREROUTING -m icmp -p icmp --icmp-type any -j NOTRACK
# <------


#Sortir icmp echo-rquest
iptables -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT

#Limitar entrades echo-request a 5 per minut
iptables -A INPUT -p icmp --icmp-type echo-request --match limit --limit 5/m --limit-burst 10 -j ACCEPT

#Forwards Bastio
iptables -A FORWARD -p udp -i $IFINSIDE -o $IFISP --dport 53 -j ACCEPT
iptables -A FORWARD -p tcp -i $IFINSIDE -o $IFISP --dport 53 -j ACCEPT
iptables -A FORWARD -p tcp -i $IFINSIDE -o $IFISP --dport 80 -j ACCEPT
iptables -A FORWARD -p tcp -i $IFINSIDE -o $IFISP --dport 443 -j ACCEPT
iptables -A FORWARD -p tcp -i $IFINSIDE -o $IFISP --dport 22 -j ACCEPT
iptables -A FORWARD -p tcp -i $IFISP -o $IFINSIDE --dport 22 -j ACCEPT
