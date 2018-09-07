#!/bin/bash

get_docker_container_id ()
{
    # select ids with fuzzy search
    sudo pwd >/dev/null 2>&1 && 
    local id="$(sudo docker container ls --all | fzf -m --height=50% --tac | awk '{print $1}' | tr '\n' ' ' | sed -n 's/[[:space:]]\+$//p')" &&
    echo "$id"
}

get_docker_image_id ()
{
    # select ids with fuzzy search
    sudo pwd >/dev/null 2>&1 && 
    local id="$(sudo docker image ls | fzf -m --height=50% --tac | awk '{print $3}' | tr '\n' ' ' | sed -n 's/[[:space:]]\+$//p')" &&
    echo "$id"
}

get_docker_image_name ()
{
    # select ids with fuzzy search
    sudo pwd >/dev/null 2>&1 && 
    local name="$(sudo docker image ls | fzf -m --height=50% --tac | awk '{print $1":"$2}' | tr '\n' ' ' | sed -n 's/[[:space:]]\+$//p')" &&
    echo "$name"
}

run_docker_image ()
{
    local name="$(get_docker_image_name)"

    # validate
    [ -z "${name}" ] && 
        echo "Nothing selected. Aborting..." ||
    sudo docker run -it $@ $name
}

rm_docker_image ()
{
    local name="$(get_docker_image_name)"

    # validate
    [ -z "${name}" ] && 
        echo "Nothing selected. Aborting..." ||
    sudo docker rm -f $name
}

start_docker_container ()
{
    local id="$(get_docker_container_id)"

    # validate
    [ -z "${id}" ] && 
        echo "Nothing selected. Aborting..." ||
    sudo docker container start -i $id
}

rm_docker_container ()
{
    local id="$(get_docker_container_id)"

    # validate
    [ -z "${id}" ] && 
        echo "Nothing selected. Aborting..." ||
    sudo docker container rm -f $id
}


