#!/bin/sh

# prep prereqs
sudo yum install -y yum-utils \
                    device-mapper-persistent-data \
                    lvm2

# setup the stable repo
sudo yum-config-manager \
        --add-repo \
            https://download.docker.com/linux/centos/docker-ce.repo

# install docker-ce
sudo yum install -y docker-ce

# ideally this is run in the main install, but this is cos specific because the dbn version autostarts the docker daemon after package install, so keep here
sudo systemctl start docker
