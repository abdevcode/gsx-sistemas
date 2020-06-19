#!/bin/sh

if [ ! -f "interfaces.confbak" ]; then
    cp /etc/networks/interfaces ./interfaces.bak
fi

ifdown enp0s3
ifup enp0s3
