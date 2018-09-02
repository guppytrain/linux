#!/bin/sh

if [ -z "${DEV_DIR}" ]; then
    \. ../include/env.sh
fi

# NOTE: this approach to prevent rp.sh from stripping the search string form this file
s1="su"
s2="do"
str="${s1}${s2}"

echo "Stripping "${str}""

if [ -z "$(2>/dev/null which "${str}")" ]; then
    echo "Stripping "${str}" from 'linux' repo"
    $DEV_DIR/linux/bin/util/rp.sh -a "${str}" $DEV_DIR/linux
fi
