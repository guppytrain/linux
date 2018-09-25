#!/bin/bash

# login
docker login

# run hello world
echo "Running hello-world docker image"

docker run hello-world

# remove hello world container and image
echo "Removing hello-world docker image and container"
CNTRS="$(docker container ls -a -q --filter=ancestor="hello-world")"   

while IFS= read -r -d $'\n'; do
    [ -n "$REPLY" ] && (
        echo "Removing Container: $REPLY"
        docker container rm "$REPLY"
    )
done < <(echo "$CNTRS")

docker image rm "hello-world"

# create shared volume
if [ ! -d "${SHARE_DIR}/docker" ]; then
    echo "Creating shared volume: "${SHARE_DIR}/docker""
    mkdir -p "${SHARE_DIR}/docker"
else
    echo "Reusing existing shared volume: "${SHARE_DIR}/docker""
fi

# install other docker related tools and components
docker_machine_install.sh
