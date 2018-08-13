#!/bin/sh

if [ ! -d "$SHARE_DIR/docker" ]; then
	echo "Creating new docker share directory"

	mkdir "$SHARE_DIR/docker"
fi

