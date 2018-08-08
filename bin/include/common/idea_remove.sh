#!/bin/sh

echo "Starting idea remove..."

IDEA_ROOT="/opt"
# IDEA_ROOT="$HOME/tmp"

export IDEA_HOME="$(find $IDEA_ROOT -name ".IDEA_HOME" -printf "%h")"

if [ -d "$IDEA_HOME" ]; then
        echo "Deleting IDEA_HOME: $IDEA_HOME"	
	sudo rm -rf "$IDEA_HOME"
else
	echo "Could not find IDEA_HOME"
fi

if [ -d "$HOME/.IntelliJIdea2018.1" ]; then 
        echo "Deleting idea user dir: $HOME/.IntelliJIdea2018.1"	
	sudo rm -rf "$HOME/.IntelliJIdea2018.1"
else
	echo "Could not find idea user dir: $HOME/.IntelliJIdea2018.1" 
fi

rm $SHARE_DIR/bin/idea.sh
