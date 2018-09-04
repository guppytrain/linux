#!/bin/sh

# package manager specific update

if [ -n "$(command -v apt)" ]; then
	sudo apt-get update
elif [ -n "$(command -v yum)" ]; then
	sudo yum clean -q expire-cache
elif [ -n "$(command -v apk)" ]; then
	apk update
elif [ -n "$(command -v pacman)" ]; then
	sudo pacman -Sy
fi
