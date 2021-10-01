#!/bin/sh

## @file
# Build the KaRaT UE4 user image.
#
# Copyright (C) 2020 - 2021 Marvin Häuser. All rights reserved.
# Copyright (C) 2020 - 2021 Kaiserslautern Racing Team. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause
##

set -e

# Set the image tag information required for build.
. scripts/set_image_tags.sh

docker build registry/karat_user_common\
    --tag karat_user_ue4_common:${UBUNTU_TAG}_${UE4_VER_TAG}\
    --build-arg BASEIMAGE=karat_ue4:${UBUNTU_TAG}_${UE4_VER_TAG}
