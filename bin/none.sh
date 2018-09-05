#!/bin/sh

. ./include/env.sh

# desktop specific
./desktop_uninstall.sh

# base uninstall
./base_uninstall.sh

# base clean
./clean.sh

