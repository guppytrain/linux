#!/bin/sh

# ensure $HOME
if [ -z "$HOME" ]; then
	export HOME="$(cd ~; pwd)"
fi

# main folders
export DEV_DIR="$HOME/dev"
export SHARE_DIR="$HOME/share"

if [ ! -d "$DEV_DIR" ] || [ ! -d "$SHARE_DIR" ]; then
	echo "~/dev and/or ~/share do not exist.  Exiting..."
	sleep 5
	exit 1
fi

# define current working script home
export CWH="$(find $DEV_DIR -name ".CWH" -print | sed -n '1s@/.CWH@@p')"

if [ ! -d "$CWH" ]; then
	echo "Could not determine CWH.  Exiting..."
	sleep 5
	exit 1
fi

# include common config
. "${CWH}/bin/include/CONFIG"

# package manager specific env detection of distro
if [ -n "$(which apt)" ]; then
	echo "Detected apt, assume debian"
	DISTRO="dbn"
elif [ -n "$(yum)" ]; then
	echo "Detected yum, assume fedora/centos"
	DISTRO="cos"
elif [ -n "$(which apk)" ]; then
	echo "Detected apk, assume "alpine
	DISTRO="alp"
fi

# desktop or not
IS_DESKTOP=false
if [ -n "${DESKTOP_SESSION}" ]; then
    IS_DESKTOP=true
fi

# include distro config
. "${CWH}/bin/include/CONFIG.${DISTRO}"

# source utilities
. "$CWH/bin/util/include/addpath.sh"

# build PATH
# PATH="$CWH/bin:/$CWH/bin/include:$PATH"
addpath "$CWH/bin" 
addpath "$CWH/bin/util" 
addpath "$CWH/bin/util/include" 
addpath "$CWH/bin/include" 
addpath "$CWH/bin/include/common"

# add desktop scripts to path
if [ ${IS_DESKTOP} = true ]; then
    addpath "$CWH/bin/include/desktop"
fi

DISTRO_INCLUDE="$CWH/bin/include/$DISTRO"

if [ -d "$DISTRO_INCLUDE" ]; then
	# PATH="$DISTRO_INCLUDE:$PATH"
	addpath "$DISTRO_INCLUDE"
fi

# more exports
export PATH
export CLEAN_DIR="$CWH/bin/.clean"
export DOWNLOAD_DIR="$CWH/bin/.download"
