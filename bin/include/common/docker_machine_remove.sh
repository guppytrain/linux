#!/bin/sh

# is it there?
dm_cmd="$(command -v docker-machine)"

# To remove all machines: 
[ -n "${dm_cmd}" ] && machines="$(docker-machine ls -q)"
[ -n "${machines}" ] && docker-machine rm -f ${machines} && echo "Removed all machines"

# Remove the executable
[ -n "${dm_cmd}" ] && sudo rm ${dm_cmd} && echo "Removed docker-machine command"


