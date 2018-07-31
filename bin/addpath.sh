#!/bin/sh

# add to path if not already exist

FOUND="$(echo $PATH | grep $1)"

if [ -z "$FOUND" ]; then
	echo "Adding path \"$1\""

	if [ -n "$2" ]; then
		if [ "$2" = "tail" ]; then
			PATH="$PATH:$1" 
		else
			PATH="$1:$PATH"
		fi
	else
		PATH="$1:$PATH"
	fi
else
	echo "Not adding path \"$1\""
fi
