#!/bin/bash

chunks=()
while IFS= read -r -d $'\0'; do # the space after IFS= is meaningful
    chunks+=("$REPLY")
    # echo "$REPLY"
done < <(cat TODO | tr '\n' '~' | sed -n 's/\~\+/\~/gp' | sed -n 's/\~#/\|#/gp' | tr '~' '\n' | tr '|' '\0')

n=${#chunks[*]}

for (( i = n-1; i >= 0; i-- ))
do
    echo "${chunks[i]}"
    echo ""
done
