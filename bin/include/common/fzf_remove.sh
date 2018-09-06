#!/bin/bash

[ -f "$HOME/.fzf/uninstall" ] && $HOME/.fzf/uninstall

[ -d "$HOME/.fzf" ] && rm -rf $HOME/.fzf

# insert fzf default command
files=("$HOME/.bashrc" "$HOME/.zshrc"); 

for file in ${files[@]}; do
    match="$([ -f "${file}" ] && cat "${file}" | egrep -o "FZF_DEFAULT_COMMAND=")"

    if [ -n "$match" ] && [ -f "$file" ]; then 
        echo "Removing fzf default command from $file"

        cat "$file" | sed -n "/export FZF_DEFAULT_COMMAND\=/d; w "${file}""
    else
        echo "Nothing to remove in "$file""
    fi
done
