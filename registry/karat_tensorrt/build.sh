#!/bin/sh

## @file
# Build the preliminary KaRaT TensorRT image.
#
# Copyright (C) 2020 - 2021 Marvin Häuser. All rights reserved.
# Copyright (C) 2020 - 2021 Kaiserslautern Racing Team. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause
##

set -e

# Set the image tag information required for build.
. scripts/set_image_tags.sh

if [ "${UBUNTU_TAG}" != "focal" ]; then
    echo "Cannot build TensorRT for Ubuntu ${UBUNTU_TAG}, need focal." 1>&2
    exit 1
fi

#
# TODO: Create a proper stack when mainstreaming TensorRT.
#

docker build registry/karat_ubuntu\
    --tag karat_tensorrt:20.12-py3\
    --build-arg BASEIMAGE=nvcr.io/nvidia/tensorrt:20.12-py3

docker build registry/karat_ros\
    --tag karat_tensorrt_ros:${ROS_TAG}\
    --build-arg BASEIMAGE=karat_tensorrt:20.12-py3\
    --build-arg UBUNTU_TAG=${UBUNTU_TAG}\
    --build-arg ROS_TAG=${ROS_TAG}\
    --build-arg ROS_PYTHON=${ROS_PYTHON}\
    --build-arg NPROC=${NPROC}

docker build registry/karat_ciserver\
    --tag karat_ciserver_tensorrt_ros:${ROS_TAG}\
    --build-arg BASEIMAGE=karat_tensorrt_ros:${ROS_TAG}

docker build registry/karat_user_common\
    --tag karat_user_tensorrt_ros_common:${ROS_TAG}\
    --build-arg BASEIMAGE=karat_tensorrt_ros:${ROS_TAG}
