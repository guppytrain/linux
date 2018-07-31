#!/bin/sh

# source the env vars
. ./include/env.sh

# make sure dev dir exists
( [ -d "$DEV_DIR" ] && echo "Found dev at $(pwd $DEV_DIR)" ) || ( mkdir -p "$DEV_DIR" );

