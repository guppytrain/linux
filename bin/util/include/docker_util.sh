#!/bin/bash

get_docker_container_id ()
{
    # select ids with fuzzy search
    pwd >/dev/null 2>&1 && 
    local id="$(docker container ls --all | fzf -m --height=50% --tac | awk '{print $1}' | tr '\n' ' ' | sed -n 's/[[:space:]]\+$//p')" &&
    echo "$id"
}

get_docker_image_id ()
{
    # select ids with fuzzy search
    pwd >/dev/null 2>&1 && 
    local id="$(docker image ls $@ | fzf -m --height=50% --tac | awk '{print $3}' | tr '\n' ' ' | sed -n 's/[[:space:]]\+$//p')" &&
    echo "$id"
}

get_docker_image_name ()
{
    # select ids with fuzzy search
    pwd >/dev/null 2>&1 && 
    local name="$(docker image ls $@ | fzf -m --height=50% --tac | awk '{print $1":"$2}' | tr '\n' ' ' | sed -n 's/[[:space:]]\+$//p')" &&
    echo "$name"
}

run_docker_image ()
{
    local name="$(get_docker_image_name)"

    # validate
    [ -z "${name}" ] && 
        echo "Nothing selected. Aborting..." ||
    docker run -it $@ $name
}

rm_docker_image ()
{
    local name="$(get_docker_image_name)"

    # validate
    [ -z "${name}" ] && 
        echo "Nothing selected. Aborting..." ||
    docker image rm -f $name
}

rm_docker_image_all ()
{
    local id="$(get_docker_image_id -a)"

    # validate
    [ -z "${id}" ] && 
        echo "Nothing selected. Aborting..." ||
    docker image rm -f $id
}

start_docker_container ()
{
    local id="$(get_docker_container_id)"

    # validate
    [ -z "${id}" ] && 
        echo "Nothing selected. Aborting..." ||
    docker container start -i $id
}

rm_docker_container ()
{
    local id="$(get_docker_container_id)"

    # validate
    [ -z "${id}" ] && 
        echo "Nothing selected. Aborting..." ||
    docker container rm -f $id
}

be_docker_vm ()
{
    [ -n "$1" ] && eval $(docker-machine env $1)
}

eb_docker_vm ()
{
    eval $(docker-machine env -u)
}

dkmopen ()
{
    [ -n "$1" ] && (
        url="http://$(docker-machine ip $1):${2:-4000}"
        [ -n "${url}" ] && ( [ "$(command -v xdg-open)" ] && xdg-open "${url}" >/dev/null 2>&1 ) || ( [   "$(command -v gnome-open)" ] && gnome-open "${url}" >/dev/null 2>&1 )
    ) || echo "Usage: dkmopen <vm_name> [port]"
}

fdkm ()
{
    local data="$(docker-machine ls)"

    # select files to commit with fuzzy search
    local selections="$(echo "$data" | fzf -m --height=35% --layout=reverse --prompt='Item(s): ' | awk '{print $1}' | tr '\n' ' ' | sed -n 's/[[:space:]]\+$//p')"

    # ensure non-empty
    [ -z "${selections}" ] && 
        echo "No items selected. Aborting..." &&
            sleep 1 &&
                exit 1

    # output selections
    echo "${selections}"
}
