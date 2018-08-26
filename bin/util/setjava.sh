#!/bin/sh

# not in the business of package mgmt, so just hardcode the paths here
### START JDK HOMES

JDK8_DIR_NAME="jdk1.8.0_171"
JDK10_DIR_NAME="jdk-10.0.1"

### END JDK HOMES

echo "$0 $1"

echo "JDK_DIR: $JDK_DIR"

if [ -z ${JDK_DIR} ] || [ ! -d ${JDK_DIR} ]; then
	echo "JDK_DIR is undefined"
	exit 1
fi

case "$1" in
        10)
	    cd $JDK_DIR
	    pwd

	    if [ -L "$JDK_DIR/current" ]; then
            echo "Removing current link to $(readlink -f $JDK_DIR/current)"
		sudo rm current 
		sync
    	    fi
	   
	    echo "Setting Java to ${JDK10_DIR_NAME}"
	    sudo ln -s ${JDK10_DIR_NAME} current
            ;;
         
        8)
	    cd $JDK_DIR
	    pwd

	    if [ -L "$JDK_DIR/current" ]; then
            echo "Removing current link to $(readlink -f $JDK_DIR/current)"
	    	sudo rm current
		sync
	    fi	

	    echo "Setting Java to ${JDK8_DIR_NAME}"
	    sudo ln -s ${JDK8_DIR_NAME} current
            ;;
         
        *)
            echo "Usage: $0 {8|10}"
            exit 1
 
esac


echo "Current symlink: $(readlink -f $JDK_DIR/current)"

