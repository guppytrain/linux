#!/bin/bash

# clone the fzf repo
git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf

$HOME/.fzf/install --all

# insert fzf default command
files=("$HOME/.bashrc" "$HOME/.zshrc"); 
for file in ${files[@]}; do
    match="$([ -f "${file}" ] && cat "${file}" | egrep -o "export FZF_DEFAULT_COMMAND=")"

    if [ -z "$match" ] && [ -f "$file" ]; then 
        echo "Inserting fzf default command into "$file""

        # keep the shorter find in case alpine barfs at the longer one
        # printf "\n%s\n%s\n" "# export FZF default command" "export FZF_DEFAULT_COMMAND='find . -maxdepth 10 -type f'" >> $file
        printf "\n%s\n%s\n" "# export FZF default command" "export FZF_DEFAULT_COMMAND='find . -maxdepth 10 -type f -not -path \"*/\.git/*\" -not -path \"*/\.*/*\"'" >> $file
    else
        echo "Nothing to add in "$file", either already added or file not found"
    fi
done

# git fzf helper script
cp -f "$CWH/bin/util/git_fzf_add.sh" "$SHARE_DIR/bin/."
cp -f "$CWH/bin/util/git_fzf_commit.sh" "$SHARE_DIR/bin/."
