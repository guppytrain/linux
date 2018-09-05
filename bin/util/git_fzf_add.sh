#!/bin/bash

# print out git status
git status && 
(
    # select files to commit with fuzzy search
    files="$(git status -s | fzf -m --height=35% --layout=reverse --prompt='File(s): ' | awk '{print $2}' | tr '\n' ' ' | sed -n 's/[[:space:]]\+$//p')"

    # check filenames
    [ -z "${files}" ] && 
        echo "No files selected. Aborting..." &&
            sleep 1 &&
                exit 1

    # commit
    printf "%s\nFiles:\n%s\n\n" "Adding files" "${files}"

    git add ${files}

    sleep 1 

    # verify latest add
    git status
)
