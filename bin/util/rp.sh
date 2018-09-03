#!/bin/bash

# todo: optimize with associate array / map of "processed" files

usage() { echo "USAGE: replace.sh -abhr [FILE|DIRECTORY . . .]"; exit 1; }

# iterate each option
# local OPTIND

b=""

while getopts "a:b:ch" o; do
    case "$o" in
        a)
            a="${OPTARG}"
            ;;
        b)
            b="${OPTARG}"
            ;;
        c)
            clobber=true
            ;;
        h)
            usage
            ;;
        *)
            usage
            ;;
    esac
done

echo "# Opts supplied: a=$a, b=$b, c=$clobber"

if [ -z "$a" ]; then
    usage
fi

shift $(( OPTIND-1 ))
    
echo "# Args supplied: "$#""

[ $(( $# )) -eq 0 ] && usage

# iterate each argument
while (( "$#" )); do
    if [ -f "$1" ]; then
        [ "$clobber" != true  ] && (
            echo "Backing up file: $1"
            cp "$1" "${1}.bak"
        )

        echo "Processing file: $1"

        # sed -n "s/${a}\s/${b}/g; p" "$1" > "$1"
        ff=$(cat "$1"); sed -n "s/${a}\s/${b}/g; p" <(echo "$ff") > "$1"
    fi

    if [ -d "$1" ]; then
        [ "$clobber" != true  ] && (
            echo "Backing up directory: $1"
            cp -R "$1" "${1}.bak"
        )
        
        echo "Processing directory: $1"

        files=()
        while IFS= read -r -d $'\0'; do # the space after IFS= is meaningful
            # echo "File: $REPLY"
            files+=("$REPLY")
        # done < <(find "$1" -type l,f -not -path "*/\.git/*" -not -name "\.gitignore" -not -name "\.dockerignore" -print0)
        # done < <(find "$1" -type f -not -path "*/\.git/*" -not -name "\.gitignore" -not -name "\.dockerignore" -not -path "*/*\.tar\.*" -print0)
        done < <(find "$1" -type f -not -path "*/\.git/*" -not -name "\.gitignore" -not -name "\.dockerignore" -not -path "*/*\.tar\.*" -not -path "*/*\.gz" -not -path "*/*\.zip" -print0)

        for f in "${files[@]}"; do
            echo "Processing File: $f"
        
            # sed -n "s/${a}\s/${b}/g; p" "$f"
            ff=$(cat "$f"); sed -n "s/${a}\s/${b}/g; p" <(echo "$ff") > "$f"
        done
    fi

    shift 1
done
