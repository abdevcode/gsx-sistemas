#!/bin/sh

. ./def_interficies.sh

if [ ! -f "./dhclienthostname.bak" ]; then
    cp /etc/dhcp/dhclient-exit-hooks.d/hostname ./dhclienthostname.bak
fi

if [ ! -f "hosts.bak" ]; then
    cp /etc/hostname ./hostname.bak
fi

if [ ! -f "hosts.bak" ]; then
    cp /etc/hosts ./hosts.bak
fi

echo "
#!/bin/sh
# Filename:	 /etc/dhcp/dhclient-exit-hooks.d/hostname
# Purpose:	Used by dhclient-script to set the hostname of the system
# to match the DNS information for the host as provided by DHCP.

# Do not update hostname for virtual machine IP assignments (update your NIC names)
if [ \"\$interface\" != \"enp0s3\" ] && [ \"\$interface\" != \"enp0s8\" ] && [ \"\$interface\" != \"enp0s9\" ]
then
	return
fi

if [ \"\$reason\" != BOUND ] && [ \"\$reason\" != RENEW ] && [ \"\$reason\" != REBIND ] && [ \"\$reason\" != REBOOT ]
then
	return
fi

echo dhclient-exit-hooks.d/hostname: Dynamic IP address = \$new_ip_address
echo dhclient-exit-hooks.d/hostname: Dynamic Hostname = \$hostname
echo \${new_host_name} > /etc/hostname
hostname \${new_host_name}
" > /etc/dhcp/dhclient-exit-hooks.d/hostname

chmod u+x /etc/dhcp/dhclient-exit-hooks.d/hostname
systemctl restart networking

hostname Intern20
echo "
Intern20
" > /etc/hostname

sed -i 's/GSX/Intern20/g' /etc/hosts


ifup $IFINT
