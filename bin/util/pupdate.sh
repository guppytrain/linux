#!/bin/sh

# package manager specific update

if [ -n "$(which apt)" ]; then
	sudo apt-get update
elif [ -n "$(which apk)" ]; then
	sudo apk update
elif [ -n "$(which pacman)" ]; then
	sudo pacman -Sy
fi
