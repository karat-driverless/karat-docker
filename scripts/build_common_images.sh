#!/bin/sh

## @file
# Build the specified KaRaT common images.
#
# Copyright (C) 2020 - 2021 Marvin Häuser. All rights reserved.
# Copyright (C) 2020 - 2021 Kaiserslautern Racing Team. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause
##

set -e

# Declare all image locations per type.
CMN_IMAGES='karat_ubuntu'
ROS_IMAGES='karat_ros karat_user_common/ros karat_ciserver/ros'
UE4_IMAGES='karat_ue4_prereq karat_ue4_source karat_ue4_build karat_ue4 karat_user_common/ue4'

# Build only the specified images. Build all by default.
[ $# -eq 0 ] && IMAGE_TYPES='ros ue4' || IMAGE_TYPES=$@

# Build all image stacks defined in $IMAGE_TYPES.
for type in ${IMAGE_TYPES}
do
    # Build all common images.
    for image in ${CMN_IMAGES}
    do
        ./registry/$image/build.sh
    done

    # Build all images for the specified type.
    if [ "${type}" = "ros" ]; then
        for image in ${ROS_IMAGES}
        do
            ./registry/$image/build.sh
        done
    elif [ "${type}" = "ue4" ]; then
        for image in ${UE4_IMAGES}
        do
            ./registry/$image/build.sh
        done
    fi
done
