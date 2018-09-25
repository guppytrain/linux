#!/bin/bash

echo "Docker Removal..."

# group mgmt
if [ -n "$USER" ]; then
    sudo gpasswd -d $USER docker
    sudo groupdel docker
fi

# remove docker via pkg mgr
docker_base_remove.sh && (
    # remove docker help function
    rm "$SHARE_DIR/bin/sd.sh"

    # grab options
    while getopts 'p' o; do
        case "$o" in
            p)
                purge=true
                ;;
            # *)
            #     echo "No options specified."
            #     ;;
        esac
    done

    shift $(( OPTIND-1 ))

    # purge all docker images, containers, volumes, custom config, etc
    if [ "${purge}" = true ]; then
        echo "Purging all docker related remaining stuff"
        sudo rm -rf /var/lib/docker
    else
        echo "Docker related stuff NOT purged: images, containers, volumes, custom config, etc"
    fi

    # NOTE: any edited configuration files must be deleted manually
    echo "NOTE: any edited configuration files must be deleted manually"
)

# remove other docker components / tools
docker_machine_remove.sh

