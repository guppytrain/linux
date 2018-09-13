#!/bin/sh

echo "Install docker-machine binaries"

base=https://github.com/docker/machine/releases/download/v0.14.0 &&
    curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine &&
    sudo install /tmp/docker-machine /usr/local/bin/docker-machine

docker-machine version

echo "Install docker-machine completion and prompt"

# either source this file or put it in /etc/bash_completion.d/
# source /etc/bash_completion.d/docker-machine-prompt.bash

base=https://raw.githubusercontent.com/docker/machine/v0.14.0
for i in docker-machine-prompt.bash docker-machine-wrapper.bash docker-machine.bash
do
    sudo wget "$base/contrib/completion/bash/${i}" -P /etc/bash_completion.d
done

# To enable the docker-machine shell prompt, add $(__docker_machine_ps1) to your PS1 setting in ~/.bashrc.
# printf "\n%s\n" "PS1='[\u@\h \W$(__docker_machine_ps1)]\$ '" >> "$HOME/.bashrc"

# NOTE: instead of having this as default prompt, chose to alias this command so can enable/disable the prompt as desired
