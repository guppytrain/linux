#!/bin/sh

if [ -z "$(ls -A $SHARE_DIR/docker)" ]; then
	rmdir "$SHARE_DIR/docker"
fi

