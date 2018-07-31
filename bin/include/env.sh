#!/bin/sh

export CWH="$(cd ..; pwd)"

. "$CWH/bin/util/addpath.sh"

# PATH="$CWH/bin:/$CWH/bin/include:$PATH"
addpath "$CWH/bin" 
addpath "$CWH/bin/util" 
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
	PATH="$DISTRO_DIR:$PATH"
fi

export PATH

export CLEAN_DIR="$CWH/bin/.clean"
export DOWNLOAD_DIR="$CWH/bin/.download"

export DEV_DIR="$HOME/dev"
export SHARE_DIR="$HOME/share"

