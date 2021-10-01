#!/bin/sh

## @file
# Run the specified KaRaT user container.
#
# Copyright (C) 2020 - 2021 Marvin Häuser. All rights reserved.
# Copyright (C) 2020 - 2021 Kaiserslautern Racing Team. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause
##

set -e

# Require specification of the base image type.
[ $# -ne 1 ] && { echo "Usage: $0 type"; exit 1; }

# Set the image tag information required for build.
. scripts/set_image_tags.sh

# Create a KaRaT user container if it does not exist.
# Create a new terminal into the KaRaT user container if it exists.
if [ -n "$(sudo docker ps -q -f "status=running" -f "name=karat_user_$1")" ]
then
    # Enter bash of the running container.
    sudo docker exec -it karat_user_$1 /bin/bash
else
    # This argument only works with NVIDIA Container Toolkit.
    # For AMD and Intel Device Redirection is used.
    KARAT_DOCKER_GPU_ARG=""
    if $(sudo docker info|grep -i runtime|grep -q nvidia)
    then
        KARAT_DOCKER_GPU_ARG="--gpus all"
    fi

    # Build the specified KaRaT base containers.
    # TODO: Pull from the registry once deployed.
    sudo -E ./scripts/build_common_images.sh $1

    # Retrieve information on the current user to pass through.
    KARAT_UID=$(id -u $USER)
    KARAT_GID=$(id -g $USER)

    # Set the appropriate IMAGE_TAG based on the image type.
    if [ "$1" = "ros" ] || [ "$1" = "tensorrt_ros" ]; then
        IMAGE_TAG=${ROS_TAG}
    else
        IMAGE_TAG=${UBUNTU_TAG}
    fi

    # Build the specified KaRaT user container.
    sudo docker build user/karat_user\
        --tag karat_user_$1_base:${IMAGE_TAG}\
        --build-arg BASEIMAGE=karat_user_$1_common:${IMAGE_TAG}\
        --build-arg USER=$USER\
        --build-arg UID=$KARAT_UID\
        --build-arg GID=$KARAT_GID
    sudo docker build user/karat_user_$1\
        --tag karat_user_$1:${IMAGE_TAG}\
        --build-arg BASEIMAGE=karat_user_$1_base:${IMAGE_TAG}

    # Set up the persistent HOME directory.
    mkdir -p $HOME/karat_docker/$1/

    # Set the volume arguments only when the respective files exist, as
    # otherwise Docker will create folders for them automatically.
    KARAT_DOCKER_LOCAL_GIT_ARG=""
    if [ -f "$HOME/.gitconfig" ]; then
        KARAT_DOCKER_LOCAL_GIT_ARG="-v $HOME/.gitconfig:$HOME/.gitconfig:ro"
    fi

    KARAT_DOCKER_GLOBAL_GIT_ARG=""
    if [ -f "/etc/gitconfig" ]; then
        KARAT_DOCKER_GLOBAL_GIT_ARG="-v /etc/gitconfig:/etc/gitconfig:ro"
    fi

    KARAT_DOCKER_SVN_ARG=""
    if [ -f "$HOME/.subversion/" ]; then
        KARAT_DOCKER_SVN_ARG="-v $HOME/.subversion/:/home/$USER/.subversion/:ro"
    fi

    KARAT_PULSEAUDIO_ARG=""
    if [ -f "/run/user/$KARAT_UID/pulse/native" ]; then
        KARAT_PULSEAUDIO_ARG="-v /run/user/$KARAT_UID/pulse/native:/run/user/$KARAT_UID/pulse/native:rw"
    fi

    # Launch the specified KaRaT user container.
    sudo docker run --name "karat_user_$1" --rm -it \
        --net=host \
        --device=/dev/dri:/dev/dri \
        -e "DISPLAY=$DISPLAY" \
        -v /etc/group:/etc/group:ro \
        -v /etc/passwd:/etc/passwd:ro \
        -v /etc/shadow:/etc/shadow:ro \
        -v /etc/sudoers.d:/etc/sudoers.d:ro \
        -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
        -v /:/host/:rw \
        -v $HOME/karat_docker/$1/:/home/$USER:rw \
        -v $HOME/.ssh:/home/$USER/.ssh:ro \
        $KARAT_PULSEAUDIO_ARG \
        $KARAT_DOCKER_LOCAL_GIT_ARG \
        $KARAT_DOCKER_GLOBAL_GIT_ARG \
        $KARAT_DOCKER_SVN_ARG \
        $KARAT_DOCKER_GPU_ARG \
        karat_user_$1:${IMAGE_TAG}
fi
