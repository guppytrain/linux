#!/bin/bash

# print out git status
git status -s && 
(
    # select files to commit with fuzzy search
    files="$(git status -s | fzf -m --height=35% --layout=reverse --prompt='File(s): ' | awk '{print $2}' | tr '\n' ' ' | sed -n 's/[[:space:]]\+$//p')"

    # check comments
    [ -z "${files}" ] && 
        echo "No files selected. Aborting..." &&
            sleep 1 &&
                exit 1

    # select comments to use with fuzzy search
    comments="$(cat $DEV_DIR/TODO | fzf -m --height=35% --layout=reverse --prompt='Comment(s): ' | tr '\n' ';' | sed -n 's/;/; /gp')"

    # check comments
    [ -z "${comments}" ] && 
        echo "No comments selected. Aborting..." &&
            sleep 1 &&
                exit 1

    # commit
    printf "%s\nFiles:\n%s\nComments:\n%s\n" "Commiting files and comments" "${files}" "${comments}"

    git commit -m "${comments}" ${files}

    sleep 1 

    # verify latest commit
    git log -2
)
