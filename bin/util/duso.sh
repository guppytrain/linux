#!/bin/sh

s1="su"
s2="do"

echo "Stripping "${s1}${s2}""

if [ -z "$(which "${s1}${s2}")" ]; then
    echo "Stripping 'sudo' from 'linux' repo"
    $DEV_DIR/linux/bin/util/rp.sh -a "${su}${do}" $DEV_DIR/linux
fi
