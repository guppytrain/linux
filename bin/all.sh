#!/bin/sh

. ./include/env.sh

# base setup
./setup

# base install
./base_install.sh

# desktop specific
./desktop_install.sh
