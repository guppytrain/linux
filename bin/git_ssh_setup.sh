#!/bin/sh

# must have email passed in
if [ -z "$1" ]; then
	echo "Email address needed but not passed"
	exit 1
fi

# must have name in
if [ -z "$2" ]; then
	echo "Name needed but not passed"
	exit 1
fi

. ./include/env.sh

pinst.sh xclip

# creates if not found, by default
add_ssh_key.sh $@

xclip -selection clipboard "$HOME/.ssh/id_rsa.pub"

# log in to github
url="https://www.github.com/login"

printf "%s\n" "Press ENTER to open GitHub site to log in to GitHub account."
bash -c "read -s -e -p \"[ENTER]\""
echo

[ -n "${url}" ] && ( [ "$(command -v xdg-open)" ] && xdg-open "${url}" >/dev/null 2>&1 ) || ( [ "$(command -v gnome-open)" ] && gnome-open "${url}" >/dev/null 2>&1 )

sleep 3

# register ssh key
url="https://github.com/settings/keys"

printf "%s\n" "Press ENTER to open SSH and GPG keys page.  Create an entry for the RSA public key, already copied into clipboard."
bash -c "read -s -e -p \"[ENTER]\""
echo

[ -n "${url}" ] && ( [ "$(command -v xdg-open)" ] && xdg-open "${url}" >/dev/null 2>&1 ) || ( [ "$(command -v gnome-open)" ] && gnome-open "${url}" >/dev/null 2>&1 )

sleep 3

# test it out
printf "%s\n" "Press ENTER to test logging into github with ssh key."
bash -c "read -s -e -p \"[ENTER]\""
echo

ssh -T git@github.com

# some common git configs
git config --global user.email "$1"
git config --global user.name "$2"

