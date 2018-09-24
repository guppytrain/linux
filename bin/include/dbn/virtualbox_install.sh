#!/bin/sh

# get gpg key
# curl -fsSL https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo apt-key add -
# curl -fsSL https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -

# setup the stable repo
# sudo add-apt-repository "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
sudo add-apt-repository "deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian bionic contrib"

# update apt-get
sudo apt-get update

# install docker-ce
# sudo apt-get install -y virtualbox-5.2
sudo apt-get install -y virtualbox

# download ext pack
# wget -P $DOWNLOAD_DIR https://download.virtualbox.org/virtualbox/5.2.18/Oracle_VM_VirtualBox_Extension_Pack-5.2.18.vbox-extpack

sudo apt-get install -y virtualbox-ext-pack

