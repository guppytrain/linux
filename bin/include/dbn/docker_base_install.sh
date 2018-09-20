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
    keyid="58118E89F3A912897C070ADBF76221572C52609D"
    pkey="$(apt-key export ${keyid} 2>/dev/null)"

    # First import the GPG key
    [ -z "${pkey}" ] && sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 \
        --recv-keys ${keyid}
    
    repo="deb https://apt.dockerproject.org/repo ubuntu-xenial main"
    repoed="$(cat /etc/apt/sources.list /etc/apt/sources.list.d/*.list | grep -o "${repo}")"
    
    # Next, point the package manager to the official Docker repository
    [ -z "${repoed}" ] && sudo apt-add-repository "${repo}"

    inst1="$(sudo apt version linux-image-generic)"
    inst2="$(sudo apt version linux-image-extra-virtual)"

    # Update the package database
    sudo apt update

    if [ -n "$inst1" ] && [ -n "$inst2" ]; then
        # Install Docker
        echo "Installing docker-engine"
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
