#!/bin/sh

# prep prereqs
sudo apt-get update

sudo apt-get    install -y \
                apt-transport-https \
                ca-certificates \
                curl \
                software-properties-common

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

