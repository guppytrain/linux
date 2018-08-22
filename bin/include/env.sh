#!/bin/sh

# ensure $HOME
if [ -z "$HOME" ]; then
	export HOME="$(cd ~; pwd)"
fi

export DEV_DIR="$HOME/dev"
export SHARE_DIR="$HOME/share"

if [ ! -d "$DEV_DIR" ] || [ ! -d "$SHARE_DIR" ]; then
	echo "~/dev and/or ~/share do not exist.  Exiting..."
	sleep 10
	exit 1
fi

# define current working script home
# export CWH="$(cd ..; pwd)"
# export CWH="$(find $DEV_DIR -name ".CWH" -printf "%h")" # alpine chokes on -printf option
# export CWH="$(find $DEV_DIR -name ".CWH" -print | sed 's@/.CWH@@')"
export CWH="$(find $DEV_DIR -name ".CWH" -print | sed -n '1s@/.CWH@@p')"

if [ ! -d "$CWH" ]; then
	echo "Could not determine CWH.  Exiting..."
	sleep 10
	exit 1
fi

. "$CWH/bin/util/include/addpath.sh"

# PATH="$CWH/bin:/$CWH/bin/include:$PATH"
addpath "$CWH/bin" 
addpath "$CWH/bin/util" 
addpath "$CWH/bin/util/include" 
addpath "$CWH/bin/include" 
addpath "$CWH/bin/include/common"

# package manager specific env detection

if [ -n "$(which apt)" ]; then
	echo "Detected apt, assume debian"
	DISTRO="deb"
elif [ -n "$(which pacman)" ]; then
	echo "Detected pacman, assume arch"
	DISTRO="arch"
elif [ -n "$(which apk)" ]; then
	echo "Detected apk, assume "alpine
	DISTRO="alp"
fi

DISTRO_DIR="$CWH/bin/include/$DISTRO"

if [ -d "$DISTRO_DIR" ]; then
	# PATH="$DISTRO_DIR:$PATH"
	addpath "$DISTRO_DIR"
fi

export PATH

export CLEAN_DIR="$CWH/bin/.clean"
export DOWNLOAD_DIR="$CWH/bin/.download"
