#!/bin/sh


echo "$0 $1"

echo "JDKDIR: $JDKDIR"

if [ -z ${JDKDIR} ] || [ ! -d ${JDKDIR} ]; then
	echo "JDKDIR is undefined"
	exit 1
fi

case "$1" in
        10)
	    cd $JDKDIR
	    pwd

	    if [ -L "$JDKDIR/current" ]; then
	     	echo "Removing current link to `readlink -f $JDKDIR/current`"
		sudo rm current 
		sync
    	    fi
	   
	    echo "Setting Java to 10.0.1"
	    sudo ln -s jdk-10.0.1 current
            ;;
         
        8)
	    cd $JDKDIR
	    pwd

	    if [ -L "$JDKDIR/current" ]; then
	     	echo "Removing current link to `readlink -f $JDKDIR/current`"
	    	sudo rm current
		sync
	    fi	

	    echo "Setting Java to 1.8.0_171"
	    sudo ln -s jdk1.8.0_171 current
            ;;
         
        *)
            echo $"Usage: $0 {8|10}"
            exit 1
 
esac


echo "Current symlink: `readlink -f $JDKDIR/current`"

