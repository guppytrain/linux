#!/bin/sh

. ./include/env.sh

# base setup
./setup.sh -n

# base install
./base_install.sh

# desktop specific
./desktop_install.sh
