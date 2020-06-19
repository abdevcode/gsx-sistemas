#!/bin/sh

if [ ! -f "interfaces.confbak" ]; then
    cp /etc/networks/interfaces.bak ./interfaces.bak
fi

ifdown enp0s3
ifup enp0s3
