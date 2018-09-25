#!/bin/sh

mint=="$(lsb_release -a | grep -io "linuxmint")"

if [ -n "${mint}" ]; then
    sudo apt-get purge -y docker-engine
else
    sudo apt-get purge -y docker-ce
fi
