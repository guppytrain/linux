#!/bin/sh

# prep prereqs
sudo apt-get update

sudo apt-get    install -y \
                apt-transport-https \
                ca-certificates \
                curl \
                software-properties-common

mint=="$(lsb_release -a | grep -io "linuxmint")"

if [ -n "${mint}" ]; then
    # First import the GPG key
    sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 \
        --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
    
    # Next, point the package manager to the official Docker repository
    sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main'
    
    # Update the package database
    sudo apt update

    inst1="$(sudo apt version linux-image-generic)"
    inst2="$(sudo apt version linux-image-extra-virtual)"

    if [ -n "$inst1" ] && [ -n "$inst2" ]; then
        # Install Docker
        sudo apt install docker-engine
    else
        # Installing both packages will eliminate an unmet dependencies error when you try to install the
        # linux-image-extra-virtual by itself
        sudo apt install linux-image-generic linux-image-extra-virtual

        printf "%s\n%s\n\n" "Reboot the system so it would be running on the newly installed kernel image."  "After rebooting, run 'sudo apt install docker-engine' or re-run this script"
        bash -c "read -s -e -p \"[OK]\""
        echo

        # sudo reboot
    fi
else
    # [_] get gpg key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    # [_] setup the stable repo
    sudo add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
            $(lsb_release -cs) \
                stable"

    # [_] update apt-get
    sudo apt-get update

    # [_] install docker-ce
    sudo apt-get install -y docker-ce
fi
