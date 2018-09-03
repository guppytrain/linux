#!/bin/bash

usage() { echo "USAGE: wait_for_file.sh -t [FILE . . .]"; exit 1; }

# iterate each option
# local OPTIND

i=''
t=''

while getopts "i:t:h" o; do
    case "$o" in
        i)
            i="${OPTARG}"
            ;;
        t)
            t="${OPTARG}"
            ;;
        h)
            usage
            ;;
    esac
done

echo "# Opts supplied: t=$t"

shift $(( OPTIND-1 ))
    
echo "# Args supplied: $#"

# filename[s] required
# [ $(( "$#" )) -eq 0 ] && usage
[ $# -eq 0 ] && usage

default_interval=1
# default_timeout=300
default_timeout=600
max_timeout=${default_timeout}
interval=${i:-${default_interval}}
timeout=${t:-${default_timeout}}

# ready_tag=".ready"

# iterate each argument
while (( "$#" )); do
    count=0
    ready_tag=".ready"
    prev_state=''
    state=''
   
    if [ -f "$1" ]; then
        echo "Wait: $1"
            
        while [ $(( count )) -lt $(( timeout )) ] && [ $(( count )) -lt $(( max_timeout )) ]; do
            (( count++ ))

            state="$(stat -c "%B.%Y" "$1")"

            # echo "Previous state of "$1": $prev_state"
            # echo "Current state of "$1": $state"

            echo "$state"

            if [ "$state" = "$prev_state" ]; then
                # echo "$1 is ready"
                echo "Ready: $1"
                break
            fi

            prev_state="${state}"

            sleep $interval 
        done
    fi

    shift 1
done

