#!/bin/bash

usage() { echo "USAGE: git_fzf_commit.sh -mf [FILE|DIRECTORY . . .]"; exit 1; }

# iterate each option
# local OPTIND

m=''
f=''

while getopts "m:f:h" o; do
    case "$o" in
        m)
            m="${OPTARG}"
            ;;
        f)
            f="${OPTARG}"
            ;;
        h)
            usage
            ;;
        *)
            usage
            ;;
    esac
done

echo "# Opts supplied: m=$m, f=$f"

shift $(( OPTIND-1 ))
    
echo "# Args supplied: $#"

# print out git status
git status -s && 
(
    # select files to commit with fuzzy search
    files="$(git status -s | fzf -m --height=35% --layout=reverse --prompt='File(s): ' | awk '{print $2}' | tr '\n' ' ' | sed -n 's/[[:space:]]\+$//p')"

    # check comments
    [ -z "${files}" ] && 
        echo "No files selected. Aborting..." &&
            sleep 5 &&
                exit 1

    # select comments to use with fuzzy search
    comments="$(cat $DEV_DIR/TODO | fzf -m --height=35% --layout=reverse --prompt='Comment(s): ' | tr '\n' ';' | sed -n 's/;/; /gp')"

    # check comments
    [ -z "${comments}" ] && 
        echo "No comments selected. Aborting..." &&
            sleep 5 &&
                exit 1

    # commit
    printf "%s\nFiles:\n%s\nComments:\n%s\n" "Commiting files and comments" "${files}" "${comments}"

    git commit -m "${comments}" ${files}

    sleep 1 

    # verify latest commit
    git log -2
)
