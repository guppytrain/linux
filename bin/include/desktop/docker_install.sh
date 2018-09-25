#!/bin/bash

# run the base install
docker_base_install.sh && (
    # copy docker helper script
    cp -f "$CWH/bin/util/sd.sh" "$SHARE_DIR/bin/."

    [ -n "$USER" ] && (
        echo "Adding group 'docker'"
        sudo groupadd docker

        echo "Adding user to group 'docker'"
        sudo usermod -aG docker $USER

        printf "%s\n" "Group/user changes do not take effect until logging out and logging back in"
        bash -c "read -s -e -p \"[OK]\""
        echo
    ) || echo "USER not defined"
) 

