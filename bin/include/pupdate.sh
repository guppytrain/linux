#!/bin/sh

# package manager specific update

if [ -n "$(which apt)" ]; then
	sudo apt-get update
elif [ -n "$(which yum)" ]; then
	sudo pacman -Sy
elif [ -n "$(which apk)" ]; then
	apk update
fi
