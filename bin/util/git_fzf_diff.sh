#!/bin/bash

# while getopts 'abc:x:yz' flag; do
while getopts 'u' flag; do
case "${flag}" in
    u) ui='true' 
        ;;  
    *)
        ;;  
esac
done

shift $(( OPTIND-1 ))

# print out git status
git status && 
(
    # select files to diff with fuzzy search
    files="$(git status -s | fzf -m --height=35% --layout=reverse --prompt='File(s): ' | awk '{print $2}' | tr '\n' ' ' | sed -n 's/[[:space:]]\+$//p')"

    # check filenames
    [ -z "${files}" ] && 
        echo "No files selected. Aborting..." &&
            sleep 1 &&
                exit 1

    # add
    printf "%s\nFiles:\n%s\n\n" "Diffing files" "${files}"

    [ -n "$ui" ] && (git difftool -y HEAD^ ${files} 2>/dev/null &) || git diff HEAD^ ${files}
)
