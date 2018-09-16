#!/bin/sh

# setup the stable repo
sudo add-apt-repository --remove "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"

# install docker-ce
# sudo apt-get purge -y virtualbox-5.2
sudo apt-get purge -y virtualbox

