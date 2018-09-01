#!/bin/sh

# package manager specific update

if [ -n "$(2>/dev/null which apt)" ]; then
	sudo apt-get update
elif [ -n "$(2>/dev/null which yum)" ]; then
	sudo yum clean -q expire-cache
elif [ -n "$(2>/dev/null which apk)" ]; then
	apk update
elif [ -n "$(2>/dev/null which pacman)" ]; then
	sudo pacman -Sy
fi
