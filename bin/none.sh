#!/bin/sh

. ./include/env.sh

# base clean
./clean.sh

# base uninstall
./base_uninstall.sh

# desktop specific
./desktop_uninstall.sh
