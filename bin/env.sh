#!/bin/sh

export CWH="$(cd ..; pwd)"

. "$CWH/bin/addpath.sh"

# PATH="$CWH/bin:/$CWH/bin/include:$PATH"
addpath "$CWH/bin" 
addpath "$CWH/bin/include" 

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

export DEV_DIR="$HOME/dev"

export PATH

