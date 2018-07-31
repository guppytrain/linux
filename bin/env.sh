#!/bin/sh

export CWH="$(cd ..; pwd)"

PATH="$CWH/bin:/$CWH/bin/include:$PATH"
# . $CWH/bin/addpath.sh "$CWH/bin" 
# . $CWH/bin/addpath.sh "$CWH/bin/include" 

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

export DISTRO_DIR="$CWH/bin/include/$DISTRO"

if [ -d "$DISTRO_DIR" ]; then
	PATH="$DISTRO_DIR:$PATH"
fi

export DEV_DIR="$HOME/dev"


