#!/bin/bash

# run the base install
docker_base_install.sh && (
    # copy docker helper script
    cp -f "$CWH/bin/util/sd.sh" "$SHARE_DIR/bin/."

    sleep 3

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

    # create shared volume
    if [ ! -d "${SHARE_DIR}/docker" ]; then
        echo "Creating shared volume: "${SHARE_DIR}/docker""
        mkdir -p "${SHARE_DIR}/docker"
    else
        echo "Reusing existing shared volume: "${SHARE_DIR}/docker""
    fi

    # login
    sudo docker login
) && 
docker_machine_install.sh

