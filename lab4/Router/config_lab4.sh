#!/bin/sh

. ./def_interficies.sh

iptables --flush
iptables -t nat --flush

#Default
iptables -P OUTPUT ACCEPT 
iptables -P INPUT ACCEPT
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

#Conexions sortitns http https
iptables -A OUTPUT -p tcp --dport 80 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 443 -j ACCEPT

#Conexions entrants i sortitns ssh
iptables -A OUTPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

#Sortir icmp echo-rquest
iptables -A OUTPUT -p icmp --icmp-type echo-request -j ACCEPT

#Limitar entrades echo-request a 5 per minut
iptables -A INPUT -p icmp --icmp-type echo-request --match limit --limit 5/m --limit-burst 10 -j DROP

#Forwards Bastio
iptables -A FORWARD -p udp -i $IFINSIDE -o $IFISP --dport 53 -j ACCEPT
iptables -A FORWARD -p tcp -i $IFINSIDE -o $IFISP --dport 80 -j ACCEPT
iptables -A FORWARD -p tcp -i $IFINSIDE -o $IFISP --dport 443 -j ACCEPT
iptables -A FORWARD -p tcp -i $IFINSIDE -o $IFISP --dport 22 -j ACCEPT
iptables -A FORWARD -p tcp -i $IFISP -o $IFINSIDE --dport 22 -j ACCEPT
