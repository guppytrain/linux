#!/bin/bash

# run the base install
docker_base_install.sh && (
    # run hello world
    echo "Running hello-world docker image"

    sudo docker run hello-world

    # remove hello world container and image
    echo "Removing hello-world docker image and container"
    CNTRS="$(sudo docker container ls -a -q --filter=ancestor="hello-world")"   

    while IFS= read -r -d $'\n'; do
        [ -n "$REPLY" ] && (
            echo "Removing Container: $REPLY"
            sudo docker container rm "$REPLY"
        )
    done < <(echo "$CNTRS")

    sudo docker image rm "hello-world"
)
