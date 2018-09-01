#!/bin/sh

# install docker
pinst.sh docker

# ideally this is run in the main install, but this is cos specific because the dbn version autostarts the docker daemon after package install, so keep here
sudo systemctl start docker

