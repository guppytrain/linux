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

        printf "%s\n" "After logging back in, run 'installers/docker_post_install.sh' to test docker installation, and to install other docker components"
        bash -c "read -s -e -p \"[OK]\""
        echo

        [ -n "$(command -v gnome-session-quit)" ] && gnome-session-quit --logout
    ) || echo "USER not defined"
) 

