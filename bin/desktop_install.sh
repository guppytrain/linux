#!/bin/sh

# source the env vars
. ./include/env.sh

echo "Starting Desktop Install..." 

# start install
cd $CWH/bin/installers \
&& ./vim_plugins_install.sh \
&& ./dropbox_install.sh \
&& ./docker_install.sh \
&& ./idea_install.sh \
&& ./idea_activate.sh \
&& echo "Finished Desktop Install"
