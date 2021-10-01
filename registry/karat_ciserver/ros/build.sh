#!/bin/sh

## @file
# Build the KaRaT ROS CI server image.
#
# Copyright (C) 2020 - 2021 Marvin Häuser. All rights reserved.
# Copyright (C) 2020 - 2021 Kaiserslautern Racing Team. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause
##

set -e

# Set the image tag information required for build.
. scripts/set_image_tags.sh

docker build registry/karat_ciserver\
    --tag karat_ciserver_ros:${ROS_TAG}\
    --build-arg BASEIMAGE=karat_ros:${ROS_TAG}
