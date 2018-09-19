#!/bin/sh

if [ -z "$1" ]; then
	echo "Email address needed but not passed"
	exit 1
fi

# NOTE: assumes default rsa key names
id_file="$HOME/.ssh/id_rsa"

# create folder as needed
if [ ! -d "$HOME/.ssh" ]; then
    echo "Creating new .ssh folder"

    # not needed since, ssh-keygen auto creates it
    # mkdir -p "$HOME/.ssh"

    [ -z "$1" ] && ssh-keygen -t rsa -b 4096 -C "$1" \
        || ssh-keygen -t rsa -b 4096
else
    echo "Found existing .ssh folder"
fi

# create key as needed
if [ ! -f "${id_file}" ]; then
    echo "Creating new rsa key"

    [ -z "$1" ] && ssh-keygen -t rsa -b 4096 -C "$1" \
        || ssh-keygen -t rsa -b 4096
else
    echo "Found existing rsa key"
    cat "${id_file}.pub"
fi

# get fingerprint
fp="$(ssh-keygen -lf $id_file | awk '{ print $2}')"

# check against added list
match="$(ssh-add -l | grep -o "${fp}")"

# if not found
if [ -z "$match" ]; then
    echo "Adding key to ssh-agent"
	# run agent
	eval "$(ssh-agent -s)"
	
	# add key
	ssh-add $id_file
else
    echo "Key: $fp already exists in ssh key list"
fi

# ssh -T git@github.com
