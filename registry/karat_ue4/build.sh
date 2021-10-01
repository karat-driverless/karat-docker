#!/bin/sh

## @file
# Build the KaRaT UE4 installed build image.
#
# Copyright (C) 2020 - 2021 Marvin Häuser. All rights reserved.
# Copyright (C) 2020 - 2021 Kaiserslautern Racing Team. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause
##

set -e

# Set the image tag information required for build.
. scripts/set_image_tags.sh

docker build registry/karat_ue4\
    --tag karat_ue4:${UBUNTU_TAG}_${UE4_VER_TAG}\
    --build-arg BUILDIMAGE=karat_ue4_build:${UBUNTU_TAG}_${UE4_VER_TAG}\
    --build-arg BASEIMAGE=karat_ue4_prereq:${UBUNTU_TAG}_${UE4_VER_TAG}
